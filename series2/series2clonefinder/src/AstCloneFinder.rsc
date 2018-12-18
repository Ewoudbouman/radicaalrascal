module AstCloneFinder

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;
import util::Benchmark;
import DateTime;
import IO;
import List;
import util::Math;
import Node;
import Map;
import Set;
import Utils;

import NodeNormalizer;
import CloneUtils;

private int NODE_MASS_THRESHOLD = 40;
private real SIMILARITY_THRESHOLD = 1.0;
private bool SHOW_OUTPUT = false;

/*
 * Parses the AST structure for nodes that can be considered as type X clones.
 * Idea is from Baxter 1998
 */
public lrel[node fst, node snd] findClones(set[Declaration] asts, int cloneType, real similarity, int nodeThreshold=NODE_MASS_THRESHOLD, bool output=true) {

	// set shared parameters
	SIMILARITY_THRESHOLD = similarity;
	NODE_MASS_THRESHOLD = nodeThreshold;
	SHOW_OUTPUT = output;
	
	// Buckets of nodes converted to keys containing lists of nodes which are quite similar (Baxter).
	map[node, list[node]] nodeBuckets = ();

	if (SHOW_OUTPUT) println("    Collecting sub trees");
	
	// Normalize the ast for the non 1 type tests
	if (cloneType != 1) {
		asts = normalizeValues(asts);
	}
	visit(asts) {
		case node n: {
			int mass = subTreeMass(n);
			if(mass >= NODE_MASS_THRESHOLD) {
				// unsetRec: reset all keyword parameters of the node and its children back to their default.
				// this is necessary to compare nodes universally. Ofc we need all the info in the list of nodes so we only use it as keys
				key = unsetRec(n);
				if(!nodeBuckets[key]?) nodeBuckets[key] = [];
				nodeBuckets[key] += n;
			}
		}
	}

	// Sorting the input makes sure smaller subtrees are not added after adding all big trees
	// After some testing it seems sufficient to sort on the domain of the map and thus sorting each and every node is not required
	sortedBuckets = sort(toList(domain(nodeBuckets)), bool(node a, node b){ return subTreeMass(b) > subTreeMass(a); });
	
	//filtering buckets with less than 2 records
	if (SHOW_OUTPUT) println("    Removing buckets with less than 2 records...");
	sortedBuckets = [x | x <- sortedBuckets, size(nodeBuckets[x]) > 1];
	
	// Starting comparisons:
	if (SHOW_OUTPUT) println("    Starting comparisons for <size(sortedBuckets)> buckets...");

	return findClones(nodeBuckets, sortedBuckets);
}

/**
 * Finds all nodes who can be considered as clones within an AST
 * and returns the group of cloned nodes.
 */
public lrel[node, node] findClones(map[node, list[node]] nodeBuckets, list[node] sortedBuckets){
	lrel[node, node] clones = [];
	for(bucket <- sortedBuckets) {
		combos = pairCombos(nodeBuckets[bucket]);
		for(<a,b> <- combos){
			if(similarityScore(a,b) >= SIMILARITY_THRESHOLD) {
				// Deleting possible sub trees already in the clones list. 
				// These must be removed, because we want the biggest nodes possible
				clones = deleteSubTreeClones(clones, a);
				clones = deleteSubTreeClones(clones, b);
				// Finally adding the clone AFTER deleting subs
				clones += <a,b>;
			}
		}
	}
	return clones;
}

/**
 * Removes the nodes from the cloned nodes who are considered to be part
 * of the cloned structure. 
 */
public lrel[node, node] deleteSubTreeClones(lrel[node, node] clones, node x){
	visit(x) {
		case node n : {
			// Skip "child nodes" which are the same as the parent and skip nodes below mass threshold
			// second statement is to disable optimisation for testing purposes.
			if(subTreeMass(n) >= NODE_MASS_THRESHOLD && n != x || NODE_MASS_THRESHOLD == 2 && n != x) {
				for(<fst, snd> <- clones) {
					if(fst == n || snd == n){ 
						clones = delete(clones, indexOf(clones, <fst, snd>));
					}
				}
			}
		}
	}
	return clones;
}


// Answer borrowed from post below and rewritten in Rascal
// https://stackoverflow.com/questions/5360220/how-to-split-a-list-into-pairs-in-all-possible-ways
public lrel[node fst, node snd] pairCombos(list[node] nodes) {
	return [<nodes[i], nodes[j]> | i <- [0..size(nodes)], j <- [(i+1)..size(nodes)]];
}

/**
 * Checks if 2 nodes are considerd similar enough to be considered as a clone pair
 *
 * The similarity is weighted as (2 x S / (2 x S + L + R))
 * with:
 * S = number of shared nodes
 * L = number of different nodes in sub-tree a 
 * R = number of different nodes in sub-tree b
 */
private real similarityScore(node a, node b) {
	list[node] as = [];
	list[node] bs = [];

	// unsetRec is essential for making sure trees are compared correctly 
	visit(a) {
		case node n : as += unsetRec(n);
	}
	visit(b) {
		case node n : bs += unsetRec(n);
	}

	int s = size(as & bs);
	int l = size(as - bs);
	int r = size(bs - as);
	
	return 2.0 * s / (2 * s + l + r);
}

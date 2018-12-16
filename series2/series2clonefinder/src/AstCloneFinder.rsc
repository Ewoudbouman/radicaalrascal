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

import CloneUtils;

// TODO Needs further tweaking between performance and results
private int NODE_MASS_THRESHOLD = 30;
private real SIMILARITY_THRESHOLD = 1.0;
private bool SHOW_OUTPUT = false;

/**
 *
 */
public lrel[node fst, node snd] findType1Clones(M3 project) {
	set[Declaration] asts =  projectAsts(project);
	return findClones(asts);
}

/**
 *
 */
public lrel[node fst, node snd] findType2Clones(M3 project) {
	set[Declaration] asts =  projectAsts(project);
	return findClones(asts, cloneType=2);
}

/**
 *
 */
public lrel[node fst, node snd] findType3Clones(M3 project, real threshold) {
	set[Declaration] asts =  projectAsts(project);
	return findClones(asts, cloneType=3, similarity=threshold);
}

public lrel[node fst, node snd] findClones(set[Declaration] asts, int cloneType=1, bool output=true, real similarity=1.0) {
	SIMILARITY_THRESHOLD = similarity;
	// suppress progress output for tests
	SHOW_OUTPUT = output;
	// Buckets of nodes converted to keys containing lists of nodes which are quite similar. This should provide performance according to Baxter
	map[node, list[node]] nodeBuckets = ();

	if (SHOW_OUTPUT) println("    Collecting sub trees");
	visit(asts) {
		case node n: {
			int mass = subTreeMass(n);
			//println("node mass <mass>");
			//println("node is <n>");

			if(mass > NODE_MASS_THRESHOLD) {
				// normalize the node for type2/3
				if (cloneType != 1) {
					n = normalizeValues(n);
				}
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
 *
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
 *
 */
public lrel[node, node] deleteSubTreeClones(lrel[node, node] clones, node x){
	visit(x) {
		case node n : {
			// Skip "child nodes" which are the same as the parent and skip nodes below mass threshold
			if(subTreeMass(n) > NODE_MASS_THRESHOLD && n != x ) {
				for(<fst, snd> <- clones) {
					if(fst == n || snd == n){ 
						//clones = delete(clones, indexOf(clones, <fst, snd>));
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
 * Similarity=2xS/ (2xS+L+R)
 * where:
 * S = number of shared nodes
 * L = number of different nodes in sub-tree 1 
 * R = number of different nodes in sub-tree 2
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

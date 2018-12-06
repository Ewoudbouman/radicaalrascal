module AstCloneFinder

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;
import IO;
import List;
import util::Math;
import Node;
import Map;
import Set;
import Utils;

// TODO Needs further tweaking between performance and results
private int NODE_MASS_THRESHOLD = 11;

public lrel[node fst, node snd] findType1Clones(M3 project) {

	//This is kind of the start of the algorithm
	set[Declaration] asts =  projectAsts(project);
	
	//List of found clones along the way 
	lrel[node, node] clones = [];
	
	// Buckets of nodes converted to keys containing lists of nodes which are quite similar. This should provide performance according to Baxter
	map[node, list[node]] nodeBuckets = ();
	
	// Keeps track of the key node's masses, so we don't have to calculate it multiple times
	map[node, int] masses = ();
	
	println("    Collecting sub trees");
	visit(asts) {
		case node n: {
			// unsetRec: reset all keyword parameters of the node and its children back to their default.
			// this is necessary to compare nodes universally. Ofc we need all the info in the list of nodes so we only use it as keys
			key = unsetRec(n);
			int mass = subTreeMass(n);
			masses[key] = mass;
			
			if(mass > NODE_MASS_THRESHOLD) {
				if(!nodeBuckets[key]?) nodeBuckets[key] = [];
				nodeBuckets[key] += n;
			}
		}
	}
	
	println("    Sorting sub tree collection");
	// Sorting the input makes sure smaller subtrees are not added after adding all big trees
	// After some testing it seems sufficient to sort on the domain of the map and thus sorting each and every node is not required
	sortedBuckets = sort(toList(domain(nodeBuckets)), bool(node a, node b){ return masses[b] > masses[a]; });
	
	println("    Removing buckets with less than 2 records...");
	//filtering buckets with less than 2 records
	sortedBuckets = [x | x <- sortedBuckets, size(nodeBuckets[x]) > 1];
	
	// Starting comparisons:
	println("    Starting comparisons for <size(sortedBuckets)> buckets...");
	clones = findClones(clones, nodeBuckets, sortedBuckets);
	
	return clones;
}

public lrel[node, node] findClones(lrel[node, node] clones, map[node, list[node]] nodeBuckets, list[node] sortedBuckets){
	for(bucket <- sortedBuckets) {
		combos = pairCombos(nodeBuckets[bucket]);
		for(<a,b> <- combos){
			if(similarityScore(a,b) == 1.0) {
				// Deleting possible sub trees already in the clones list. These must be removed, because we want the biggest nodes possible
				clones = deleteSubTreeClones(clones, a);
				clones = deleteSubTreeClones(clones, b);
				// Finally adding the clone AFTER deleting subs
				clones += <a,b>;
			}
		}
	}
	return clones;
}

// Deleting possible sub trees already in the clones list. These must be removed, because we want the biggest nodes possible
public lrel[node, node] deleteSubTreeClones(lrel[node, node] clones, node x){
	visit(x) {
		case node n : {
			// Skip "child nodes" which are the same as the parent and skip nodes below mass threshold
			if(n != x && subTreeMass(n) > NODE_MASS_THRESHOLD) {
				for(<fst, snd> <- clones) {
					if(fst == n || snd == n){ 
				 		int i;
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

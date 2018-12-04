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

public lrel[loc fst, loc snd] findType1Clones(M3 project) {

	//This is kind of the start of the algorithm
	set[Declaration] asts =  projectAsts(project);
	
	//List of found clones along the way 
	lrel[node, node] clones = [];
	
	// Buckets of nodes converted to keys containing lists of nodes which are quite similar. This should provide performance according to Baxter
	map[node, list[node]] nodeBuckets = ();
	
	// Keeps track of the key node's masses, so we don't have to calculate it multiple times
	map[node, int] masses = ();
	
	println("Collecting sub trees");
	visit(asts) {
		case node n: {
			// unsetRec: reset all keyword parameters of the node and its children back to their default.
			// this is necessary to compare nodes universally. Ofc we need all the info in the list of nodes so we only use it as keys
			key = unsetRec(n);
			int mass = subTreeMass(n);
			masses[key] = mass;
			//TODO the mass threshold here might needs some extra tweaking
			if(mass > 7) {
				if(!nodeBuckets[key]?) nodeBuckets[key] = [];
				nodeBuckets[key] += n;
			}
		}
	}
	
	println("Sorting sub tree collection");
	// Sorting the input makes sure smaller subtrees are not added after adding all big trees
	// After some testing it seems sufficient to sort on the domain of the map and thus sorting each and every node is not required
	sortedBuckets = sort(toList(domain(nodeBuckets)), bool(node a, node b){ return masses[b] > masses[a]; });
	
	// Starting comparisons:
	for(bucket <- sortedBuckets) {
		for(<a,b> <- pairCombos(nodeBuckets[bucket])){
			if(similarityScore(a,b) == 1.0) {
				// Deleting possible sub trees already in the clones list. These must be removed, because we want the biggest nodes possible
				visit(a) {
					case node n : {
						// Skip "child nodes" which are the same as the parent
						if(n != a) {
							for(<fst, snd> <- clones) {
								if(fst == n || snd == n){ 
							 		int i;
									clones = delete(clones, indexOf(clones, <fst, snd>));
								}
							}
						}
					}
				}
				visit(b) {
					case node n : {
						// Skip "child nodes" which are the same as the parent
						if(n != b) {
							for(<fst, snd> <- clones) {
								if(fst == n || snd == n){ 
							 		int i;
									clones = delete(clones, indexOf(clones, <fst, snd>));
								}
							}
						}
					}
				}
				// Finally adding the clone AFTER deleting subs
				clones += <a,b>;
			}
		}
	}
	
	// TODO: return clones
	println("Found clones");
	for(<x, y> <- clones) {
		println("Pair of:");
		printNodeSource(x);
		println("Matching with:");
		printNodeSource(y);
		println();
	}
	return [];
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

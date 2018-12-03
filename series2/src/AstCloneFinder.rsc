module AstCloneFinder

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;
import IO;
import List;
import util::Math;
import Node;
import Map;
import Utils;

public lrel[loc fst, loc snd] findType1Clones(M3 project) {
	set[Declaration] asts =  projectAsts(project);
	lrel[node, node] clones = [];
	map[node, list[node]] nodeBuckets = (); 
	
	visit(asts) {
		case node n: {
			// unsetRec: reset all keyword parameters of the node and its children back to their default.
			// this is necessary to compare nodes universally. Ofc we need all the info in the list of nodes so we only use it as keys
			key = unsetRec(n);
			
			//TODO the mass threshold here might needs some extra tweaking
			if(subTreeMass(n) > 6) {
				if(!nodeBuckets[key]?) nodeBuckets[key] = [];
				nodeBuckets[key] += n;
			}
		}
	}
	
	// Sorting the input makes sure smaller subtrees are not added after adding all big trees
	//list[node] sortedTrees = sort(subTrees, bool(node x, node y) { return subTreeMass(x) < subTreeMass(y); });
	
	for(bucket <- domain(nodeBuckets)) {
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

module tests::duplication::types::type2

import tests::duplication::types::TypeResources;
import CloneUtils;
import AstCloneFinder;

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;
import IO;
import List;
import Map;
import Set;
import Utils;
import util::Math;

// NODE_MASS_THRESHOLD = 20;
private int clones = 1;
private real SIMILARITY_THRESHOLD = 0.8;

/**
 * Tests based on scenarios listed in the paper:
 * Scenario-Based Comparison of Clone Detection Techniques 
 * by
 * Chanchal K. Roy and James R. Cordy
 */

/**
 * Tests if the type 2 cases are NOT type 1 clones of eachother
 */
 
test bool T2A_T2B() {
	list [loc] snippets = [t2A, t2B];
	return (checkType1Clones(snippets) != clones);
}

test bool T2A_T2C() {
	list [loc] snippets = [t2A, t2C];
	return (checkType1Clones(snippets) != clones);
}

test bool T2A_T2D() {
	list [loc] snippets = [t2A, t2D];
	return (checkType1Clones(snippets) != clones);
}

/**
 * Tests if the type 2 cases are type 2 clones of eachother when normalized
 */
 
test bool T2A_T2B() {
	list [loc] snippets = [t2A, t2B];
	return (checkType2Clones(snippets) == clones);
}

test bool T2A_T2C() {
	list [loc] snippets = [t2A, t2C];
	return (checkType2Clones(snippets) == clones);
}

test bool T2A_T2D() {
	list [loc] snippets = [t2A, t2D];
	return (checkType2Clones(snippets) == clones);
}

/**
 * Tests if the type 2 cases are ALSO type 3 clones of eachother when normalized
 */
test bool T2A_T2B() {
	list [loc] snippets = [t2A, t2B];
	return (checkType3Clones(snippets, SIMILARITY_THRESHOLD) == clones);
}

test bool T2A_T2C() {
	list [loc] snippets = [t2A, t2C];
	return (checkType3Clones(snippets, SIMILARITY_THRESHOLD) == clones);
}

test bool T2A_T2D() {
	list [loc] snippets = [t2A, t2D];
	return (checkType3Clones(snippets, SIMILARITY_THRESHOLD) == clones);
}

 

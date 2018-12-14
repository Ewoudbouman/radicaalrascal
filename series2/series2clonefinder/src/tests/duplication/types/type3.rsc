module tests::duplication::types::type3

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
 * Tests if the type 3 cases are NOT type 1 clones of eachother
 */
 
test bool T3A_T3B() {
	list [loc] snippets = [t3A, t3B];
	return (checkType1Clones(snippets) != clones);
}

test bool T3A_T3C() {
	list [loc] snippets = [t3A, t3C];
	return (checkType1Clones(snippets) != clones);
}

test bool T3A_T3D() {
	list [loc] snippets = [t3A, t3D];
	return (checkType1Clones(snippets) != clones);
}

test bool T3A_T3E() {
	list [loc] snippets = [t3A, t3D];
	return (checkType1Clones(snippets) != clones);
}

test bool T3B_T3C() {
	list [loc] snippets = [t3B, t3C];
	return (checkType1Clones(snippets) != clones);
}

test bool T3B_T3D() {
	list [loc] snippets = [t3B, t3D];
	return (checkType1Clones(snippets) != clones);
}

test bool T3B_T3E() {
	list [loc] snippets = [t3B, t3D];
	return (checkType1Clones(snippets) != clones);
}

test bool T3C_T3D() {
	list [loc] snippets = [t3C, t3D];
	return (checkType1Clones(snippets) != clones);
}

test bool T3C_T3E() {
	list [loc] snippets = [t3C, t3D];
	return (checkType1Clones(snippets) != clones);
}


/**
 * Tests if the type 3 cases are NOT type 2 clones of eachother
 */
 
test bool T3A_T3B() {
	list [loc] snippets = [t3A, t3B];
	return (checkType2Clones(snippets) != clones);
}

test bool T3A_T3C() {
	list [loc] snippets = [t3A, t3C];
	return (checkType2Clones(snippets) != clones);
}

test bool T3A_T3D() {
	list [loc] snippets = [t3A, t3D];
	return (checkType2Clones(snippets) != clones);
}

test bool T3A_T3E() {
	list [loc] snippets = [t3A, t3D];
	return (checkType2Clones(snippets) != clones);
}

test bool T3B_T3C() {
	list [loc] snippets = [t3B, t3C];
	return (checkType2Clones(snippets) != clones);
}

test bool T3B_T3D() {
	list [loc] snippets = [t3B, t3D];
	return (checkType2Clones(snippets) != clones);
}

test bool T3B_T3E() {
	list [loc] snippets = [t3B, t3D];
	return (checkType2Clones(snippets) != clones);
}

test bool T3C_T3D() {
	list [loc] snippets = [t3C, t3D];
	return (checkType2Clones(snippets) != clones);
}

test bool T3C_T3E() {
	list [loc] snippets = [t3C, t3D];
	return (checkType2Clones(snippets) != clones);
}

/**
 * Tests if the type 3 cases are type 3 clones of eachother
 */
 
test bool T3A_T3B() {
	list [loc] snippets = [t3A, t3B];
	return (checkType3Clones(snippets, SIMILARITY_THRESHOLD) == clones);
}

test bool T3A_T3C() {
	list [loc] snippets = [t3A, t3C];
	return (checkType3Clones(snippets, SIMILARITY_THRESHOLD) == clones);
}

test bool T3A_T3D() {
	list [loc] snippets = [t3A, t3D];
	return (checkType3Clones(snippets, SIMILARITY_THRESHOLD) == clones);
}

test bool T3A_T3E() {
	list [loc] snippets = [t3A, t3D];
	return (checkType3Clones(snippets, SIMILARITY_THRESHOLD) == clones);
}

test bool T3B_T3C() {
	list [loc] snippets = [t3B, t3C];
	return (checkType3Clones(snippets, SIMILARITY_THRESHOLD) == clones);
}

test bool T3B_T3D() {
	list [loc] snippets = [t3B, t3D];
	return (checkType3Clones(snippets, SIMILARITY_THRESHOLD) == clones);
}

test bool T3B_T3E() {
	list [loc] snippets = [t3B, t3D];
	return (checkType3Clones(snippets, SIMILARITY_THRESHOLD) == clones);
}

test bool T3C_T3D() {
	list [loc] snippets = [t3C, t3D];
	return (checkType3Clones(snippets, SIMILARITY_THRESHOLD) == clones);
}

test bool T3C_T3E() {
	list [loc] snippets = [t3C, t3D];
	return (checkType3Clones(snippets, SIMILARITY_THRESHOLD) == clones);
}
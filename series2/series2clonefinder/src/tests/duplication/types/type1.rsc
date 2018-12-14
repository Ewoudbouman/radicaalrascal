module tests::duplication::types::type1

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
 * Tests if the type 1 cases are correctly marked as type 1 clones of eachother.
 */
test bool T1A_T1B() {
	list [loc] snippets = [t1A, t1B];
	return (checkType1Clones(snippets) == clones);
}

test bool T1A_T1C() {
	list [loc] snippets = [t1A, t1C];
	return (checkType1Clones(snippets) == clones);
}

test bool T1B_T1C() {
	list [loc] snippets = [t1B, t1C];
	return (checkType1Clones(snippets) == clones);
}

/**
 * Tests if the type 1 cases are ALSO correctly marked as type 2 clones of eachother.
 */
 
 test bool T1A_T1B() {
	list [loc] snippets = [t1A, t1B];
	return (checkType2Clones(snippets) == clones);
}

test bool T1A_T1C() {
	list [loc] snippets = [t1A, t1C];
	return (checkType2Clones(snippets) == clones);
}

test bool T1B_T1C() {
	list [loc] snippets = [t1B, t1C];
	return (checkType2Clones(snippets) == clones);
}
 
 /**
 * Tests if the type 1 cases are ALSO correctly marked as type 3 clones of eachother.
 */

 test bool T1A_T1B() {
	list [loc] snippets = [t1A, t1B];
	return (checkType3Clones(snippets, SIMILARITY_THRESHOLD) == clones);
}

test bool T1A_T1C() {
	list [loc] snippets = [t1A, t1C];
	return (checkType3Clones(snippets, SIMILARITY_THRESHOLD) == clones);
}

test bool T1B_T1C() {
	list [loc] snippets = [t1B, t1C];
	return (checkType3Clones(snippets, SIMILARITY_THRESHOLD) == clones);
}

/**
 * Tests where the files are NOT type 1 clones of eachother.
 *
 * Compares type 1 cases with type 2 cases
 */

test bool T1A_T2A() {
	list [loc] snippets = [t1A, t2A];
	return (checkType1Clones(snippets) != clones);
}

test bool T1A_T2B() {
	list [loc] snippets = [t1A, t2B];
	return (checkType1Clones(snippets) != clones);
}

test bool T1A_T2C() {
	list [loc] snippets = [t1A, t2C];
	return (checkType1Clones(snippets) != clones);
}

test bool T1A_T2D() {
	list [loc] snippets = [t1A, t2D];
	return (checkType1Clones(snippets) != clones);
}

test bool T1B_T2A() {
	list [loc] snippets = [t1B, t2A];
	return (checkType1Clones(snippets) != clones);
}

test bool T1B_T2B() {
	list [loc] snippets = [t1B, t2B];
	return (checkType1Clones(snippets) != clones);
}

test bool T1B_T2C() {
	list [loc] snippets = [t1B, t2C];
	return (checkType1Clones(snippets) != clones);
}

test bool T1B_T2D() {
	list [loc] snippets = [t1B, t2D];
	return (checkType1Clones(snippets) != clones);
}

test bool T1C_T2A() {
	list [loc] snippets = [t1C, t2A];
	return (checkType1Clones(snippets) != clones);
}

test bool T1C_T2B() {
	list [loc] snippets = [t1C, t2B];
	return (checkType1Clones(snippets) != clones);
}

test bool T1C_T2C() {
	list [loc] snippets = [t1C, t2C];
	return (checkType1Clones(snippets) != clones);
}

test bool T1C_T2D() {
	list [loc] snippets = [t1C, t2D];
	return (checkType1Clones(snippets) != clones);
}

/**
 * Tests where the files are NOT type 1 clones of eachother.
 * Check if the our solution marks them as the correct number of clones.
 *
 * Compares type 1 cases with type 3 cases
 */
 
 test bool T1A_T3A() {
	list [loc] snippets = [t1A, t3A];
	return (checkType1Clones(snippets) != clones);
}

test bool T1A_T3B() {
	list [loc] snippets = [t1A, t3B];
	return (checkType1Clones(snippets) != clones);
}

test bool T1A_T3C() {
	list [loc] snippets = [t1A, t3C];
	return (checkType1Clones(snippets) != clones);
}

test bool T1A_T3D() {
	list [loc] snippets = [t1A, t3D];
	return (checkType1Clones(snippets) != clones);
}

test bool T1A_T3E() {
	list [loc] snippets = [t1A, t3E];
	return (checkType1Clones(snippets) != clones);
}

test bool T1B_T3A() {
	list [loc] snippets = [t1B, t3A];
	return (checkType1Clones(snippets) != clones);
}

test bool T1B_T3B() {
	list [loc] snippets = [t1B, t3B];
	return (checkType1Clones(snippets) != clones);
}

test bool T1B_T3C() {
	list [loc] snippets = [t1B, t3C];
	return (checkType1Clones(snippets) != clones);
}

test bool T1B_T3D() {
	list [loc] snippets = [t1B, t3D];
	return (checkType1Clones(snippets) != clones);
}

test bool T1B_T3E() {
	list [loc] snippets = [t1B, t3E];
	return (checkType1Clones(snippets) != clones);
}

test bool T1C_T3A() {
	list [loc] snippets = [t1C, t3A];
	return (checkType1Clones(snippets) != clones);
}

test bool T1C_T3B() {
	list [loc] snippets = [t1C, t3B];
	return (checkType1Clones(snippets) != clones);
}

test bool T1C_T3C() {
	list [loc] snippets = [t1C, t3C];
	return (checkType1Clones(snippets) != clones);
}

test bool T1C_T3D() {
	list [loc] snippets = [t1C, t3D];
	return (checkType1Clones(snippets) != clones);
}

test bool T1C_T3E() {
	list [loc] snippets = [t1C, t3E];
	return (checkType1Clones(snippets) != clones);
}
 
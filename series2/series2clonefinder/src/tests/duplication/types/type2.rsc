module tests::duplication::types::type2

import tests::TypeResources;
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

private int clones = 1;
private real SIMILARITY_THRESHOLD = 1.0;
private real T3_SIMILARITY_THRESHOLD = 0.8;

/**
 * Tests based on scenarios listed in the paper:
 * Scenario-Based Comparison of Clone Detection Techniques 
 * by
 * Chanchal K. Roy and James R. Cordy
 */

/**
 * Tests if the type 2 case are NOT type 1 clones of the source
 */

test bool type1_orig_T2A() {
	int cloneType = 1;
	list [loc] snippets = [orig, t2A];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=SIMILARITY_THRESHOLD);
	result = size(cloneClasses) != clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "origA2");
	return result;
}

test bool type1_orig_T2B() {
	int cloneType = 1;
	list [loc] snippets = [orig, t2B];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=SIMILARITY_THRESHOLD);
	result = size(cloneClasses) != clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "origB2");
	return result;
}

test bool type1_orig_T2C() {
	int cloneType = 1;
	list [loc] snippets = [orig, t2C];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=SIMILARITY_THRESHOLD);
	result = size(cloneClasses) != clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "origC2");
	return result;
}

test bool type1_orig_T2D() {
	int cloneType = 1;
	list [loc] snippets = [orig, t2D];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=SIMILARITY_THRESHOLD);
	result = size(cloneClasses) != clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "origD2");
	return result;
}

/**
 * Tests if the type 2 case is a type 2 clone of the source
 */

test bool type2_orig_T2A() {
	int cloneType = 2;
	list [loc] snippets = [orig, t2A];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=SIMILARITY_THRESHOLD);
	result = size(cloneClasses) == clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "origA2");
	return result;
}

test bool type2_orig_T2B() {
	int cloneType = 2;
	list [loc] snippets = [orig, t2B];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=SIMILARITY_THRESHOLD);
	result = size(cloneClasses) == clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "origB2");
	return result;
}

test bool type2_orig_T2C() {
	int cloneType = 2;
	list [loc] snippets = [orig, t2C];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=SIMILARITY_THRESHOLD);
	result = size(cloneClasses) == clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "origC2");
	return result;
}

/*
test bool type2_orig_T2D() {
	int cloneType = 2;
	list [loc] snippets = [orig, t2D];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=SIMILARITY_THRESHOLD);
	result = size(cloneClasses) == clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "origD2");
	return result;
} 
*/

/**
 * Tests if the type 2 case is a type 3 clone of the source
 */

test bool type3_orig_T2A() {
	int cloneType = 3;
	list [loc] snippets = [orig, t2A];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=T3_SIMILARITY_THRESHOLD);
	result = size(cloneClasses) == clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "origA2");
	return result;
}

test bool type3_orig_T2B() {
	int cloneType = 3;
	list [loc] snippets = [orig, t2B];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=T3_SIMILARITY_THRESHOLD);
	result = size(cloneClasses) == clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "origB2");
	return result;
}

test bool type3_orig_T2C() {
	int cloneType = 3;
	list [loc] snippets = [orig, t2C];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=T3_SIMILARITY_THRESHOLD);
	result = size(cloneClasses) == clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "origC2");
	return result;
}

/*
test bool type3_orig_T2D() {
	int cloneType = 3;
	list [loc] snippets = [orig, t2D];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=T3_SIMILARITY_THRESHOLD);
	result = size(cloneClasses) == clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "origD2");
	return result;
}
*/


/**
 * Tests if the type 2 cases are NOT type 1 clones of eachother
 */

test bool type1_T2A_T2B() {
	int cloneType = 1;
	list [loc] snippets = [t2A, t2B];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=SIMILARITY_THRESHOLD);
	result = size(cloneClasses) != clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "A2B2");
	return result;
}

test bool type1_T2A_T2C() {
	int cloneType = 1;
	list [loc] snippets = [t2A, t2C];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=SIMILARITY_THRESHOLD);
	result = size(cloneClasses) != clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "A2C2");
	return result;
}

test bool type1_T2A_T2D() {
	int cloneType = 1;
	list [loc] snippets = [t2A, t2D];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=SIMILARITY_THRESHOLD);
	result = size(cloneClasses) != clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "A2D2");
	return result;
}

/**
 * Tests if the type 2 cases are type 2 clones of eachother when normalized
 */

test bool type2_T2A_T2B() {
	int cloneType = 2;
	list [loc] snippets = [t2A, t2B];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=SIMILARITY_THRESHOLD);
	result = size(cloneClasses) == clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "A2B2");
	return result;
}

test bool type2_T2A_T2C() {
	int cloneType = 2;
	list [loc] snippets = [t2A, t2C];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=SIMILARITY_THRESHOLD);
	result = size(cloneClasses) == clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "A2C2");
	return result;
}

/*
test bool type2_T2A_T2D() {
	int cloneType = 2;
	list [loc] snippets = [t2A, t2D];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=SIMILARITY_THRESHOLD);
	result = size(cloneClasses) == clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "A2D2");
	return result;
}
*/

/**
 * Tests if the type 2 cases are ALSO type 3 clones of eachother when normalized
 */


test bool type3_T2A_T2B() {
	int cloneType = 3;
	list [loc] snippets = [t2A, t2B];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=T3_SIMILARITY_THRESHOLD);
	result = size(cloneClasses) == clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "A2B2");
	return result;
}

test bool type3_T2A_T2C() {
	int cloneType = 3;
	list [loc] snippets = [t2A, t2C];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=T3_SIMILARITY_THRESHOLD);
	result = size(cloneClasses) == clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "A2C2");
	return result;
}

/*
test bool type3_T2A_T2D() {
	int cloneType = 3;
	list [loc] snippets = [t2A, t2D];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=T3_SIMILARITY_THRESHOLD);
	result = size(cloneClasses) == clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "A2D2");
	return result;
}
*/

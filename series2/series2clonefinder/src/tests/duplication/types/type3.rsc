module tests::duplication::types::type3

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
 * Tests if the type 3 cases are NOT type 1 clones of the source
 */

test bool type1_orig_T3A() {
	int cloneType = 1;
	list [loc] snippets = [orig, t3A];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=SIMILARITY_THRESHOLD);
	result = size(cloneClasses) != clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "origA3");
	return result;
}

test bool type1_orig_T3B() {
	int cloneType = 1;
	list [loc] snippets = [orig, t3B];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=SIMILARITY_THRESHOLD);
	result = size(cloneClasses) != clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "origB3");
	return result;
}

test bool type1_orig_T3C() {
	int cloneType = 1;
	list [loc] snippets = [orig, t3C];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=SIMILARITY_THRESHOLD);
	result = size(cloneClasses) != clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "origC3");
	return result;
}

test bool type1_orig_T3D() {
	int cloneType = 1;
	list [loc] snippets = [orig, t3D];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=SIMILARITY_THRESHOLD);
	result = size(cloneClasses) != clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "origD3");
	return result;
}

test bool type1_orig_T3E() {
	int cloneType = 1;
	list [loc] snippets = [orig, t3D];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=SIMILARITY_THRESHOLD);
	result = size(cloneClasses) != clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "origE3");
	return result;
}

/**
 * Tests if the type 3 cases are NOT type 2 clones of the source
 */

test bool type2_orig_T3A() {
	int cloneType = 2;
	list [loc] snippets = [orig, t3A];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=SIMILARITY_THRESHOLD);
	result = size(cloneClasses) != clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "origA3");
	return result;
}

test bool type2_orig_T3B() {
	int cloneType = 2;
	list [loc] snippets = [orig, t3B];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=SIMILARITY_THRESHOLD);
	result = size(cloneClasses) != clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "origB3");
	return result;
}

test bool type2_orig_T3C() {
	int cloneType = 2;
	list [loc] snippets = [orig, t3C];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=SIMILARITY_THRESHOLD);
	result = size(cloneClasses) != clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "origC3");
	return result;
}

test bool type2_orig_T3D() {
	int cloneType = 2;
	list [loc] snippets = [orig, t3D];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=SIMILARITY_THRESHOLD);
	result = size(cloneClasses) != clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "origD3");
	return result;
}

test bool type2_orig_T3E() {
	int cloneType = 2;
	list [loc] snippets = [orig, t3D];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=SIMILARITY_THRESHOLD);
	result = size(cloneClasses) != clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "origE3");
	return result;
}

/**
 * Tests if the type 3 cases are type 3 clones of the source
 */


test bool type3_orig_T3A() {
	int cloneType = 3;
	list [loc] snippets = [orig, t3A];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=T3_SIMILARITY_THRESHOLD);
	result = size(cloneClasses) == clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "origA3");
	return result;
}

test bool type3_orig_T3B() {
	int cloneType = 3;
	list [loc] snippets = [orig, t3B];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=T3_SIMILARITY_THRESHOLD);
	result = size(cloneClasses) == clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "origB3");
	return result;
}

test bool type3_orig_T3C() {
	int cloneType = 3;
	list [loc] snippets = [orig, t3C];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=T3_SIMILARITY_THRESHOLD);
	result = size(cloneClasses) == clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "origC3");
	return result;
}

test bool type3_orig_T3D() {
	int cloneType = 3;
	list [loc] snippets = [orig, t3D];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=T3_SIMILARITY_THRESHOLD);
	result = size(cloneClasses) == clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "origD3");
	return result;
}

test bool type3_orig_T3E() {
	int cloneType = 3;
	list [loc] snippets = [orig, t3D];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=T3_SIMILARITY_THRESHOLD);
	result = size(cloneClasses) == clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "origE3");
	return result;
}

/**
 * Tests if the type 3 cases are NOT type 1 clones of eachother
 */


test bool type1_T3A_T3B() {
	int cloneType = 1;
	list [loc] snippets = [t3A, t3B];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=SIMILARITY_THRESHOLD);
	result = size(cloneClasses) != clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "A3B3");
	return result;
}

test bool type1_T3A_T3C() {
	int cloneType = 1;
	list [loc] snippets = [t3A, t3C];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=SIMILARITY_THRESHOLD);
	result = size(cloneClasses) != clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "A3C3");
	return result;
}

test bool type1_T3A_T3D() {
	int cloneType = 1;
	list [loc] snippets = [t3A, t3D];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=SIMILARITY_THRESHOLD);
	result = size(cloneClasses) != clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "A3D3");
	return result;
}

test bool type1_T3A_T3E() {
	int cloneType = 1;
	list [loc] snippets = [t3A, t3D];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=SIMILARITY_THRESHOLD);
	result = size(cloneClasses) != clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "A3E3");
	return result;
}

test bool type1_T3B_T3C() {
	int cloneType = 1;
	list [loc] snippets = [t3B, t3C];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=SIMILARITY_THRESHOLD);
	result = size(cloneClasses) != clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "B3C3");
	return result;
}

test bool type1_T3B_T3D() {
	int cloneType = 1;
	list [loc] snippets = [t3B, t3D];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=SIMILARITY_THRESHOLD);
	result = size(cloneClasses) != clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "B3D3");
	return result;
}

test bool type1_T3B_T3E() {
	int cloneType = 1;
	list [loc] snippets = [t3B, t3D];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=SIMILARITY_THRESHOLD);
	result = size(cloneClasses) != clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "B3E3");
	return result;
}

test bool type1_T3C_T3D() {
	int cloneType = 1;
	list [loc] snippets = [t3C, t3D];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=SIMILARITY_THRESHOLD);
	result = size(cloneClasses) != clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "C3D3");
	return result;
}

test bool type1_T3C_T3E() {
	int cloneType = 1;
	list [loc] snippets = [t3C, t3D];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=SIMILARITY_THRESHOLD);
	result = size(cloneClasses) != clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "C3E3");
	return result;
}


/**
 * Tests if the type 3 cases are NOT type 2 clones of eachother
 */
 

test bool type2_T3A_T3B() {
	int cloneType = 2;
	list [loc] snippets = [t3A, t3B];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=SIMILARITY_THRESHOLD);
	result = size(cloneClasses) != clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "A3B3");
	return result;
}

test bool type2_T3A_T3C() {
	int cloneType = 2;
	list [loc] snippets = [t3A, t3C];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=SIMILARITY_THRESHOLD);
	result = size(cloneClasses) != clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "A3C3");
	return result;
}

test bool type2_T3A_T3D() {
	int cloneType = 2;
	list [loc] snippets = [t3A, t3D];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=SIMILARITY_THRESHOLD);
	result = size(cloneClasses) != clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "A3D3");
	return result;
}

test bool type2_T3A_T3E() {
	int cloneType = 2;
	list [loc] snippets = [t3A, t3D];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=SIMILARITY_THRESHOLD);
	result = size(cloneClasses) != clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "A3E3");
	return result;
}

test bool type2_T3B_T3C() {
	int cloneType = 2;
	list [loc] snippets = [t3B, t3C];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=SIMILARITY_THRESHOLD);
	result = size(cloneClasses) != clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "B3C3");
	return result;
}

test bool type2_T3B_T3D() {
	int cloneType = 2;
	list [loc] snippets = [t3B, t3D];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=SIMILARITY_THRESHOLD);
	result = size(cloneClasses) != clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "B3D3");
	return result;
}

test bool type2_T3B_T3E() {
	int cloneType = 2;
	list [loc] snippets = [t3B, t3D];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=SIMILARITY_THRESHOLD);
	result = size(cloneClasses) != clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "B3E3");
	return result;
}

test bool type2_T3C_T3D() {
	int cloneType = 2;
	list [loc] snippets = [t3C, t3D];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=SIMILARITY_THRESHOLD);
	result = size(cloneClasses) != clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "C3D3");
	return result;
}

test bool type2_T3C_T3E() {
	int cloneType = 2;
	list [loc] snippets = [t3C, t3D];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=SIMILARITY_THRESHOLD);
	result = size(cloneClasses) != clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "C3E3");
	return result;
}

/**
 * Tests if the type 3 cases are type 3 clones of eachother
 */


test bool type3_T3A_T3B() {
	int cloneType = 3;
	list [loc] snippets = [t3A, t3B];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=T3_SIMILARITY_THRESHOLD);
	result = size(cloneClasses) == clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "A3B3");
	return result;
}

test bool type3_T3A_T3C() {
	int cloneType = 3;
	list [loc] snippets = [t3A, t3C];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=T3_SIMILARITY_THRESHOLD);
	result = size(cloneClasses) == clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "A3C3");
	return result;
}

test bool type3_T3A_T3D() {
	int cloneType = 3;
	list [loc] snippets = [t3A, t3D];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=T3_SIMILARITY_THRESHOLD);
	result = size(cloneClasses) == clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "A3D3");
	return result;
}

test bool type3_T3A_T3E() {
	int cloneType = 3;
	list [loc] snippets = [t3A, t3D];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=T3_SIMILARITY_THRESHOLD);
	result = size(cloneClasses) == clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "A3E3");
	return result;
}

test bool type3_T3B_T3C() {
	int cloneType = 3;
	list [loc] snippets = [t3B, t3C];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=T3_SIMILARITY_THRESHOLD);
	result = size(cloneClasses) == clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "B3C3");
	return result;
}

test bool type3_T3B_T3D() {
	int cloneType = 3;
	list [loc] snippets = [t3B, t3D];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=T3_SIMILARITY_THRESHOLD);
	result = size(cloneClasses) == clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "B3D3");
	return result;
}

test bool type3_T3B_T3E() {
	int cloneType = 3;
	list [loc] snippets = [t3B, t3D];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=T3_SIMILARITY_THRESHOLD);
	result = size(cloneClasses) == clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "B3E3");
	return result;
}

test bool type3_T3C_T3D() {
	int cloneType = 3;
	list [loc] snippets = [t3C, t3D];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=T3_SIMILARITY_THRESHOLD);
	result = size(cloneClasses) == clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "C3D3");
	return result;
}

test bool type3_T3C_T3E() {
	int cloneType = 3;
	list [loc] snippets = [t3C, t3D];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=T3_SIMILARITY_THRESHOLD);
	result = size(cloneClasses) == clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "C3E3");
	return result;
}

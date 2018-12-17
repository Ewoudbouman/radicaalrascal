module tests::duplication::types::FutureWork

import tests::TypeResources;
import CloneUtils;
import AstCloneFinder;
import CloneIO;

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;
import IO;
import List;
import String;
import Map;
import Set;
import Utils;
import util::Math;

private int clones = 1;
private real SIMILARITY_THRESHOLD = 1.0;
private real T3_SIMILARITY_THRESHOLD = 0.8;

/**
 * Case 1:
 *
 * All covered
 */
 
/**
 * Case 2: 
 *
 * Scenario S2(d) (t2/CopyTwoD.java) is not covered
 * see W. Evans and C. Fraser. Clone Detection via Structural Abstraction In WCRE, pp. 150-159, 2007
 */

// Tests if the type 2 cases are type 2 clones of the source 
/*
test bool type2_orig_T2D() {
	int cloneType = 2;
	list [loc] snippets = [orig, t2D];
	cloneClasses = checkTypeXClones(snippets, cloneType);
	result = size(cloneClasses) == clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "origD2");
	return result;
}  

test bool type2_T2A_T2D() {
	int cloneType = 2;
	list [loc] snippets = [t2A, t2D];
	cloneClasses = checkTypeXClones(snippets, cloneType);
	result = size(cloneClasses) == clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "A2D2");
	return result;
}

test bool type3_orig_T2D() {
	int cloneType = 3;
	list [loc] snippets = [orig, t2D];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=SIMILARITY_THRESHOLD);
	result = size(cloneClasses) == clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "origD2");
	return result;
}

test bool type3_T2A_T2D() {
	int cloneType = 3;
	list [loc] snippets = [t2A, t2D];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=T3_SIMILARITY_THRESHOLD);
	result = size(cloneClasses) == clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "A2D2");
	return result;
}

*/

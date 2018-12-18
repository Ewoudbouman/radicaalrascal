module tests::duplication::types::FutureWork

import tests::TestResources;
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
private real T3_SIMILARITY_THRESHOLD = 0.2;


//type 2 stuff

/**
 * Checks if the scenario 1 cases are correctly marked as type 2 clones of the source.
 * and eachother
 */

test bool type2_scenario1() {
	int cloneType = 2;
	list [bool] failures = [];
	list [loc] scenarios1 = [orig, t1A, t1B, t1C];
	int i = 0;
	for (sc <- pairLocs(scenarios1)) {
		i +=1;
		cloneClasses = checkTypeXClones(sc, cloneType, threshold=SIMILARITY_THRESHOLD);
		result = size(cloneClasses) == clones;
		if (!result) {
			failures += result;
			writeDebugClones(cloneClasses, cloneType, testCases, "type2_scenario1_<i>");
		}
	}
	return failures == [];
}

// Checks if the scenario 2 cases are correctly marked as type 2 clones of the source and eachother


/**
 * Case 1:
 *
 * All covered
 */
 
/*
test bool type_wtf() {
	int cloneType = 3;
	list [loc] snippets = [cda, cdb];
	cloneClasses = checkTypeXClones(snippets, cloneType,threshold=T3_SIMILARITY_THRESHOLD);
	result = size(cloneClasses) == clones;
	writeDebugClones(cloneClasses, cloneType, testCases, "debug");
	return true;
}   
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

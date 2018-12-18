module tests::duplication::types::type3

import tests::TestResources;
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
 * Checks if the scenario 1 cases are correctly marked as type 3 clones of the source.
 * and eachother
 */
test bool type3_scenario1() {
	int cloneType = 3;
	list [bool] failures = [];
	list [loc] scenarios1 = [orig, t1A, t1B, t1C];
	int i = 0;
	for (sc <- pairLocs(scenarios1)) {
		i +=1;
		cloneClasses = checkTypeXClones(sc, cloneType, T3_SIMILARITY_THRESHOLD);
		result = size(cloneClasses) == clones;
		if (!result) {
			failures += result;
			writeDebugClones(cloneClasses, cloneType, testCases, "type3_scenario1_<i>");
		}
	}
	return failures == [];
}

/**
 * Checks if the scenario 2 cases are correctly marked as type 3 clones of the source.
 * and eachother
 */

test bool type3_scenario2() {
	int cloneType = 3;
	list [bool] failures = [];
	list [loc] scenarios1 = [orig, t2A, t2B, t2C];
	int i = 0;
	for (sc <- pairLocs(scenarios1)) {
		i +=1;
		cloneClasses = checkTypeXClones(sc, cloneType, T3_SIMILARITY_THRESHOLD);
		result = size(cloneClasses) == clones;
		if (!result) {
			failures += result;
			writeDebugClones(cloneClasses, cloneType, testCases, "type3_scenario2_<i>");
		}
	}
	return failures == [];
}
 
/**
 * Checks if the scenario 3 cases are correctly marked as type 3 clones of the source.
 * and eachother
 */

test bool type3_scenario3() {
	int cloneType = 3;
	list [bool] failures = [];
	list [loc] scenarios1 = [orig, t3A, t3B, t3C, t3D, t3E];
	int i = 0;
	for (sc <- pairLocs(scenarios1)) {
		i +=1;
		cloneClasses = checkTypeXClones(sc, cloneType, T3_SIMILARITY_THRESHOLD);
		result = size(cloneClasses) == clones;
		if (!result) {
			failures += result;
			writeDebugClones(cloneClasses, cloneType, testCases, "type3_scenario3_<i>");
		}
	}
	return failures == [];
}

/**
 * Checks if the source and type 1 scenarios are type 3 clones of the type 2 
 * scenarios.
 */

 test bool type3_scenario1_scenario2() {
	int cloneType = 3;
	list [bool] failures = [];
	list [loc] scenarios1 = [orig, t1A, t1B, t1C];
	list [loc] scenarios2 = [t2A, t2B, t2C];
	int i = 0;
	for (sc1 <- scenarios1) {
		for (sc2 <- scenarios2) {
			i +=1;
			cloneClasses = checkTypeXClones([sc1, sc2], cloneType, T3_SIMILARITY_THRESHOLD);
			result = size(cloneClasses) == clones;
			if (!result) {
				failures += result;
				writeDebugClones(cloneClasses, cloneType, testCases, "type3_scenario1_scenario2_<i>");
			}
		}
	}
	return failures == [];
}

/**
 * Checks if the source and type 3 scenarios are type 3 clones of the type 2 
 * scenarios.
 */

 test bool type3_scenario1_scenario3() {
	int cloneType = 3;
	list [bool] failures = [];
	list [loc] scenarios1 = [orig, t1A, t1B, t1C];
	list [loc] scenarios2 = [t3A, t3B, t3C, t3D, t3E];
	int i = 0;
	for (sc1 <- scenarios1) {
		for (sc2 <- scenarios2) {
			i +=1;
			cloneClasses = checkTypeXClones([sc1, sc2], cloneType, T3_SIMILARITY_THRESHOLD);
			result = size(cloneClasses) == clones;
			if (!result) {
				failures += result;
				writeDebugClones(cloneClasses, cloneType, testCases, "type3_scenario1_scenario3_<i>");
			}
		}
	}
	return failures == [];
}

/**
 * Checks if the source and type 2 scenarios are type 3 clones of the type 3 
 * scenarios.
 */

 test bool type3_scenario2_scenario3() {
	int cloneType = 3;
	list [bool] failures = [];
	list [loc] scenarios1 = [orig, t2A, t2B, t2C];
	list [loc] scenarios2 = [t3A, t3B, t3C, t3D, t3E];
	int i = 0;
	for (sc1 <- scenarios1) {
		for (sc2 <- scenarios2) {
			i +=1;
			cloneClasses = checkTypeXClones([sc1, sc2], cloneType, T3_SIMILARITY_THRESHOLD);
			result = size(cloneClasses) == clones;
			if (!result) {
				failures += result;
				writeDebugClones(cloneClasses, cloneType, testCases, "type3_scenario2_scenario3_<i>");
			}
		}
	}
	return failures == [];
}

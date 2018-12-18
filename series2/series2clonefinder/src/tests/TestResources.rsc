module tests::TestResources

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;
import util::Resources;
import Utils;
import IO;
import List;
import util::Math;
import Node;
import Map;
import Set;
import String;
import CloneLocProvider;
import lang::json::IO;

import CloneUtils;
import AstCloneFinder;
import LocUtils;
import CloneIO;

private bool SHOW_OUTPUT = false;
private int NODE_MASS_THRESHOLD_TESTCASE = 2;

// project loc
public loc testCases = |project://testDUP|;
// original source
public loc orig = |project://testDUP/src/orig/OriginalCopy.java|;
// t1
public loc t1A = |project://testDUP/src/t1/CopyOneA.java|;
public loc t1B = |project://testDUP/src/t1/CopyOneB.java|;
public loc t1C = |project://testDUP/src/t1/CopyOneC.java|;
// t2
public loc t2A = |project://testDUP/src/t2/CopyTwoA.java|;
public loc t2B = |project://testDUP/src/t2/CopyTwoB.java|;
public loc t2C = |project://testDUP/src/t2/CopyTwoC.java|;
public loc t2D = |project://testDUP/src/t2/CopyTwoD.java|;

// t3
public loc t3A = |project://testDUP/src/t3/CopyThreeA.java|;
public loc t3B = |project://testDUP/src/t3/CopyThreeB.java|;
public loc t3C = |project://testDUP/src/t3/CopyThreeC.java|;
public loc t3D = |project://testDUP/src/t3/CopyThreeD.java|;
public loc t3E = |project://testDUP/src/t3/CopyThreeE.java|;

/**
 * Prepares the testcases to be handled by the cloneFinder.
 */

public map[node, set[node]] checkTypeXClones(list [loc] snippets, int cloneType, real similarity) {
	set[Declaration] asts = {};
	lrel[node, node] results = [];
	
	for (snippet <- snippets) {
		asts += createAstFromFile(snippet, false);
	}
	results = findClones(asts, cloneType, similarity, nodeThreshold=NODE_MASS_THRESHOLD_TESTCASE, output=false);
	cloneClasses = convertToCloneClasses(results);
	if (SHOW_OUTPUT) {
		println("size Type <cloneType> cloneclasses <size(cloneClasses)>");
	}
	return cloneClasses;
}

/**
 * Debug clone writer
 */
 
 public void writeDebugClones(map[node, set[node]] cloneClasses, int writeType, loc projectLoc, str files) {
 	loc outputLoc = |project://series2/src/tests/duplication/types/output/| + "type_<writeType>_<files>_error.json";
 	writeClones(cloneClasses, writeType, projectLoc, outputLoc);
 }

public list[list [loc]] pairLocs(list[loc] locations) {
	return [[locations[i], locations[j]] | i <- [0..size(locations)], j <- [(i+1)..size(locations)]];
}

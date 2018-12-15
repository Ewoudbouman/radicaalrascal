module tests::duplication::types::type1

import tests::duplication::types::TypeResources;
import CloneUtils;
import AstCloneFinder;
import CloneIO;

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

test bool type1_T1A_T1B() {
	int cloneType = 1;
	list [loc] snippets = [t1A, t1B];
	cloneClasses = checkTypeXClones(snippets, cloneType);
	result = size(cloneClasses) == clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "A1B1");
	return result;
}

test bool type1_T1A_T1C() {
	int cloneType = 1;
	list [loc] snippets = [t1A, t1C];
	cloneClasses = checkTypeXClones(snippets, cloneType);
	result = size(cloneClasses) == clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "A1C1");
	return result;
}

test bool type1_T1B_T1C() {
	int cloneType = 1;
	list [loc] snippets = [t1B, t1C];
	cloneClasses = checkTypeXClones(snippets, cloneType);
	result = (size(cloneClasses) == clones);
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "B1C1");
	return result;
}

/**
 * Tests if the type 1 cases are ALSO correctly marked as type 2 clones of eachother.
 */

test bool type2_T1A_T1B() {
	int cloneType = 2;
	list [loc] snippets = [t1A, t1B];
	cloneClasses = checkTypeXClones(snippets, cloneType);
	result = size(cloneClasses) == clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "A1B1");
	return result;
}

test bool type2_T1A_T1C() {
	int cloneType = 2;
	list [loc] snippets = [t1A, t1C];
	cloneClasses = checkTypeXClones(snippets, cloneType);
	result = size(cloneClasses) == clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "A1C1");
	return result;
}

test bool type2_T1B_T1C() {
	int cloneType = 2;
	list [loc] snippets = [t1B, t1C];
	cloneClasses = checkTypeXClones(snippets, cloneType);
	result = size(cloneClasses) == clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "B1C1");
	return result;
}


 /**
 * Tests if the type 1 cases are ALSO correctly marked as type 3 clones of eachother.
 */

test bool type3_T1A_T1B() {
	int cloneType = 3;
	list [loc] snippets = [t1A, t1B];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=SIMILARITY_THRESHOLD);
	result = size(cloneClasses) == clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "A1B1");
	return result;
}

test bool type3_T1A_T1C() {
	int cloneType = 3;
	list [loc] snippets = [t1A, t1C];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=SIMILARITY_THRESHOLD);
	result = size(cloneClasses) == clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "A1C1");
	return result;
}

test bool type3_T1B_T1C() {
	int cloneType = 3;
	list [loc] snippets = [t1B, t1C];
	cloneClasses = checkTypeXClones(snippets, cloneType, threshold=SIMILARITY_THRESHOLD);
	result = size(cloneClasses) == clones;
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "B1C1");
	return result;
}

/**
 * Tests where the files are NOT type 1 clones of eachother.
 *
 * Compares type 1 cases with type 2 cases
 */

test bool type1_T1A_T2A() {
	int cloneType = 1;
	list [loc] snippets = [t1A, t2A];
	cloneClasses = checkTypeXClones(snippets, cloneType);
	result = (size(cloneClasses) != clones);
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "A1A2");
	return result;
}

test bool type1_T1A_T2B() {
	int cloneType = 1;
	list [loc] snippets = [t1A, t2B];
	cloneClasses = checkTypeXClones(snippets, cloneType); 	
	result = (size(cloneClasses) != clones); 	
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "A1B2"); 	
	return result;
}

test bool type1_T1A_T2C() {
	int cloneType = 1;
	list [loc] snippets = [t1A, t2C];
	cloneClasses = checkTypeXClones(snippets, cloneType); 	
	result = (size(cloneClasses) != clones); 	
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "A1C2"); 	
	return result;
}

test bool type1_T1A_T2D() {
	int cloneType = 1;
	list [loc] snippets = [t1A, t2D];
	cloneClasses = checkTypeXClones(snippets, cloneType); 	
	result = (size(cloneClasses) != clones); 	
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "A1D2"); 	
	return result;
}

test bool type1_T1B_T2A() {
	int cloneType = 1;
	list [loc] snippets = [t1B, t2A];
	cloneClasses = checkTypeXClones(snippets, cloneType); 	
	result = (size(cloneClasses) != clones); 	
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "B1A2"); 	
	return result;
}

test bool type1_T1B_T2B() {
	int cloneType = 1;
	list [loc] snippets = [t1B, t2B];
	cloneClasses = checkTypeXClones(snippets, cloneType); 	
	result = (size(cloneClasses) != clones); 	
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "B1B2"); 	
	return result;
}

test bool type1_T1B_T2C() {
	int cloneType = 1;
	list [loc] snippets = [t1B, t2C];
	cloneClasses = checkTypeXClones(snippets, cloneType); 	
	result = (size(cloneClasses) != clones); 	
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "B1C2"); 	
	return result;
}

test bool type1_T1B_T2D() {
	int cloneType = 1;
	list [loc] snippets = [t1B, t2D];
	cloneClasses = checkTypeXClones(snippets, cloneType); 	
	result = (size(cloneClasses) != clones);
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "B1D2"); 	
	return result;
}

test bool type1_T1C_T2A() {
	int cloneType = 1;
	list [loc] snippets = [t1C, t2A];
	cloneClasses = checkTypeXClones(snippets, cloneType);
 	result = (size(cloneClasses) != clones); 	
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "C12A"); 	
	return result;
}

test bool type1_T1C_T2B() {
	int cloneType = 1;
	list [loc] snippets = [t1C, t2B];
	cloneClasses = checkTypeXClones(snippets, cloneType);
 	result = (size(cloneClasses) != clones); 	
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "C1B2"); 	
	return result;
}

test bool type1_T1C_T2C() {
	int cloneType = 1;
	list [loc] snippets = [t1C, t2C];
	cloneClasses = checkTypeXClones(snippets, cloneType);
 	result = (size(cloneClasses) != clones); 	
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "C1C2"); 	
	return result;
}

test bool type1_T1C_T2D() {
	int cloneType = 1;
	list [loc] snippets = [t1C, t2D];
	cloneClasses = checkTypeXClones(snippets, cloneType);
 	result = (size(cloneClasses) != clones); 	
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "C2D2"); 	
	return result;
}

/**
 * Tests where the files are NOT type 1 clones of eachother.
 * Check if the our solution marks them as the correct number of clones.
 *
 * Compares type 1 cases with type 3 cases
 */
 
test bool type1_T1A_T3A() {
	int cloneType = 1;
	list [loc] snippets = [t1A, t3A];
	cloneClasses = checkTypeXClones(snippets, cloneType);
 	result = (size(cloneClasses) != clones); 	
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "A1A3"); 	
	return result;
}

test bool type_T1A_T3B() {
	int cloneType = 1;
	list [loc] snippets = [t1A, t3B];
	cloneClasses = checkTypeXClones(snippets, cloneType);
 	result = (size(cloneClasses) != clones); 	
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "A1B3"); 	
	return result;
}

test bool type_T1A_T3C() {
	int cloneType = 1;
	list [loc] snippets = [t1A, t3C];
	cloneClasses = checkTypeXClones(snippets, cloneType);
 	result = (size(cloneClasses) != clones); 	
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "A1C3"); 	
	return result;
}

test bool type_T1A_T3D() {
	int cloneType = 1;
	list [loc] snippets = [t1A, t3D];
	cloneClasses = checkTypeXClones(snippets, cloneType);
 	result = (size(cloneClasses) != clones);
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "A1D3"); 	
	return result;
}

test bool type_T1A_T3E() {
	int cloneType = 1;
	list [loc] snippets = [t1A, t3E];
	cloneClasses = checkTypeXClones(snippets, cloneType);
 	result = (size(cloneClasses) != clones); 	
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "A1E3"); 	
	return result;
}

test bool type_T1B_T3A() {
	int cloneType = 1;
	list [loc] snippets = [t1B, t3A];
	cloneClasses = checkTypeXClones(snippets, cloneType);
 	result = (size(cloneClasses) != clones); 	
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "B1A3"); 	
	return result;
}

test bool type_T1B_T3B() {
	int cloneType = 1;
	list [loc] snippets = [t1B, t3B];
	cloneClasses = checkTypeXClones(snippets, cloneType);
 	result = (size(cloneClasses) != clones); 	
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "B1B3"); 	
	return result;
}

test bool type_T1B_T3C() {
	int cloneType = 1;
	list [loc] snippets = [t1B, t3C];
	cloneClasses = checkTypeXClones(snippets, cloneType);
 	result = (size(cloneClasses) != clones); 	
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "B1C3"); 	
	return result;
}

test bool type_T1B_T3D() {
	int cloneType = 1;
	list [loc] snippets = [t1B, t3D];
	cloneClasses = checkTypeXClones(snippets, cloneType);
 	result = (size(cloneClasses) != clones); 	
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "B1D3"); 	
	return result;
}

test bool type_T1B_T3E() {
	int cloneType = 1;
	list [loc] snippets = [t1B, t3E];
	cloneClasses = checkTypeXClones(snippets, cloneType);
 	result = (size(cloneClasses) != clones); 	
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "B1E3"); 	
	return result;
}

test bool type_T1C_T3A() {
	int cloneType = 1;
	list [loc] snippets = [t1C, t3A];
	cloneClasses = checkTypeXClones(snippets, cloneType);
 	result = (size(cloneClasses) != clones); 	
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "C1A3"); 	
	return result;
}

test bool type_T1C_T3B() {
	int cloneType = 1;
	list [loc] snippets = [t1C, t3B];
	cloneClasses = checkTypeXClones(snippets, cloneType);
 	result = (size(cloneClasses) != clones); 	
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "C1B3"); 	
	return result;
}

test bool type_T1C_T3C() {
	int cloneType = 1;
	list [loc] snippets = [t1C, t3C];
	cloneClasses = checkTypeXClones(snippets, cloneType);
 	result = (size(cloneClasses) != clones); 	
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "C1C3"); 	
	return result;
}

test bool type_T1C_T3D() {
	int cloneType = 1;
	list [loc] snippets = [t1C, t3D];
	cloneClasses = checkTypeXClones(snippets, cloneType);
 	result = (size(cloneClasses) != clones); 	
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "C1D3"); 	
	return result;
}

test bool type_T1C_T3E() {
	int cloneType = 1;
	list [loc] snippets = [t1C, t3E];
	cloneClasses = checkTypeXClones(snippets, cloneType);
 	result = (size(cloneClasses) != clones); 	
	if (!result) writeDebugClones(cloneClasses, cloneType, testCases, "C1E3"); 	
	return result;
}

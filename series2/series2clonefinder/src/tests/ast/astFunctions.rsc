module tests::ast::astFunctions

import tests::TestResources;
import AstCloneFinder;
import AstCloneFinder;
import CloneIO;
//import Prelude;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;
import lang::java::m3::AST;
import lang::java::m3::Core;
import Utils;
import util::Math;
import IO;
import List;
import String;
import Map;
import Set;

/*
 * Checks the known results of the SmallSql project
 */
test bool checkSmallSqlProject() {
	testProject = createProject(projSmallSql);
	int sizeT1 = size(checkTypeXClones(projectAsts(testProject), 1, 1.0, nodeMass=40));
	int sizeT2 = size(checkTypeXClones(projectAsts(testProject), 2, 1.0, nodeMass=40));
	int sizeT3 = size(checkTypeXClones(projectAsts(testProject), 3, 0.8, nodeMass=40));
	
	return (sizeT1 == 22 && sizeT2 == 34 && sizeT3 == 52);
}
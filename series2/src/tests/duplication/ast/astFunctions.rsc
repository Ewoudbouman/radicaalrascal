module tests::duplication::ast::astFunctions

import AstCloneFinder;

import Prelude;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;
import lang::java::m3::AST;
import lang::java::m3::Core;
//import Config;

//
public test bool testSimilarityScore() {
	node node1 = makeNode("node1", "321");
	node node2 = makeNode("node1", "123");
	
	return (similarityScore(node1, node2) == 0);
}
module Utils
import IO;

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;
import Node;
import List;

public str resourceContent(loc resource) {
	return readFile(resource);
}

public M3 createProject(loc location) {
 	return createM3FromEclipseProject(location);
}

public set[Declaration] projectAsts(M3 project) {
	return {createAstFromFile(file, true) | file <- files(project)};
}

public int subTreeMass(node x) {
	return size(subNodes(x));
}

public list[node] subNodes(node x) {
	list[node] subNodes = [];
	visit(x) {
		case node y: { subNodes += y; }
	}
	return subNodes;
}

public list[node] subTrees(set[Declaration] decls) {
	list[node] subTrees = [];
	visit(decls) {
		case node subTree: { subTrees += subTree; }
	}
	return subTrees;
}

public void printNodeSource(node x) {
	println("---------------");
	switch (x) {
		case Declaration decl: { if(decl.src?) println("Decl:\n<decl.src>\n<resourceContent(decl.src)>"); }
		case Expression expr: {  if(expr.src?) println("Expr:\n<expr.src>\n<resourceContent(expr.src)>"); }
		case Statement stmnt: {  if(stmnt.src?) println("Stmnt:\n<stmnt.src>\n<resourceContent(stmnt.src)>"); }
		default: println("Unknown:\n<x>");
	}
	println("---------------");
}

public void printNodesSource(list[node] xs) {
	println("**************");
	for(x <- xs) {
		printNodeSource(x);
	}
	println("**************");
}

public void printText(str text) {
	println(text);
}

public void printTexts(list[str] texts) {
	for(x <- texts) {
		printText(x);
	}
}
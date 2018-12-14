module Utils
import IO;

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;
import Node;
import List;

private loc EMPTY_LOCATION = |file:///thisdoesnotexist|;

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

/*
public void printNodeSource(node x) {
	println("---------------");
	source = nodeSourceLoc(x);
	if(!isEmptyLocation(source)) {
		println(source);
		println(resourceContent(source));
	} else {
		println("Unknown:\n<x>");
	}
	println("---------------");
}
*/

public str getNodeSource(node x) {
	source = nodeSourceLoc(x);
	if(!isEmptyLocation(source)) {
		return resourceContent(source);
	} else {
		return "Unknown node source";
	}
}

public loc nodeSourceLoc(node x) {
 	switch (x) {
		case Declaration decl: { if(decl.src?) return decl.src; }
		case Expression expr: {  if(expr.src?) return expr.src; }
		case Statement stmnt: {  if(stmnt.src?) return stmnt.src; }
	}
	return EMPTY_LOCATION;
}

public bool isEmptyLocation(loc location) {
	return location == EMPTY_LOCATION;
}

/*
public void printNodesSource(list[node] xs) {
	println("**************");
	for(x <- xs) {
		printNodeSourceLoc(x);
	}
	println("**************");
}
*/

/*
public void printText(str text) {
	println(text);
}
*/

/*
public void printTexts(list[str] texts) {
	for(x <- texts) {
		//printText(x);
		println(text);
	}
}
*/
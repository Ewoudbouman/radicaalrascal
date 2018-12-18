module Utils
import IO;

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;
import Node;
import List;

private loc EMPTY_LOCATION = |file:///thisdoesnotexist|;

/*
 * Returns the contents of a resource as a string
 */
public str resourceContent(loc resource) {
	return readFile(resource);
}

/*
 * Returns the target location as a M3 project.
 */
public M3 createProject(loc location) {
 	return createM3FromEclipseProject(location);
}

/*
 * Returns the target location as set of declarations
 */
public set[Declaration] projectAsts(M3 project) {
	return {createAstFromFile(file, true) | file <- files(project)};
}

/*
 * Returns the size of all nodes in a tree
 */
public int subTreeMass(node x) {
	return size(subNodes(x));
}

/*
 * Returns the size of all subnodes in a node
 */
public list[node] subNodes(node x) {
	list[node] subNodes = [];
	visit(x) {
		case node y: { subNodes += y; }
	}
	return subNodes;
}

/*
 * Returns all the subtrees of the set of declarations
 */
public list[node] subTrees(set[Declaration] decls) {
	list[node] subTrees = [];
	visit(decls) {
		case node subTree: { subTrees += subTree; }
	}
	return subTrees;
}

/*
 * Returns the type of contents a node contains
 */
public str getNodeSource(node x) {
	source = nodeSourceLoc(x);
	if(!isEmptyLocation(source)) {
		return resourceContent(source);
	} else {
		return "Unknown node source";
	}
}

/*
 * 
 */
public loc nodeSourceLoc(node x) {
 	switch (x) {
		case Declaration decl: { if(decl.src?) return decl.src; }
		case Expression expr: {  if(expr.src?) return expr.src; }
		case Statement stmnt: {  if(stmnt.src?) return stmnt.src; }
	}
	return EMPTY_LOCATION;
}

/*
 * Returns if the target location does not contain any elements
 */
public bool isEmptyLocation(loc location) {
	return location == EMPTY_LOCATION;
}

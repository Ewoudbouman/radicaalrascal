module CloneLocProvider

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import IO;
import List;
import util::Math;
import Node;
import Map;
import Set;

import LocUtils;
import Utils;


int totalLinesOfCode = 1;

map[node, int] clonesLoc = ();

/*
 * Calculates the total number of lines in the project
 */
public void initCloneLocProvider(M3 project) {
	totalLinesOfCode = locOfProject(project);
}

/*
 * Returns the total number of lines in the project
 */
 
public int getTotalProjectLoc() {
	return totalLinesOfCode;
}

/*
 * Returns the loc of a specific node
 */
public int getCloneLoc(node x) {
	if(clonesLoc[x]?) return clonesLoc[x];
	source = nodeSourceLoc(x);
	result = 0;
	if(!isEmptyLocation(source)) {
		result = locOfResource(source);
	} 
	clonesLoc[x] = result;
	return result;
}

/*
 * Returns the loc of a group of nodes
 */
public int getCloneClassLoc(set[node] xs) {
	linesCount = 0;
	for(x <- xs) {
		linesCount += getCloneLoc(x);
	}
	return linesCount;
}


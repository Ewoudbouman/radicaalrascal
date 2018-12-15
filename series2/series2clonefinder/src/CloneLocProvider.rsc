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

// change for debugging stuff?
//int totalLinesOfCode;
int totalLinesOfCode = 1;

map[node, int] clonesLoc = ();

public void initCloneLocProvider(M3 project) {
	totalLinesOfCode = locOfProject(project);
}

public int getTotalProjectLoc() {
	return totalLinesOfCode;
}

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

public int getCloneClassLoc(set[node] xs) {
	linesCount = 0;
	for(x <- xs) {
		linesCount += getCloneLoc(x);
	}
	return linesCount;
}


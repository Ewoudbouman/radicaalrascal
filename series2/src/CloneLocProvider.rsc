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

int totalLinesOfCode;

public void initCloneLocProvider(M3 project) {
	totalLinesOfCode = locOfProject(project);
}

public int getTotalProjectLoc() {
	return totalLinesOfCode;
}
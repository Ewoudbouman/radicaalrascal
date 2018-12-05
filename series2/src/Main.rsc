module Main

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import IO;
import List;
import util::Math;
import Node;
import Map;
import Set;

import Utils;
import AstCloneFinder;
import CloneUtils;
import CloneIO;

public void main() {
	testProject = createProject(|project://testDUP|);
	
	type1Clones = findType1Clones(testProject); 
	typ1CloneClasses = convertToCloneClasses(type1Clones);
	
	println("Clone classes:");
	for(<_, c> <- toList(typ1CloneClasses)) {
		println("Clones class containing:");
		for(n <- c) {
			printNodeSource(n);
		}
	}
	
	println("Creating JSON...");
	writeClones(typ1CloneClasses, <100.0, 1337, 1337>);
}
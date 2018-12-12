module Main

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import IO;
import List;
import util::Math;
import Node;
import Map;
import Set;
import util::Benchmark;

import Utils;
import CloneLocProvider;
import AstCloneFinder;

import CloneUtils;
import CloneIO;
import DateTime;

public void main() {
	before = userTime();
	//projectLocation = |project://smallsql0.21_src|;
	projectLocation = |project://hsqldb-2.3.1|;
	//projectLocation = |project://testDUP|;

	println("<now()>:Creating M3...");
	testProject = createProject(projectLocation);
	
	println("Initialising clone LOC provider...");
 	initCloneLocProvider(testProject);
 	
 	//type 1 stuff
 	println("Gathering type 1 clones...");
	type1Clones = findType1Clones(testProject);
	println("Converting clones to clone classes..."); 
	typ1CloneClasses = convertToCloneClasses(type1Clones);
	println("cloneclasses <size(typ1CloneClasses)>");
	
	println("Creating JSON...");
	writeClones(typ1CloneClasses, 1, projectLocation);
	
	//type 2 stuff
 	println("Gathering type 2 clones...");
	type2Clones = findType2Clones(testProject);
	println("Converting clones to clone classes..."); 
	typ2CloneClasses = convertToCloneClasses(type2Clones);
	println("cloneclasses <size(typ2CloneClasses)>");
	
	println("Creating JSON...");
	writeClones(typ1CloneClasses, 2, projectLocation);
	
	println("<now()>:Analysis took: <nanoToSec(userTime() - before)> seconds\n");
}

private real nanoToSec(int nano) {
	return nano / 1000000000.0;
}

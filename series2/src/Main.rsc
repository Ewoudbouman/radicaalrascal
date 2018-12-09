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

	println("<now()>:Creating M3...");
	testProject = createProject(|project://smallsql0.21_src|);
	//testProject = createProject(|project://hsqldb-2.3.1|);
	//testProject = createProject(|project://netbeans-javadoc|);
	//testProject = createProject(|project://testDUP|);
	println("Initialising clone LOC provider...");
 	initCloneLocProvider(testProject);
 	println("Gathering type 1 clones...");
	type1Clones = findType1Clones(testProject);
	println("Converting clones to clone classes..."); 
	typ1CloneClasses = convertToCloneClasses(type1Clones);
	
	println("clonesclasses <size(typ1CloneClasses)>");
	//println(typ1CloneClasses);
	
	println("Creating JSON...");
	writeClones(typ1CloneClasses, 1, |project://smallsql0.21_src|);
	
	println("<now()>:Analysis took: <nanoToSec(userTime() - before)> seconds\n");
}

private real nanoToSec(int nano) {
	return nano / 1000000000.0;
}

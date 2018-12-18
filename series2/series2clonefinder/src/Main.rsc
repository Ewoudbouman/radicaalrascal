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

/**
 * Clone detector
 */
public void main() {
	before = userTime();
	
	//projects = [|project://testDUP|, |project://testSLOC|, |project://smallsql0.21_src|, |project://hsqldb-2.3.1|];
	//projects = [|project://testDUP|, |project://testSLOC|, |project://smallsql0.21_src|];
	//projects = [|project://testDUP|, |project://testSLOC|];
	//projects = [|project://testDUP|];
	projects = [|project://smallsql0.21_src|, |project://hsqldb-2.3.1|];
	
	for(projectLocation <- projects) {
		println("Analysing: <projectLocation>");
		runTests(projectLocation, 1, 1.0);
		println("<now()>:Analysis took: <nanoToSec(userTime() - before)> seconds\n");
		runTests(projectLocation, 2, 1.0);
		println("<now()>:Analysis took: <nanoToSec(userTime() - before)> seconds\n");
		runTests(projectLocation, 3, 0.8);
		println("<now()>:Analysis took: <nanoToSec(userTime() - before)> seconds\n");
	}
	
	writeProjects(projects);
}

/*
 * Runs the clone detection tests and prints the metrics.
 */
public void runTests(loc projectLocation, int cloneType, real similarity) {
	println("<now()>:Creating M3...");
	testProject = createProject(projectLocation);
	
	println("Initialising clone LOC provider...");
 	initCloneLocProvider(testProject);
 	
 	println("Gathering type <cloneType> clones...");
 	clones = findClones(projectAsts(testProject), cloneType, similarity);
 	println("Converting clones to clone classes..."); 
 	cloneClasses = convertToCloneClasses(clones);
 	println("cloneclasses <size(cloneClasses)>");
 	
 	println("Creating JSON...");
 	loc outputLoc = |project://series2/| + "output/<projectLocation.authority>/<cloneType>/index.json";
 	writeClones(cloneClasses, cloneType, projectLocation, outputLoc);
 	
}

private real nanoToSec(int nano) {
	return nano / 1000000000.0;
}

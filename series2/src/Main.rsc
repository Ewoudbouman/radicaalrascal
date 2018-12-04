module Main

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import IO;

import Utils;
import AstCloneFinder;

public void main() {
	testProject = createProject(|project://testDUP|);
	
	println(findType1Clones(testProject));
}
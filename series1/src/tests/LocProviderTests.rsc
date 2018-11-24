module tests::LocProviderTests

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import IO;

import LocProvider;

/**
 * Loc tests
 * Based on testcase from https://github.com/Aaronepower/tokei
 */

//test bool locOfFile() {
//	return locOfResource(|project://testSLOC/src/test/sloctest.java|) == 16;
//}

test bool locOfProject() {
	M3 m3 = createM3FromEclipseProject(|project://testSLOC|);
	return (locOfProject(m3) == 32);
}

/**
 * removeComments()
 */

test bool removeComments1(){
	return (removeComments("/* 23 lines 16 code 4 comments 3 blanks source: github.com/Aaronepower/tokei */") == "");
}

// perhaps remove trailing whitespace?
test bool removeComments2(){
	return (removeComments("int j = 0; // Not counted") == "int j = 0; ");
}

test bool removeComments3(){
	return (removeComments("/* \n * Simple test class\n*/") == "");
}

test bool removeComments4(){
	return (removeComments("/* \n * Simple test class\n*/") == "");
}

/**
 * locPercentage
 */

test bool locPercentage1() {
	return(locPercentage(100,100) == 100.0);
}

test bool locPercentage2() {
	return(locPercentage(50,100) == 50.0);
}

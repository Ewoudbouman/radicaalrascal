module tests::LocProviderTests

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import IO;

import LocProvider;

M3 m3 = createM3FromEclipseProject(|project://test|);

/**
* locOfProject
*/

test bool locOfProject1() {
	return (locOfProject(m3) == 82);
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

/**
* readResource
*/

test bool readResource1() {
	loc resource = |java+class:///test/LocTest|;
	return(readResource(resource) == readFile(resource));
}

/**
* locOfResource()
*/

test bool locOfResource1() {
	loc resource = |java+class:///test/LocTest|;
	return (locOfResource(resource) == 4);
}


/**
* PRIVATE removeTabsAndSpaces()
*/

/**
* removeComments()
*/

test bool removeComments1(){
	return (removeComments("x = 4;") == "x = 4;");
}

test bool removeComments2(){
	return (removeComments("x = 4; //Single line comment") == "x = 4; ");
}

//test bool removeComments3(){
//	return (removeComments("x = 4;	/* \n* Multi line comment \n*/") == "x = 4; ");
//}

/**
* PRIVATE splitByNewLine()
*/

/**
* PRIVATE filterEmptyStrings()
*/


module tests::utils::TestUtils

import tests::TestResources;
import CloneUtils;
import AstCloneFinder;
import CloneIO;
import LocUtils;
import List;
import IO;

test bool removeComments1(){
	return (removeComments("/* 23 lines 16 code 4 comments 3 blanks source: github.com/Aaronepower/tokei */") == "");
}

test bool removeComments2(){
	return (removeComments("int j = 0; // Not counted") == "int j = 0; ");
}

test bool removeComments3(){
	return (removeComments("/* \n * Simple test class\n*/") == "");
}

test bool removeComments4(){
	return (removeComments("/* \n * Simple test class\n*/") == "");
}

test bool lineParser1() {
	return (size(splitByNewLineAndFilterEmptyLines("a \n b \n c")) == 3);
}

test bool lineParsers2() {
	return (size(splitByNewLineAndFilterEmptyLines("a")) == 1);
}

test bool lineParsers3() {
	return (size(splitByNewLineAndFilterEmptyLines("")) == 0);
}

test bool locChecker1() {
	return (locOfResource(orig) == 9);
}
module tests::DuplicateMetricTests

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::m3::AST;
import IO;

import DuplicateMetric;

/**
 * count duplicates
 */
 
 test bool duplicates() {
	return (duplicatesForProject(createM3FromEclipseProject(|project://testDUP|)) == 45);
}

/**
 * perhaps check logic (not very input friendly atm).
 */

/**
 * check rankings
 */

test bool rateDuplicates1() {
	return (rateDuplicates(21, 100, output=false) == 1);
}

test bool rateDuplicates2() {
	return (rateDuplicates(11, 100, output=false) == 2);
}

test bool rateDuplicates3() {
	return (rateDuplicates(6, 100, output=false) == 3);
}

test bool rateDuplicates4() {
	return (rateDuplicates(4, 100, output=false) == 4);
}

test bool rateDuplicates5() {
	return (rateDuplicates(3, 100, output=false) == 5);
}


// todo: fixx load single need to load single file into m3
/**
test bool duplicatesc2() {
	M3 m3 = createM3FromEclipseFile(|project://testDUP/src/test/case2.java|);
	return (duplicatesForProject(m3) == 14);
}

test bool duplicatesc3() {
	M3 m3 = createM3FromEclipseFile(|project://testDUP/src/test/case3.java|);
	return (duplicatesForProject(m3) == 12);
}

test bool duplicatesc4() {
	M3 m3 = createM3FromEclipseFile(|project://testDUP/src/test/case4.java|);
	return (duplicatesForProject(m3) == 7);
}
*/
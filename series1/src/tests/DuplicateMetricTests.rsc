module tests::DuplicateMetricTests

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import IO;

import DuplicateMetric;

M3 m3 = createM3FromEclipseProject(|project://test|);

/**
 * rateDuplicates()
 */
 
test bool rateDuplicates1() {
	return (rateDuplicates(21.0) == 1);
}

test bool rateDuplicates2() {
	return (rateDuplicates(11.0) == 2);
}

test bool rateDuplicates3() {
	return (rateDuplicates(6.0) == 3);
}

test bool rateDuplicates4() {
	return (rateDuplicates(4.0) == 4);
}

test bool rateDuplicates5() {
	return (rateDuplicates(3.0) == 5);
}

/**
* hitWindow()
*/

test bool hitWindow1() {
	S = {"abc", "def", "ghi"};
	hit = {"abc"};
	str text = "abc";
	return (hitWindow(text, S, hit) == 1);
}

test bool hitWindow2() {
	S = {"abc", "def", "ghi"};
	hit = {""};
	str text = "abc";
	return (hitWindow(text, S, hit) == 2);
}

test bool hitWindow3() {
	S = {"abc", "def", "ghi"};
	hit = {};
	str text = "bcd";
	return (hitWindow(text, S, hit) == 0);
}

/**
* compareWindow()
*/

test bool compareWindow1() {
	S = {"abc", "def", "ghi"};
	str text = "abc";
	return (compareWindow(text, true, S, 6) == <true, 1>);
}

test bool compareWindow2() {
	S = {"abc", "def", "ghi"};
	str text = "abc";
	return (compareWindow(text, false, S, 6) == <true, 6>);
}

test bool compareWindow3() {
	S = {"abc", "def", "ghi"};
	str text = "bcd";
	return (compareWindow(text, false, S, 6) == <false, 0>);
}

/**
* moveWindow() TODO
*/
test bool moveWindow1(){
	return true;
}

/**
* moveWindowLines() TODO
*/
test bool moveWindowLines1(){
	return true;
}

/**
* flattenResource()
*/
test bool flattenResource1(){
	return (flattenResource(m3) == <64,107>);
}
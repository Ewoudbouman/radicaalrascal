module Main

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import IO;

import LocProvider;

public void main() {
	M3 testProject = createM3FromEclipseProject(|project://test|);
	print("Lines of code measure for \"test\" project: ");
	print(locOfProject(testProject));
	println();
	println();
	
	M3 smallSqlProject = createM3FromEclipseProject(|project://smallsql0.21_src|);
	print("Lines of code measure for \"smallsql0.21_src\" project: ");
	print(locOfProject(smallSqlProject));
	println();
	println();
	
	M3 hsqldbProject = createM3FromEclipseProject(|project://hsqldb-2.3.1|);
	print("Lines of code measure for \"hsqldb-2.3.1\" project: ");
	print(locOfProject(hsqldbProject));
	println();
	println();
}
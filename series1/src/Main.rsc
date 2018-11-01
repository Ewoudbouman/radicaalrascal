module Main

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import IO;

import LocProvider;
import VolumeMetric;

public void main() {
	tuple[int linesOfCode, int rating] volumeMeasure;
	
	M3 testProject = createM3FromEclipseProject(|project://test|);
	volumeMeasure = volumeMetricForProject(testProject);
	println("Measures for \"test\" project:");
	print("Lines of code: ");
	print(volumeMeasure.linesOfCode);
	print("\nVolume rating: ");
	print(volumeMeasure.rating);
	println();
	println();
	
	M3 smallSqlProject = createM3FromEclipseProject(|project://smallsql0.21_src|);
	volumeMeasure = volumeMetricForProject(smallSqlProject);
	println("Measures for \"smallsql0.21_src\" project:");
	print("Lines of code: ");
	print(volumeMeasure.linesOfCode);
	print("\nVolume rating: ");
	print(volumeMeasure.rating);
	println();
	println();
	
	
	M3 hsqldbProject = createM3FromEclipseProject(|project://hsqldb-2.3.1|);
	volumeMeasure = volumeMetricForProject(hsqldbProject);
	println("Measures for \"hsqldb-2.3.1\" project:");
	print("Lines of code: ");
	print(volumeMeasure.linesOfCode);
	print("\nVolume rating: ");
	print(volumeMeasure.rating);
	println();
	println();
}
module Main

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import IO;

import VolumeMetric;
import ComplexityMetric;
import DuplicateMetric;

public void main() {
	tuple[int linesOfCode, int rating] volumeMeasure;
	
	M3 testProject = createM3FromEclipseProject(|project://test|);
	println("Measures for \"test\" project:");
	volumeMeasure = volumeMetricForProject(testProject);
	print("Lines of code: ");
	print(volumeMeasure.linesOfCode);
	print("\nVolume rating: ");
	print(volumeMeasure.rating);
	println();
	print("Complexity rating: ");
	print(projectComplexity(testProject));
	println("\nDuplicates test ");
	duplicateMeasure = duplicateMetricForProject(testProject);
	print(duplicateMeasure);
	println();
	
	M3 smallSqlProject = createM3FromEclipseProject(|project://smallsql0.21_src|);
	println("Measures for \"smallsql0.21_src\" project:");
	volumeMeasure = volumeMetricForProject(smallSqlProject);
	print("Lines of code: ");
	print(volumeMeasure.linesOfCode);
	print("\nVolume rating: ");
	print(volumeMeasure.rating);
	println();
	print("Complexity rating: ");
	print(projectComplexity(smallSqlProject));
	println();
	println();
	
	M3 hsqldbProject = createM3FromEclipseProject(|project://hsqldb-2.3.1|);
	println("Measures for \"hsqldb-2.3.1\" project:");
	volumeMeasure = volumeMetricForProject(hsqldbProject);
	print("Lines of code: ");
	print(volumeMeasure.linesOfCode);
	print("\nVolume rating: ");
	print(volumeMeasure.rating);
	println();
	print("Complexity rating: ");
	print(projectComplexity(hsqldbProject));
	println();
	println();
}
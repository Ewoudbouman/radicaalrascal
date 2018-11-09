module Main

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import IO;

import VolumeMetric;
import ComplexityMetric;
import DuplicateMetric;
import UnitSizeMetric;
import util::Benchmark;

public void main() {
	tuple[int linesOfCode, int rating] volumeMeasure;
	
	//test
	M3 testProject = createM3FromEclipseProject(|project://test|);
	before = userTime();
	println("Measures for \"test\" project:");
	volumeMeasure = volumeMetricForProject(testProject);
	print("Lines of code: ");
	print(volumeMeasure.linesOfCode);
	print("\nVolume rating: ");
	print(volumeMeasure.rating);
	println();

	complexity = projectComplexity(testProject);
	println("Complexity rating: <rateComplexity(complexity.lowRiskPercentage, complexity.moderateRiskPercentage, complexity.highRiskPercentage, complexity.veryHighRiskPercentage)>");
		
	println("Unit size rating: <rateUnitSizes(complexity.unitSizes)>");

	duplicateMeasure = duplicateMetricForProject(testProject);
	println("Duplicates rating: <rateDuplicates(duplicateMeasure)>");
	println("benchmark time: <userTime() - before>");

	//small
	M3 smallSqlProject = createM3FromEclipseProject(|project://smallsql0.21_src|);
	before = userTime();
	println("Measures for \"smallsql0.21_src\" project:");
	volumeMeasure = volumeMetricForProject(smallSqlProject);
	print("Lines of code: ");
	print(volumeMeasure.linesOfCode);
	print("\nVolume rating: ");
	print(volumeMeasure.rating);
	println();
	
	complexity = projectComplexity(smallSqlProject);
	println("Complexity rating: <rateComplexity(complexity.lowRiskPercentage, complexity.moderateRiskPercentage, complexity.highRiskPercentage, complexity.veryHighRiskPercentage)>");
	
	println("Unit size rating: <rateUnitSizes(complexity.unitSizes)>");
	
	duplicateMeasure = duplicateMetricForProject(smallSqlProject);
	println("Duplicates rating: <rateDuplicates(duplicateMeasure)>");
	println("benchmark time: <userTime() - before>");
	
	//big
	M3 hsqldbProject = createM3FromEclipseProject(|project://hsqldb-2.3.1|);
	before = userTime();
	println("Measures for \"hsqldb-2.3.1\" project:");
	volumeMeasure = volumeMetricForProject(hsqldbProject);
	print("Lines of code: ");
	print(volumeMeasure.linesOfCode);
	print("\nVolume rating: ");
	print(volumeMeasure.rating);
	println();
	
	complexity = projectComplexity(hsqldbProject);
	println("Complexity rating: <rateComplexity(complexity.lowRiskPercentage, complexity.moderateRiskPercentage, complexity.highRiskPercentage, complexity.veryHighRiskPercentage)>");
	
	println("Unit size rating: <rateUnitSizes(complexity.unitSizes)>");
	
	duplicateMeasure = duplicateMetricForProject(hsqldbProject);
	println("Duplicates rating: <rateDuplicates(duplicateMeasure)>");
	println("benchmark time: <userTime() - before>");

}
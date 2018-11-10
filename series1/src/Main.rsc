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
	performAnalysis(|project://test|);
	performAnalysis(|project://smallsql0.21_src|);
	performAnalysis(|project://hsqldb-2.3.1|);

}

private void performAnalysis(loc project) {
	println("\n*****************************************\n");
	println("Starting measure for <project>\n");
	M3 m3 = createM3FromEclipseProject(project);
	volumeMeasure = volumeMetricForProject(m3);
	complexity = projectComplexity(m3);
	duplicateMeasure = duplicateMetricForProject(m3);
	before = userTime();
	
	println("Volume metric:\n");
	println("Total lines of java code:             <volumeMeasure.linesOfCode>");
	println("Volume rating based on lines of code: <ratingDisplayValue(volumeMeasure.rating)>\n");
	println("-------");
	println("Complexity metric:");
	println("Complexity rating: <ratingDisplayValue(rateComplexity(complexity.lowRiskPercentage, complexity.moderateRiskPercentage, complexity.highRiskPercentage, complexity.veryHighRiskPercentage))>\n");
	println("-------");
	println("Unit size metric:");
	println("Unit size rating: <ratingDisplayValue(rateUnitSizes(complexity.unitSizes))>\n");
	println("-------");
	println("Duplicates metric:\n");
	println("Duplicates rating: <ratingDisplayValue(rateDuplicates(duplicateMeasure))>\n");
	println("-------");
	//TODO print this as nice date time
	println("benchmark time: <userTime() - before>\n");
	println("-------");
	//TODO implement overal scores
	println("Overal scores:\n");
	println("TODO");
	println("\n*****************************************\n");
}

private str ratingDisplayValue(int rating) {
	switch(rating) {
		case 1: return "--";
		case 2: return "-";
		case 3: return "o";
		case 4: return "+";
		case 5: return "++";
		default: return "?";
	}
}


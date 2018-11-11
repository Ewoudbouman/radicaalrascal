module Main

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import IO;

import VolumeMetric;
import ComplexityMetric;
import DuplicateMetric;
import UnitSizeMetric;
import util::Benchmark;
import util::Math;

public void main() {
	performAnalysis(|project://test|);
	performAnalysis(|project://smallsql0.21_src|);
	performAnalysis(|project://hsqldb-2.3.1|);

}

private void performAnalysis(loc project) {
	println("\n*****************************************\n");
	println("Starting measure for <project>\n");
	before = userTime();
	M3 m3 = createM3FromEclipseProject(project);
	volumeMeasure = volumeMetricForProject(m3);
	complexity = projectComplexity(m3);
	duplicateMeasure = duplicateMetricForProject(m3);
	overallMeasure = overallRating(volumeMeasure.rating, rateUnitSizes(complexity.unitSizes), 
		rateComplexity(complexity.lowRiskPercentage, complexity.moderateRiskPercentage, complexity.highRiskPercentage, complexity.veryHighRiskPercentage), rateDuplicates(duplicateMeasure));
	
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
	println("Overal scores:\n");
	println("Analysability: <ratingDisplayValue(overallMeasure.analysability)>");
	println("Changeability: <ratingDisplayValue(overallMeasure.changeability)>");
	println("Testability: <ratingDisplayValue(overallMeasure.testability)>\n");
	println("Maintainability: <ratingDisplayValue(overallMeasure.maintainability)>\n");
	println("Analysis took: <nanoToSec(userTime() - before)> seconds\n");
	println("-------");
	println("\n*****************************************\n");
}

private real nanoToSec(int nano) {
	return nano / 1000000000.0;
}

private tuple[int analysability, int changeability, int testability, int maintainability] overallRating(int volume, int unitSize, int complexity, int duplication) {
	real volumeRating = volume * 1.0;
	real unitSizeRating = unitSize * 1.0;
	real complexityRating = complexity * 1.0;
	real duplicationRating = duplication * 1.0;
	
	real analysabilityRating = (volumeRating + duplicationRating + unitSizeRating) / 3.0;
	real changeabilityRating = (complexityRating + duplicationRating) / 2.0;
	real testabilityRating = (complexityRating + unitSizeRating) / 2.0;
	real maintainability = (analysabilityRating + changeabilityRating + testabilityRating) / 3;
	
	return <round(analysabilityRating), round(changeabilityRating), round(testabilityRating), round(maintainability)>;
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


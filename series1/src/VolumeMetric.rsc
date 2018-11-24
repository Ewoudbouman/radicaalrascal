module VolumeMetric

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import LocProvider;
import Tuple;

/**
 * Gets the volume metric for the given project and returns a tuple containing the total LoC 
 * and a rating
 */
public tuple[int linesOfCode, int rating]  volumeMetricForProject(M3 project) {
	int linesOfCode = locOfProject(project);
	int rating = rateVolume(linesOfCode);
	return <linesOfCode,rating>;
}

/**
 * Rates the volume for java systems based on
 * the paper Practical Model for Measuring Maintainability
 * by I. Heitlager, T. Kuipers, and J. Visser.
 *
 * ++ -> 0-66k -> 5
 * + -> 66k-246k -> 4
 * o -> 246k-665k -> 3
 * - -> 665k-1310k -> 2
 * -- -> 1310k+ -> 1
 */

public int rateVolume(int linesOfCode){
	if(linesOfCode >= 0 && linesOfCode <= 66000) {
		return 5;
	} else if(linesOfCode >  66000 && linesOfCode <= 246000) {
		return 4;
	} else if(linesOfCode > 246000 && linesOfCode <= 665000) {
		return 3;
	} else if(linesOfCode > 665000 && linesOfCode <= 1310000) {
		return 2;
	} else {
		return 1;
	}	
}
module VolumeMetric

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import LocProvider;
import Tuple;

/**
 * Gets the volume metric for the given project and returns a tuple containing the total LoC 
 * and a rating based on the table found in "I. Heitlager, T. Kuipers, and J. Visser. A Practical Model for Measuring Main- tainability."
 */
public tuple[int linesOfCode, int rating]  volumeMetricForProject(M3 project) {
	int linesOfCode = locOfProject(project);
	int rating;
	if(linesOfCode > 0 && linesOfCode <= 66000) {
		rating = 0;
	} else if(linesOfCode >  66000 && linesOfCode <= 246000) {
		rating = 1;
	} else if(linesOfCode > 246000 && linesOfCode <= 665000) {
		rating = 2;
	} else if(linesOfCode > 665000 && linesOfCode <= 1310000) {
		rating = 3;
	} else {
		rating = 5;
	}
	return <linesOfCode,rating>;
}
module DuplicateMetric

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import IO;
import List;
import Set;
import String;
import util::Math;
import util::Benchmark;

/**
 * 
 */
public real duplicateMetricForProject(M3 project) {
	tuple[int, int] results = flattenResource((project));
	real stats = (toReal(results[0])) / (toReal(results[1])) * 100.0;
	return stats;
}

/**
 * 
 */
public str rateDuplicates(real stats) {

	if (stats <= 3.0) {
		return ("++");
	} else if (stats > 3.0 && stats <= 5.0) {
		return ("+");
	} else if (stats > 5.0 && stats <= 10.0) {
		return ("o");
	} else if (stats > 10.0 && stats <= 20.0) {
		return "-";
	} else {
		return "--";
	}	
}

/**
* Count duplicates as blocks.
*
* Can give weird results if there are large number of identical repeating lines,
* will give a large number of duplicates while sliding over them.
* Not very problematic for real world codebase examples?
*/
public int hitWindow(str windowText, set[str] windows) {
	if (windowText in windows) {
		return 1;
	} else {
		return 0;
	} 
}

/**
* Count duplicates as lines.
* Need to check if duplicate lines occur after the block.
* If so add these lines 1 by 1 while sliding over them.
* 
*/

tuple[bool, int] compareWindow(str windowText, bool windowOverlap, set[str] windows, int windowBlock) {
	if (windowText in windows && windowOverlap) {
		return <true, 1>;
	} else if (windowText in windows) {
		return <true, 1>;
	} else {
		return <false, 0>;
	}
}

/**
* Checks for duplicate blocks.
*/

tuple[set[str], int, int] moveWindow(list[str] text, set[str] blocks, int windowBlock) {
	int count = 0;
	int countBlock = 0;
	// check if file is big enough for a window
	if(size(text) < windowBlock) {
		return <blocks, count, countBlock>;
	}
	for (int i <- [0 .. (size(text) - windowBlock + 1)]) {
		flatten = "";
		for (code <- (slice(text, i, windowBlock))){
			flatten += code;
		}
		count += hitWindow(flatten, blocks);
		blocks += flatten;
		countBlock += 1;
	}
	return <blocks, count, countBlock>;
}

/**
* Checks for duplicate lines.
*/

tuple[set[str], int, int] moveWindowLines(list[str] text, set[str] blocks, int windowBlock) {
	int count = 0;
	int countBlock = 0;
	bool windowOverlap = false;
	// check if file is big enough for a window
	if(size(text) < windowBlock) {
		return <blocks, count, countBlock>;
	}
	for (int i <- [0 .. (size(text) - windowBlock + 1)]) {
		flatten = "";
		for (code <- (slice(text, i, windowBlock))){
			flatten += code;
		}
		tuple[bool, int] checkedBlock = compareWindow(flatten, windowOverlap, blocks, windowBlock);
		blocks += flatten;
		windowOverlap = checkedBlock[0];
		count += checkedBlock[1];
		countBlock += 1;
	}
	return <blocks, count, countBlock>;
}

/**
 * Traverses all files in a project.
 *
 */	
 
tuple[int, int] flattenResource(M3 project) {
	int dups = 0;
	int windowBlock = 6;
	int totBlocks = 0;
	set[str] blocks = {};
	list[str] content = [];
	
	for (resource <- files(project)) {
		content = [ trim(x) | x <- (readFileLines(resource))];
		tuple[set[str], int, int] dupCheck = moveWindow(content, blocks, windowBlock);
		blocks = dupCheck[0];
		dups += dupCheck[1];
		totBlocks += dupCheck[2];
	}
	return <dups, totBlocks>;
}
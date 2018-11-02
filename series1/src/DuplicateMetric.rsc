module DuplicateMetric

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import IO;
import List;
import Set;
import String;

/**
 * Stupid bruteforce idea to check how rascall works.
 * todo: improve and optimize
 */

/**
 * Returns the number of duplicate code blocks.
 */
public int duplicateMetricForProject(M3 project) {
	list[str] flat = flattenResource((project));
	list[list[str]] flattenGrid = duplicateGrid(flat);
	// stupid bruteforce
	int duplicates = size((flattenGrid)) - size(dup(flattenGrid));
	return duplicates;
}

/**
 * Flattens a set of files by line break
 *
 * ala: https://github.com/usethesource/rascal/blob/c3d74d466e17944880a17c74ed6aea49e3a97433/src/org/rascalmpl/library/demo/common/Crawl.rsc
 */	
 
public list[str] flattenResource(M3 project) {
	flatten = "";
	for (resource <- files(project)) {
		flatten += readFile(resource);
	}
	list[str] splitFlatten = split("\n", flatten);
	return splitFlatten;
}

/**
 * Turns a flattened set of files in a codeblock per x lines.
 */
 
public list[list[str]] duplicateGrid(list[str] source) {
	gridSize = 6;
	list[list[str]] flattenGrid = [[]];
	//check iff size - 1
	for (int i <- [0 .. (size(source) - gridSize)]) {
		flattenGrid += [slice(source, i, gridSize)];
	}
	return flattenGrid;
}
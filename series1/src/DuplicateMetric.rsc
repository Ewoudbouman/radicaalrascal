module DuplicateMetric

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import IO;
import List;
import Set;
import LocProvider;
import Set;
import String;
import util::Math;
import util::Benchmark;

/**
 *
 */
public int duplicatesForProject(M3 project) {
	blocks = blocksForProject(project);
	return size(findDuplicates(blocks));
}

/**
 *
 */
public int rateDuplicates(int duplicates, int total, bool output=true) {
	real pct = (toReal(duplicates)) / (toReal(total)) * 100.0;
	// can be disabled for debugging purposes.
	if (output) {
		println("Found duplicate lines: 		<duplicates>");
		println("Total amount of lines:         <total>");
		println("Duplication percentage:        <pct>\n");
	}
	if (pct <= 3.0) {
		return 5;
	} else if (pct > 3.0 && pct <= 5.0) {
		return 4;
	} else if (pct > 5.0 && pct <= 10.0) {
		return 3;
	} else if (pct > 10.0 && pct <= 20.0) {
		return 2;
	} else {
		return 1;
	}	
}

/**
 * Gets all the blocks found in the project and binds them with their unique identifying set of values, being location of file it's in
 * line index, and line content;
 */
private list[list[tuple[loc,int,str]]] blocksForProject(M3 project) {
	list[list[tuple[loc,int,str]]] blocks = [];
	
	for(file <- [x | x <- methods(project)]) {
		list[str] source = splitFilteredStringsOfResource(file);
		for(i <- [0..size(source)]) {
			if(size(source) >= (i+6)) {
				blocks += [[ <file,x,source[x]> | x <- [i..(i+6)] ]];
			}
		}
	}
	return blocks;	
}

/**
 *
 */
private set[tuple[loc,int,str]] findDuplicates(list[list[tuple[loc,int,str]]] blocks) {
	set[tuple[loc,int,str]] duplicates = {};
	map[list[str], list[tuple[loc,int,str]]] searchedBlocks = ();
	for(block <- blocks){
		list[str] lines = [ trim(line) | <x,y,line> <- block];
		if(lines in searchedBlocks) {
			duplicates += {lineTuple | lineTuple <- (block + searchedBlocks[lines])};
		} else {
			searchedBlocks[lines] = block;
		}
	}
	return duplicates;
}
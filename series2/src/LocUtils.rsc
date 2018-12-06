module LocUtils

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import IO;
import List;
import Set;
import String;
import util::Math;


import Utils;

/**
 * Counts the loc of all files found in the project
 * 
 * Way to retrieve all files from the project:
 * https://github.com/usethesource/rascal/blob/master/src/org/rascalmpl/library/lang/java/m3/Core.rsc (#187)
 */
public int locOfProject(M3 project) {
	return sum( [locOfResource(resource) | resource <- files(project)]);
}

public real locPercentage(int linesOfCode, int totalLinesOfCode) {
	if(linesOfCode == 0) return 0.0;
	if(totalLinesOfCode == 0) return 100.0;
	return (toReal(linesOfCode) / toReal(totalLinesOfCode)) * 100.0;
}

/** 
 * Counts the total lines of code in the given resource location
 * This excludes empty empty lines and variations of code comments
 */
public int locOfResource(loc resource) {
	str strippedText = resourceContent(resource);
	strippedText = removeComments(strippedText);
	list[str] splitText = splitByNewLineAndFilterEmptyLines(strippedText);
	return size(splitText);
}

public list[str] splitFilteredStringsOfResource(loc resource) {
	str strippedText = resourceContent(resource);
	strippedText = removeComments(strippedText);
	list[str] splitText = splitByNewLineAndFilterEmptyLines(strippedText);
	return splitText;
}

private str removeTabsAndSpaces(str text) {
	str noTabs = replaceAll(text, "\t", "");
	return replaceAll(noTabs, " ", "");
}

/** 
 * Removes all comments from the given text
 * https://blog.ostermiller.org/find-comment
 */
public str removeComments(str text) {
	return visit(text){
		case /(\/\/.*)|(\/\*(?:.|[\n\r])*?\*\/)/ => ""
	};
}

public list[str] splitByNewLineAndFilterEmptyLines(str text) {
	return [ line | line <- split("\n", text), /^[\s\t]*$/ !:= line ];
}

module LocProvider

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import IO;
import List;
import Set;
import String;

/**
 * Counts the loc of all classes found in the project
 * 
 * Way to retrieve all classes from the project:
 * https://github.com/usethesource/rascal/blob/master/src/org/rascalmpl/library/lang/java/m3/Core.rsc (#187)
 */
public int locOfProject(M3 project) {
	return sum( [locOfResource(resource) | resource <- files(project)]);
}

public real locPercentage(int linesOfCode, int totalLinesOfCode) {
	real lines = 1.0 * linesOfCode;
	real total = 1.0 * totalLinesOfCode;
	return (lines / total) * 100;
}

/**
 * Reads a resource location and returns a list of strings for every line that's in the resource location
 * http://tutor.rascal-mpl.org/Rascal/Rascal.html#/Rascal/Libraries/Prelude/IO/readFileLines/readFileLines.html
 */
public str readResource(loc resource) {
	return readFile(resource);
}

/** 
 * Counts the total lines of code in the given resource location
 * This excludes empty empty lines and variations of code comments
 */
public int locOfResource(loc resource) {
	str strippedText = readResource(resource);
	strippedText = removeComments(strippedText);
	list[str] splitText = splitByNewLineAndFilterEmptyLines(strippedText);
	//println("start <resource>");
	//for(line <- splitText) {
	//	println(line);
	//}
	//println("end <resource>");
	return size(splitText);
}

public list[str] splitFilteredStringsOfResource(loc resource) {
	str strippedText = readResource(resource);
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

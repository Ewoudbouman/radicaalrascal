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
	strippedText = removeTabsAndSpaces(strippedText);
	strippedText = removeComments(strippedText);
	list[str] splitText = splitByNewLine(strippedText);
	return size(filterEmptyStrings(splitText));
}

private str removeTabsAndSpaces(str text) {
	str noTabs = replaceAll(text, "\t", "");
	return replaceAll(noTabs, " ", "");
}

/** 
 * Removes all comments from the given text
 * https://stackoverflow.com/questions/1657066/java-regular-expression-finding-comments-in-code
 */
public str removeComments(str text) {
	return visit(text){
		// Multi lined and single line comments
		case /\/\/.*|(\"(?:\\\\[^\"]|\\\\\"|.)*?\")|(?s)\/\\*.*?\\*\// => ""
	};
}

private list[str] splitByNewLine(str text) {
	return split("\n", text);
}

private list[str] filterEmptyStrings(list[str] strings) {
	return [ x | str x <- strings, !isEmpty(x)];
}
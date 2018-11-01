module LocProvider

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import IO;
import List;
import String;

/**
 * Counts the loc of all classes found in the project
 * 
 * Way to retrieve all classes from the project:
 * https://github.com/usethesource/rascal/blob/master/src/org/rascalmpl/library/lang/java/m3/Core.rsc (#187)
 */
public int locOfProject(M3 project) {
	return sum( [locOfResource(class) | class <- classes(project)]);
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
	list[str] splitText = filterEmptyStrings(splitByNewLine(strippedText));
	return size(splitText);
}

private str removeTabsAndSpaces(str text) {
	str noTabs = replaceAll(text, "\t", "");
	return replaceAll(noTabs, " ", "");
}

private str removeComments(str text) {
	return visit(text){
		// Multi line comments. Every single amount of any char between /* and */
		case /\/\*([\s\S]*)\*\// => ""
		// Single line comments (starting with // and everything beyond till line break
		case /\/\/.*/ => ""
	};
}

private list[str] splitByNewLine(str text) {
	return split("\n", text);
}

private list[str] filterEmptyStrings(list[str] strings) {
	return [ x | str x <- strings, !isEmpty(x)];
}
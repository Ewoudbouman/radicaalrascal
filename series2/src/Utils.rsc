module Utils
import IO;

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;

public str resourceContent(loc resource) {
	return readFile(resource);
}

public M3 createProject(loc location) {
 	return createM3FromEclipseProject(location);
}

public set[Declaration] projectAsts(M3 project) {
	return {createAstFromFile(file, true) | file <- files(project)};
}

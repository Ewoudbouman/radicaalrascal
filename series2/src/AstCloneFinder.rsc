module AstCloneFinder

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;
import IO;

import Utils;

public lrel[loc fst, loc snd] findType1Clones(M3 project) {
	set[Declaration] asts =  projectAsts(project);
	
	return [];
}
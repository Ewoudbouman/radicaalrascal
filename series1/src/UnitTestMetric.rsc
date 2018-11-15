module UnitTestMetric

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;

import List;
import IO;

/**
 * check: https://www.microsoft.com/en-us/research/publication/assessing-the-relationship-between-software-assertions-and-code-qualityan-empirical-investigation/
 */
 
/**
 * Idea, count all asserts (also mentioned in SIG paper.
 *
 * If wanted, this can easily be combined with the complexity metric using only the findAsserts logic.
 */
 
public int unitTestAbility(M3 project) {
	int results = 0;
	for (file <- files(project)){
		results += fileAssert(file);
	}
	return results;
}

public int fileAssert(loc class){
	result = 0;
	visit(createAstFromFile(class, false)) {
		case method:\method(_, _, _, _, _) : result += findAsserts(method);
	}
	return result;
}

public int findAsserts(method) {
	int result = 0;
	visit (method) {
		case \assert(_) : result += 1;
		case \assert(_, _) : result += 1;
	}
	return result;
}
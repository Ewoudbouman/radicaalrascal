module UnitParamMetric

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;

import List;
import IO;

/**
 * Returns the umber of parameters (unit interfacing) per class/...
 * Check paper Deriving Metric Thresholds from Benchmark Data for thresholds
 */
public list[int] unitParams(loc project) {
	// need single approach, translate to M3?
	ast = createAstsFromEclipseProject(project , true);
	list [int] paramCount = countParams(ast);
	//perhaps check distribution?
	distParams = distribution(paramCount);
	return paramCount;
}

/**
 * Returns the number of parameters for the given method.
 */
public list[int] countParams(set[Declaration] functions) {
    list [int] params = []; 
    visit (functions) {
        case method: \method(_, _, p , _, _): params += size(p);
    }
    return params;
}


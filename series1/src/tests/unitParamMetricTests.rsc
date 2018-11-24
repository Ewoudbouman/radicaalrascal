module tests::unitParamMetricTests

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;
import IO;
import List;

import UnitParamMetric;

loc file = |project://testSLOC|;

/**
 * Check if the params are counted correctly at the method level.
 */
test bool numbParams() {
	ast = createAstsFromEclipseProject(file, true);
	params = countParams(ast);
	return (sum(params) == 6);
}

/**
 * Check if the param distribution is correct.
 */
test bool distParams() {
	result = rateUnitParams(file);
	return (result == <0.75, 0.25, 0.0, 0.0>);
}

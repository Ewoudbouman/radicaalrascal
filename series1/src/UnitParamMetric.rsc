module UnitParamMetric

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;
import analysis::statistics::Frequency;
import List;
import IO;

/** 
 * Returns the result of the unit interface metric.
 */
public int unitParamsForProject(loc project) {
	result = rateUnitParams(project);
	return unitParamsMetric(result);
}

/**
 * Returns the percentage of parameters (unit interfacing) per project
 */
public tuple[num low, num moderate, num high, num veryHigh] rateUnitParams(loc project) {
	ast = createAstsFromEclipseProject(project , true);
	list [int] paramCount = countParams(ast);
	params = mapper(paramCount, valMax);
	tuple[num low, num moderate, num high, num veryHigh] pct = 
		<(pct(params, 0) + pct(params, 1) + pct(params, 2)), 
		pct(params, 3), pct(params, 4), pct(params, 5)>;

	return pct;
}

/**
 * Returns the metric for the unit interfacing.
 * Based on the paper Benchmark-based Aggregation of Metrics to Ratings
 *
 * ++ -> (moderate < 12.1% and high < 5.4% && very-high 2.2%) -> 5
 * + -> (moderate < 14.9% and high < 7.2% && very-high 3.1%) -> 4
 * o -> (moderate < 17.7% and high < 10.2% && very-high 4.8%) -> 3
 * - -> (moderate < 25.2% and high < 15.3% && very-high 7.1%) -> 2
 * -- (else) -> -> 1
 */
public int unitParamsMetric(tuple [num low, num moderate, num high, num veryHigh] pct, bool output=true) {
	if (output) {
	   	println("\nUnit Interfacing groups:");
	   	println("Low risk percentage:            <pct.low>");
		println("Moderate risk percentage:         <pct.moderate>");
		println("High risk percentage:            <pct.high>");
		println("Very high risk percentage:  <pct.veryHigh>\n");
	}
	if (pct.moderate <= 12.1 && pct.high <= 5.4 && pct.veryHigh <= 2.2) {
		return 5;
	} else if (pct.moderate <= 14.9 && pct.high <= 7.2 && pct.veryHigh <= 3.1) {
		return 4;
	} else if (pct.moderate <= 17.7 && pct.high <= 10.2 && pct.veryHigh <= 4.8) {
		return 3;
	} else if (pct.moderate <= 25.2 && pct.high <= 15.3 && pct.veryHigh <= 7.1) {
		return 2;
	} else {
		return 1;
	}
}

/**
 * Returns the total number of parameters for the given methods.
 */
public list[int] countParams(set[Declaration] functions) {
    list [int] params = [];
    visit (functions) {
        case m: \method(_, _, p , _, _):
        	params += size(p);
		case c :\constructor(_, p, _, _): 
			params += size(p);
    }
    return params;
}

/**
 * Bins a value above a threshold to a maximum value.
*/
private int valMax(int x) {
	if (x < 5) {
		return x;
	} else {
		return 5;
	}
}
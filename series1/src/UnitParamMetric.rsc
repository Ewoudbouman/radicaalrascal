module UnitParamMetric

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;
import analysis::statistics::Frequency;

import List;
import IO;

/**
 * Returns the umber of parameters (unit interfacing) per class/...
 * Check paper Deriving Metric Thresholds from Benchmark Data for thresholds
 */
public int rateUnitParams(loc project, bool output=true) {
	// todo need single approach, translate to M3?
	// todo check iff performance?
	ast = createAstsFromEclipseProject(project , true);
	list [int] paramCount = countParams(ast);
	params = maxParam(paramCount);
	tuple[num low, num moderate, num high, num veryHigh] percent = 
		<(pct(params, 0) + pct(params, 1) + pct(params, 2)), 
		pct(params, 3), pct(params, 4), pct(params, 5)>;

   	if (output) {
	   	println("\nUnit Interfacing groups:");
	   	println("Low risk percentage:            <percent.low>");
		println("Moderate risk percentage:         <percent.moderate>");
		println("High risk percentage:            <percent.high>");
		println("Very high risk percentage:  <percent.veryHigh>\n");
	}

	return unitParamsMetric(percent.low, percent.moderate, percent.high, percent.veryHigh);
}

/**
 * Based on TABLE III from Benchmark-based Aggregation of Metrics to Ratings from the sig boys
 * http://wiki.di.uminho.pt/twiki/pub/Personal/Tiago/Publications/mensura11-alves.pdf
 */
public int unitParamsMetric(num low, num moderate, num high, num veryHigh) {
	if (moderate <= 12.1 && high <= 5.4 && veryHigh <= 2.2) {
		return 5;
	} else if (moderate <= 14.9 && high <= 7.2 && veryHigh <= 3.1) {
		return 4;
	} else if (moderate <= 17.7 && high <= 10.2 && veryHigh <= 4.8) {
		return 3;
	} else if (moderate <= 25.2 && high <= 15.3 && veryHigh <= 7.1) {
		return 2;
	} else {
		return 1;
	}
}

/**
 * Returns the number of parameters for the given method.
 */
public list[int] countParams(set[Declaration] functions) {
    list [int] params = [];
    visit (functions) {
        case m: \method(_, _, p , _, _):
        	params += size(p);
        // ff docs beter doorpluizen, volgens mij deze niet?
        //case m2: \method(_, _, p , _): 
        //	params += size(p);
		case c :\constructor(_, p, _, _): 
			params += size(p);
    }
    return params;
}

/**
 * Bins values in a list exceeding a threshold to a maximum value.
*/
public list[int] maxParam(list[int] params) {
	list[int] maxParams = [];
	int max = 5;
	for (x <- params) {
		if ( x < max) {
			maxParams += x;
		} else {
			maxParams += max;
		}
	}
	return maxParams;
}

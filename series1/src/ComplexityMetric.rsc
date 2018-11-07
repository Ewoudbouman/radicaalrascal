module ComplexityMetric

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;
import LocProvider;
import IO;
import List;
import String;
import Set;


public int rateComplexity(real lowRiskPercentage, real moderateRiskPercentage, real highRiskPercentage, real veryHighRiskPercentage) {
	
	println("\nComplexity groups: ");
	println("Low risk percentage: <lowRiskPercentage>");
	println("Moderate risk percentage: <moderateRiskPercentage>");
	println("High risk percentage: <highRiskPercentage>");
	println("Very High risk percentage: <veryHighRiskPercentage>\n");
	
	if(moderateRiskPercentage <= 25.0 && highRiskPercentage <= 0.0 && veryHighRiskPercentage <= 0.0) {
		return 5;
	} else if(moderateRiskPercentage <= 30.0 && highRiskPercentage <= 5.0 && veryHighRiskPercentage <= 0.0) {
		return 4;
	} else if(moderateRiskPercentage <= 40.0 && highRiskPercentage <= 10.0 && veryHighRiskPercentage <= 0.0) {
		return 3;
	} else if(moderateRiskPercentage <= 50.0 && highRiskPercentage <= 15.0 && veryHighRiskPercentage <= 5.0) {
		return 2;
	} else {
		return 1;
	}
}

/** 
 * Creates a complexity report of the project
 *
 * Only takes the classes of the project into account, since these are the only type of files containing methods/blocks of code
 * NOTE: it's very important to take the FILES.. not the classes. otherwise the ASTs method locations are messed up 
 * due to not taking anything above the class declaration into account.
 */
public tuple[real lowRiskPercentage, real moderateRiskPercentage, real highRiskPercentage, 
		real veryHighRiskPercentage, list[int] unitSizes] projectComplexity(M3 project) {
	lrel[int,int] results = [];
	for (file <- files(project)){
		results += fileComplexity(file);
	}
	real lowRiskPercentage = 0.0;
	real moderateRiskPercentage = 0.0;
	real highRiskPercentage = 0.0;
	real veryHighRiskPercentage = 0.0;
	list[int] unitSizes = [ y | <x,y> <- results];
	int totalLinesMeasured = sum(unitSizes);	
	
	for(<x,y> <- [<rateComplexity(x),locPercentage(y, totalLinesMeasured)> | <x,y> <- results]) {
		switch(x) {
			case 1: lowRiskPercentage += y;
			case 2: moderateRiskPercentage += y;
			case 3: highRiskPercentage += y;
			case 4: veryHighRiskPercentage += y;
		}
	}
	return <lowRiskPercentage, moderateRiskPercentage, highRiskPercentage, veryHighRiskPercentage, unitSizes>;
}

/**
 * Rates the cyclomatic complexity
 * 1-10  -> without much risk -> 1
 * 11-20 -> moderate risk	  -> 2
 * 21-50 -> high risk 		  -> 3
 * > 50	 -> very high risk 	  -> 4
 */
private int rateComplexity(int cc) {
	if(cc <= 10) {
		return 1;
	} else if(cc > 10 && cc <= 20) {
		return 2;
	} else if(cc > 20 && cc <= 50) {
		return 3;
	} else {
		return 4;
	}	
}

/**
 * Creates a complexity report for the given class.
 *
 * Takes the various types of methods + the constructor into account, since these are the only class top level declarations
 * containing code blocks
 *
 * The documentation of used methods can be found here:
 * http://tutor.rascal-mpl.org/Rascal/Rascal.html#/Rascal/Libraries/lang/java/m3/AST/Declaration/Declaration.html
 */
public lrel[int complexity, int linesOfCode] fileComplexity(loc class) {
	lrel[int,int] result = [];
	visit(createAstFromFile(class, false)) {
		case method:\method(_, _, _, _, _) : result += <methodComplexity(method),locOfResource(method.src)>;
		case method:\method(_, _, _, _) : result += <methodComplexity(method),locOfResource(method.src)>;
		case constructor:\constructor(_, _, _, _) : result += <methodComplexity(method),locOfResource(constructor.src)>;
	}
	return result;
}

/**
 * Creates a complexity report for the given method.
 *
 * Using this approach:
 * https://stackoverflow.com/questions/40064886/obtaining-cyclomatic-complexity
 * http://gmetrics.sourceforge.net/gmetrics-CyclomaticComplexityMetric.html
 *
 * The declarations of these can be found here:
 * http://tutor.rascal-mpl.org/Rascal/Rascal.html#/Rascal/Libraries/lang/java/m3/AST/Declaration/Declaration.html
 */
public int methodComplexity(method) {
   int result = 1;
    visit (method) {
        case \if(_,_) : result += 1;
        case \if(_,_,_) : result += 1;
        case \case(_) : result += 1;
        case \do(_,_) : result += 1;
        case \while(_,_) : result += 1;
        case \for(_,_,_) : result += 1;
        case \for(_,_,_,_) : result += 1;
        case foreach(_,_,_) : result += 1;
        case \catch(_,_): result += 1;
        case \conditional(_,_,_): result += 1;
        case infix(_,"&&",_) : result += 1;
        case infix(_,"||",_) : result += 1;
    }
    return result;
}
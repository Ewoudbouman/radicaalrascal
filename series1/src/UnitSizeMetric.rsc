module UnitSizeMetric

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;
import LocProvider;
import IO;
import List;
import String;
import Set;

/**
 *
 */
public int rateUnitSizes(list[int] unitSizes, bool output=true) {
   	pct = groupUnitSizes(unitSizes);
   	// can be disabled for debugging purposes.
   	if (output) {
	   	println("\nUnit size groups:");
	   	println("Small sized percentage:            <pct.small>");
		println("Moderate sized percentage:         <pct.moderate>");
		println("Large sized percentage:            <pct.large>");
		println("Very large sized risk percentage:  <pct.veryLarge>\n");
	}
	if(pct.moderate <= 15.0 && pct.large <= 5.0 && pct.veryLarge <= 0.0) {
		return 5;
	} else if(pct.moderate <= 20.0 && pct.large <= 15.0 && pct.veryLarge <= 5.0) {
		return 4;
	} else if(pct.moderate <= 30.0 && pct.large <= 20.0 && pct.veryLarge <= 5.0) {
		return 3;
	} else if(pct.moderate <= 40.0 && pct.large <= 25.0 && pct.veryLarge <= 10.0) {
		return 2;
	} else {
		return 1;
	}
}

/**
 *
 */
public tuple[real small, real moderate, real large, real veryLarge] groupUnitSizes(list[int] unitSizes) {
	real small = 0.0;
	real moderate = 0.0;
	real large = 0.0;
	real veryLarge = 0.0;
	int totalSize = sum(unitSizes);	
	for(<x,y> <- [<rateSize(x),locPercentage(x, totalSize)> | x <- unitSizes]) {
		switch(x) {
			case 1: small += y;
			case 2: moderate += y;
			case 3: large += y;
			case 4: veryLarge += y;
		}
	}
	return <small, moderate, large, veryLarge>;
}

/**
 *
 */
private int rateSize(int size) {
	if(size <= 15) {
		return 1;
	} else if(size > 15 && size <= 30) {
		return 2;
	} else if(size > 30 && size <= 60) {
		return 3;
	} else {
		return 4;
	}	
}

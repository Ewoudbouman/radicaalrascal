module UnitSizeMetric

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;
import LocProvider;
import IO;
import List;
import String;
import Set;

public int rateUnitSizes(list[int] unitSizes, bool output=true) {
   	tuple[real small, real moderate, real large, real veryLarge] percentages = groupUnitSizesWithPercentage(unitSizes);
   	
   	if (output) {
	   	println("\nUnit size groups:");
	   	println("Small sized percentage:            <percentages.small>");
		println("Moderate sized percentage:         <percentages.moderate>");
		println("Large sized percentage:            <percentages.large>");
		println("Very large sized risk percentage:  <percentages.veryLarge>\n");
	}
	
	if(percentages.moderate <= 15.0 && percentages.large <= 5.0 && percentages.veryLarge <= 0.0) {
		return 5;
	} else if(percentages.moderate <= 20.0 && percentages.large <= 15.0 && percentages.veryLarge <= 5.0) {
		return 4;
	} else if(percentages.moderate <= 30.0 && percentages.large <= 20.0 && percentages.veryLarge <= 5.0) {
		return 3;
	} else if(percentages.moderate <= 40.0 && percentages.large <= 25.0 && percentages.veryLarge <= 10.0) {
		return 2;
	} else {
		return 1;
	}
}

// private -> public
public tuple[real smallSizePercentage, real moderateSizePercentage, real largeSizePercentage, real veryLargeSizePercentage] 
		groupUnitSizesWithPercentage(list[int] unitSizes) {
	real smallSize = 0.0;
	real moderateSize = 0.0;
	real largeSize = 0.0;
	real veryLargeSize = 0.0;
	int totalSize = sum(unitSizes);	
	
	for(<x,y> <- [<rateSize(x),locPercentage(x, totalSize)> | x <- unitSizes]) {
		switch(x) {
			case 1: smallSize += y;
			case 2: moderateSize += y;
			case 3: largeSize += y;
			case 4: veryLargeSize += y;
		}
	}
	return <smallSize, moderateSize, largeSize, veryLargeSize>;
}

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

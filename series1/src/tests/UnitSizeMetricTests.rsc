module tests::UnitSizeMetricTests

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;

import UnitSizeMetric;

M3 m3 = createM3FromEclipseProject(|project://test|);

test bool rateUnitSizes1() {
	return (rateUnitSizes([0, 51, 16, 6], output=false) == 1);
}
/*

test bool rateUnitSizes2() {
	return (rateUnitSizes([0, 49, 14, 4], output=false) == 2);
}

test bool rateUnitSizes3() {
	return (rateUnitSizes([0, 39, 9, 0], output=false) == 3);
}

test bool rateUnitSizes4() {
	return (rateUnitSizes([0, 29, 5, 0], output=false) == 4);
}

test bool rateUnitSizes5() {
	return (rateUnitSizes([0, 24, 0, 0], output=false) == 5);
}
*/
test bool groupUnitSizesWithPercentage1() {
	//println(groupUnitSizesWithPercentage([0, 24, 0, 0]));
	return true;
}
module tests::ComplexityMetricTests

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;

import ComplexityMetric;

M3 m3 = createM3FromEclipseProject(|project://test|);

test bool rateComplexity1() {
	return (rateComplexity(0.0, 51.0, 16.0, 6.0, output=false) == 1);
}

test bool rateComplexity2() {
	return (rateComplexity(0.0, 50.0, 15.0, 5.0, output=false) == 2);
}

test bool rateComplexity3() {
	return (rateComplexity(0.0, 40.0, 10.0, 0.0, output=false) == 3);
}

test bool rateComplexity4() {
	return (rateComplexity(0.0, 30.0, 5.0, 0.0, output=false) == 4);
}

test bool rateComplexity5() {
	return (rateComplexity(0.0, 25.0, 0.0, 0.0, output=false) == 5);
}

test bool projectComplexity1() {
	return (projectComplexity(m3) == <14.10256410200,0.0,85.8974359000,0.0,[2,7,67,2]>);
}

// find relevant stuff for:
// fileComplexity
// methodComplexity
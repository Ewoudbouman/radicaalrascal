module tests::UnitSizeMetricTests

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import IO;

import UnitSizeMetric;

// todo: find dummy project

M3 m3 = createM3FromEclipseProject(|project://test|);

test bool rateUnitSizes1() {
	return (rateUnitSizes([0, 51, 16, 6], output=false) == 1);
}


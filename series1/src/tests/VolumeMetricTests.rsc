module tests::VolumeMetricTests

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;

import VolumeMetric;

M3 m3 = createM3FromEclipseProject(|project://test|);

test bool volumeMetricForProject1() {
	return (volumeMetricForProject(m3) == <82, 5>);
}

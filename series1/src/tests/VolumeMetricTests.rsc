module tests::VolumeMetricTests

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import IO;

import VolumeMetric;

/**
 * Test project
 * Based on testcase from https://github.com/Aaronepower/tokei
 */

test bool volumeMetric1() {
	M3 m3 = createM3FromEclipseProject(|project://testSLOC|);
	return (volumeMetricForProject(m3) == <32, 5>);
}

/**
 * test ratings
 */
 
test bool rating0(){
	return (rateVolume(0) == 5);
}

test bool rating1(){
	return (rateVolume(1) == 5);
}

test bool rating2(){
	return (rateVolume(67000) == 4);
}

test bool rating3(){
	return (rateVolume(247000) == 3);
}

test bool rating4(){
	return (rateVolume(666000) == 2);
}

test bool rating5(){
	return (rateVolume(1310001) == 1);
}
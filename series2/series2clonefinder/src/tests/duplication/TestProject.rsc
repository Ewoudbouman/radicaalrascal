module tests::duplication::TestProject

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import IO;
import Utils;
import List;
import Map;
import CloneUtils;
import AstCloneFinder;

/** 
 * Test based on https://plg.uwaterloo.ca/~migod/846/papers/bellon-tse07.pdf
 * around +/- 4
 */
test bool netbeansTestType1() {
	testProject = createProject(|project://netbeans-javadoc|);
	type1Clones = findType1Clones(testProject);
	int result = size(convertToCloneClasses(type1Clones));
	return (result == 4);
}
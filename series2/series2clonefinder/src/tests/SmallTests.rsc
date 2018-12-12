module tests::SmallTests
//
extend tests::duplication::types::type1;
extend tests::duplication::types::type2;
extend tests::duplication::types::type3;
//
import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;
import util::Resources;
import Utils;
import IO;
import List;
import util::Math;
import Node;
import Map;
import Set;

import CloneUtils;
import AstCloneFinder;

// file locs
// t1
public loc t1A = |project://testDUP/src/t1/CopyOneA.java|;
public loc t1B = |project://testDUP/src/t1/CopyOneB.java|;
public loc t1C = |project://testDUP/src/t1/CopyOneC.java|;
// t2

public loc t2A = |project://testDUP/src/t2/CopyTwoA.java|;
public loc t2B = |project://testDUP/src/t2/CopyTwoB.java|;
public loc t2C = |project://testDUP/src/t2/CopyTwoC.java|;
public loc t2D = |project://testDUP/src/t2/CopyTwoD.java|;

// t3
public loc t3A = |project://testDUP/src/t3/CopyThreeA.java|;
public loc t3B = |project://testDUP/src/t3/CopyThreeB.java|;
public loc t3C = |project://testDUP/src/t3/CopyThreeC.java|;
public loc t3D = |project://testDUP/src/t3/CopyThreeD.java|;
public loc t3E = |project://testDUP/src/t3/CopyThreeE.java|;
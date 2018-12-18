module CloneUtils

import IO;
import lang::java::m3::Core;
import lang::java::jdt::m3::AST;
import lang::java::jdt::m3::Core;
import List;
import util::Math;
import Node;
import Map;
import Set;
import Utils;
import Type;

/*
 *
 */
public map[node, set[node]] convertToCloneClasses(lrel[node, node] clones) {
	map[node, set[node]] classes = ();
	for(<x,y> <- clones) {
		// Only x to "key" conversion is required, since both should result in the same key at this point
		node xKey = unsetRec(x);
		if(!classes[xKey]?) {
			classes[xKey] = {x, y};
		} else {
			foundClassList = toList(classes[xKey]);
			int indexOfx = indexOf(foundClassList, x);
			int indexOfy = indexOf(foundClassList, y);
			
			// x is not yet in the list
			if(indexOfx == -1) classes[xKey] += x;
			
			// y is not yet in the list
			if(indexOfy == -1) classes[xKey] += y;
		}
	}
	return classes; 
}

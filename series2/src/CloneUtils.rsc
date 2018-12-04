module CloneUtils

import lang::json::IO;

public list[list[node]] convertToCloneClasses(lrel[node, node] clones) {
	//TODO implement this
	return [];
}

public void writeClones(lrel[node, node] clones) {
	
	writeJSON(|project://series2/src/output/clones.json|, clones);
}
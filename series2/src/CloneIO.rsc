module CloneIO

import IO;
import List;
import util::Math;
import Node;
import Map;
import Set;
import Utils;
import lang::json::IO;

private int idCounter = 0;

private int createId() {
	idCounter += 1;
	return idCounter;
}

public void writeClones(map[node, set[node]] cloneClasses, tuple[real dupPercentage, int dupLoc, int totalLoc] projectStats) {
	tuple[real dupPercentage, int dupLoc, int totalLoc] result = <0.0,0,0>;
	result.dupPercentage = projectStats.dupPercentage;
	result.dupLoc = projectStats.dupLoc;
	result.totalLoc = projectStats.totalLoc;
	
	writeJSON(|project://series2/src/output/clones.json|, 
		("duplicatesPercentage" : projectStats.dupPercentage, 
		"duplicatesLOC" : projectStats.dupLoc, 
		"totalLOC" : projectStats.totalLoc,
		"cloneClasses" : createCloneClassJsonMap(cloneClasses)));
}

public list[map[str, value]] createCloneClassJsonMap(map[node, set[node]] cloneClasses) {
	list[map[str, value]] jsonMaps = [];
	for(<_ ,clones> <- toList(cloneClasses)){
		jsonMaps += ("id" : createId(),
					"LOC" : 1337, 
					"percentageOfProject" : 100.0, 
					"percentageOfDuplicates" : 100.0, 
					"clones" : createCloneJsonMap(clones));
	}
	return jsonMaps;
}

public list[map[str, value]] createCloneJsonMap(set[node] clones) {
	list[map[str, value]] jsonMaps = [];
	for(clone <- clones){
		sourceLoc = nodeSourceLoc(clone);
		jsonMaps += ("id" : createId(),
					"LOC" : 1337, 
					"percentageOfProject" : 100.0, 
					"percentageOfClass" : 100.0, 
					"clone" : getNodeSource(clone),
					"path": sourceLoc.path,
					"file": sourceLoc.file);
	}
	return jsonMaps;
}
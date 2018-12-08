module CloneIO

import IO;
import List;
import util::Math;
import Node;
import Map;
import Set;
import Utils;
import LocUtils;
import CloneLocProvider;
import lang::json::IO;

private int idCounter = 0;
private int cloneType = -1;
private loc project;
private lrel[str id, str source] sources = [];

private str createId() {
	idCounter += 1;
	return "T<cloneType>-<idCounter>";
}

public void writeClones(map[node, set[node]] cloneClasses, tuple[real dupPercentage, int dupLoc] projectStats, int writeType, loc projectLoc) {
	sources = [];
	cloneType = writeType;
	project = projectLoc;
	tuple[list[map[str, value]] jsonMaps, int duplicateLoc] cloneClassesJsonMap = createCloneClassJsonMap(cloneClasses, getTotalProjectLoc());
	writeJSON(|project://series2/src/output/clones.json|, 
		("duplicatesPercentage" : locPercentage(cloneClassesJsonMap.duplicateLoc, getTotalProjectLoc()), 
		"duplicatesLOC" : cloneClassesJsonMap.duplicateLoc, 
		"totalLOC" : getTotalProjectLoc(),
		"cloneClasses" : cloneClassesJsonMap.jsonMaps,
		"fullSources" : createCloneSourcesJsonMap()));
}

public tuple[list[map[str, value]] jsonMaps, int duplicateLoc] createCloneClassJsonMap(map[node, set[node]] cloneClasses, int projectLoc) {
	list[map[str, value]] jsonMaps = [];
	totalDuplicationLoc = 0;
	for(<_ ,clones> <- toList(cloneClasses)) {
		linesCount = getCloneClassLoc(clones);
		totalDuplicationLoc += linesCount;
		jsonMaps += ("id" : createId(),
					"LOC" : linesCount, 
					"percentageOfProject" : locPercentage(linesCount, projectLoc), 
					"clones" : createCloneJsonMap(clones, projectLoc, linesCount));
		
	}
	return <jsonMaps, totalDuplicationLoc>;
}

public list[map[str, value]] createCloneJsonMap(set[node] clones, int projectLoc, int classLoc) {
	list[map[str, value]] jsonMaps = [];
	for(clone <- clones){
		linesCount = getCloneLoc(clone);	
		sourceLoc = nodeSourceLoc(clone);
		id = createId();
		sources += <id, resourceContent(project + sourceLoc.path)>;
		jsonMaps += ("id" : id,
					"LOC" : linesCount, 
					"percentageOfProject" : locPercentage(linesCount, projectLoc), 
					"percentageOfClass" : locPercentage(linesCount, classLoc), 
					"startLine" : sourceLoc.begin.line,
					"endLine" : sourceLoc.end.line,
					"clone" : getNodeSource(clone),
					"path": sourceLoc.path,
					"file": sourceLoc.file);
	}
	return jsonMaps;
}

public list[map [str, value]] createCloneSourcesJsonMap() {
	list[map[str, value]] jsonMaps = [];
	for(<id, source> <- sources) {
		jsonMaps += ("id" : id, "source" : source);
	}
	return jsonMaps;
}
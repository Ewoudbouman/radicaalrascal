module CloneIO

import IO;
import List;
import util::Math;
import Node;
import Map;
import Set;
import Utils;
import String;
import LocUtils;
import CloneLocProvider;
import lang::json::IO;

import LocUtils;

// global parameters
private int idCounter = 0;
private int cloneType = -1;
private loc project;

// vars for clone relations
private map[int, list[int]] cloneMap = ();
private rel[str path, str source] sources = {};
private map[node n, int key] nodeKeyMap = ();

/**
 * Creates an id for each clone
 */
private int createCloneId() {
	idCounter += 1;
	return idCounter;
}

/**
 * Returns the id of a clone,
 * If it does not exist one will be created first
 */
private int getCloneId(node n){
	if (n notin nodeKeyMap) {
		id = createCloneId();
		nodeKeyMap[n] = id;
		return id;
	} else {
		return nodeKeyMap[n];
	}
}

/**
 * Formats the clone id
 */
private str getPrefixId(int id) {
	return "T<cloneType>-<id>";
}


public void writeProjects(list[loc] projects) {
	writeJSON(|project://series2/| + "output/projects/index.json", [x.authority | x <- projects]); 
}

/**
 * Writes the json output to the destination folder.
 */
public void writeClones(map[node, set[node]] cloneClasses, int writeType, loc projectLoc, loc outputLoc) {
	// vars dont reset while console active
	idCounter = 0;
	sources = {};
	cloneMap = ();
	nodeKeyMap = ();
	project = projectLoc;
	cloneType = writeType;

	tuple[list[map[str, value]] jsonMaps, int duplicateLoc] cloneClassesJsonMap = createCloneClassJsonMap(cloneClasses, getTotalProjectLoc());
	tuple[list[map[str, value]] jsonMaps, int duplicateLoc] cloneDirsJsonMap = convertCloneByDirJsonMap(cloneClasses, getTotalProjectLoc(), projectLoc);
	writeJSON(outputLoc, 
		("duplicatesPercentage" : locPercentage(cloneClassesJsonMap.duplicateLoc, getTotalProjectLoc()),
		"label" : projectLoc, 
		"duplicatesLOC" : cloneClassesJsonMap.duplicateLoc, 
		"totalLOC" : getTotalProjectLoc(),
		"cloneClasses" : cloneClassesJsonMap.jsonMaps,
		"nodes" : 
			("children" : cloneDirsJsonMap.jsonMaps),
			"fullSources" : createCloneSourcesJsonMap(),
			"relations": createCloneRelationsJsonMap()
			)
		);
}

/**
 * Creates an Json entry for each clone class.
 */
public tuple[list[map[str, value]] jsonMaps, int duplicateLoc] createCloneClassJsonMap(map[node, set[node]] cloneClasses, int projectLoc) {
	list[map[str, value]] jsonMaps = [];
	totalDuplicationLoc = 0;
	for(<_ ,clones> <- toList(cloneClasses)) {
		curClone = createCloneId();
		linesCount = getCloneClassLoc(clones);
		totalDuplicationLoc += linesCount;
		cloneId = createCloneId();
		jsonMaps += 
			("prefix_id" : getPrefixId(cloneId),
			"id" : cloneId,
			"LOC" : linesCount, 
			"percentageOfProject" : locPercentage(linesCount, projectLoc), 
			"children" : createCloneJsonMap(clones, projectLoc, linesCount, curClone)
			);
	}
	return <jsonMaps, totalDuplicationLoc>;
}

/**
 * Returns all the files in the project that contain duplicate code nodes.
 */
public set[str] duplicationSources(map[node, set[node]] cloneClasses) {
	dupSources = {};
	for(<_ ,clones> <- toList(cloneClasses)) {
		for(clone <- clones){
			dupSources += ((nodeSourceLoc(clone)).path);
		}
	}
	return dupSources;
}
/**
 * Formats duplicates based on file location for the Json output.
 *
 * - file 1
 *      - dupX
 *      - dupY
 *      - dupY
 * - file 2
 *     - dupX
 *
 */
public tuple[list[map[str, value]] jsonMaps, int duplicateLoc] convertCloneByDirJsonMap(map[node, set[node]] cloneClasses, int projectLoc, loc resource) {
	list[map[str, value]] jsonMaps = [];
	totalDuplicationLoc = 0;
	dupSources = duplicationSources(cloneClasses);
	
	for(dupFile <- dupSources) {
		for(<_ ,clones> <- toList(cloneClasses)) {
			if(checkEmptyLeafs(clones, dupFile)) {
				curClone = createCloneId();
				linesCount = getCloneClassLoc(clones);
				totalDuplicationLoc += linesCount;
				cloneId = createCloneId();
				jsonMaps += 
					("prefix_id" : getPrefixId(cloneId),
					"label": dupFile,
					"path" : dupFile,
					"id" : cloneId,
					"LOC" : linesCount, 
					"children" : createCloneDirJsonMap(clones, projectLoc, linesCount, curClone, dupFile)
					);
				}							
		}
	}
	return <jsonMaps, totalDuplicationLoc>;
}

/**
 * Writes the details of each clone to an Json child element.
 */
public list[map[str, value]] createCloneJsonMap(set[node] clones, int projectLoc, int classLoc, int curClone) {
	list[map[str, value]] jsonMaps = [];
	
	if(!cloneMap[curClone]?) cloneMap[curClone] = [];
	
	for(clone <- clones){
		sourceLoc = nodeSourceLoc(clone);
		if(!isEmptyLocation(sourceLoc)) {
			linesCount = getCloneLoc(clone);	
			cloneId = getCloneId(clone);
			cloneMap[curClone] += cloneId;
			sources += <sourceLoc.path, resourceContent(project + sourceLoc.path)>;
			jsonMaps += 
				("prefix_id" : getPrefixId(cloneId),
				"id" :  cloneId,
				"attributes": (
					"LOC" : linesCount, 
					"percentageOfProject" : locPercentage(linesCount, projectLoc), 
					"percentageOfClass" : locPercentage(linesCount, classLoc), 
					"startLine" : sourceLoc.begin.line,
					"endLine" : sourceLoc.end.line,
					"clone" : getNodeSource(clone),
					"path": sourceLoc.path,
					"file": sourceLoc.file
					)
				);
		}
	}
	return jsonMaps;
}

/**
 * Removes empty([]) elements, fix for d3 animation bug that  cannot handle empty childen nodes ([]), 
 */
public bool checkEmptyLeafs (set[node] clones, str dupFile) {
	for(clone <- clones){
		sourceLoc = nodeSourceLoc(clone);
		if(!isEmptyLocation(sourceLoc) && (dupFile == sourceLoc.path)) {
			return true;
		}
	}
	return false;
}

/**
 * Creates an Json entry for the clones for each file in the project.
 */
public list[map[str, value]] createCloneDirJsonMap(set[node] clones, int projectLoc, int classLoc, int curClone, str dupFile) {
	list[map[str, value]] jsonMaps = [];

	for(clone <- clones){
		sourceLoc = nodeSourceLoc(clone);
		if(!isEmptyLocation(sourceLoc) && (dupFile == sourceLoc.path)) {
			linesCount = getCloneLoc(clone);	
			cloneId = getCloneId(clone);
			jsonMaps += 
				("prefix_id" : getPrefixId(cloneId),
				"id" :  cloneId,
				"attributes": (
					"LOC" : linesCount, 
					"startLine" : sourceLoc.begin.line,
					"endLine" : sourceLoc.end.line,
					"clone" : getNodeSource(clone),
					"file": sourceLoc.file
					)
				);
		}
	}
	return jsonMaps;
}

/**
 * Creates the links between all paths and sources
 */
public list[map [str, value]] createCloneSourcesJsonMap() {
	list[map[str, value]] jsonMaps = [];
	for(<path, source> <- sources) {
		jsonMaps += ("path" : path, "source" : source);
	}
	return jsonMaps;
}

/**
 * Creates a relation between a pair of clones
 */
public list[map [str, value]] createCloneRelationsJsonMap() {
	list[map[str, value]] jsonMaps = [];
	for(clones <- range(cloneMap)) {
		for(<a, b> <- pairClones(clones)){
			jsonMaps += ("source" : a, "target" : b);
		}
	}
	return jsonMaps;
}

/**
 * Returns all possible clone combinations
 * Answer borrowed from post below and rewritten in Rascal
 * https://stackoverflow.com/questions/5360220/how-to-split-a-list-into-pairs-in-all-possible-ways
 */
public lrel[int fst, int snd] pairClones(list[int] clones) {
	return [<clones[i], clones[j]> | i <- [0..size(clones)], j <- [(i+1)..size(clones)]];
}
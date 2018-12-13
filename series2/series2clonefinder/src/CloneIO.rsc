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

/**
 * Changelog
 * 
 * a: renamed "id" to "prefix_id"
 * 
 * b: added id to private rel[str id, str path, str source] sources = {}; // niet nodig meer? check ff// YES! otherwise lots of duplicates== large json
 * 
 * c: renamed writeclones : "cloneClasses" : cloneClassesJsonMap.jsonMaps, -> "nodes" : cloneClassesJsonMap.jsonMaps,
 *
 * d: added children to "nodes"
 *
 * e: "renamed createCloneClassJsonMap: "clones" : createCloneJsonMap(clones, projectLoc, linesCount)); -> "children" : createCloneJsonMap(clones, projectLoc, linesCount));
 *
 * f: changed createCloneJsonMap to hold data in a attributes leaf (id -> attributes)
 */

private int idCounter = 0;
private int cloneType = -1;
private loc project;

// vars for clone relations
private int cloneId = 0;
private map[int, list[int]] cloneMap = ();
private rel[str path, str source] sources = {};
private map[node n, int key] nodeKeyMap = ();

private int createCloneId() {
	cloneId += 1;
	return cloneId;
}

/**
 * if we need to iterate multiple times over the nodes
 */
private int getKey(node n){
	if (n notin nodeKeyMap) {
		id = createCloneId();
		nodeKeyMap[n] = id;
		return id;
	} else {
		//println("key match!");
		return nodeKeyMap[n];
	}
}

private str getPrefixId(int id) {
	return "T<cloneType>-<id>";
}

public void writeClones(map[node, set[node]] cloneClasses, int writeType, loc projectLoc) {
	// vars dont reset while console active
	idCounter = 0;
	cloneId = 0;
	sources = {};
	cloneMap = ();
	cloneDir = ();
	nodeKeyMap = ();
	
	sources = {};
	cloneType = writeType;
	project = projectLoc;
	tuple[list[map[str, value]] jsonMaps, int duplicateLoc] cloneClassesJsonMap = createCloneClassJsonMap(cloneClasses, getTotalProjectLoc());
	tuple[list[map[str, value]] jsonMaps, int duplicateLoc] cloneDirsJsonMap = createCloneDirJsonMap(cloneClasses, getTotalProjectLoc());
	writeJSON(|project://series2/src/output/| + "<writeType>_clones.json", 
		("duplicatesPercentage" : locPercentage(cloneClassesJsonMap.duplicateLoc, getTotalProjectLoc()), 
		"duplicatesLOC" : cloneClassesJsonMap.duplicateLoc, 
		"totalLOC" : getTotalProjectLoc(),
		"cloneClasses" : cloneClassesJsonMap.jsonMaps,
		"nodes" : ("children" : cloneDirsJsonMap.jsonMaps),
		//"nodes" : ("children" : cloneClassesJsonMap.jsonMaps),
		"fullSources" : createCloneSourcesJsonMap(),
		"relations": createCloneRelationsJsonMap()));
}

/**
 *
 */
public tuple[list[map[str, value]] jsonMaps, int duplicateLoc] createCloneClassJsonMap(map[node, set[node]] cloneClasses, int projectLoc) {
	list[map[str, value]] jsonMaps = [];
	totalDuplicationLoc = 0;
	for(<_ ,clones> <- toList(cloneClasses)) {
		curClone = createCloneId();
		linesCount = getCloneClassLoc(clones);
		totalDuplicationLoc += linesCount;
		currentId = createCloneId();
		jsonMaps += ("prefix_id" : getPrefixId(currentId),
					"id" : currentId,
					"LOC" : linesCount, 
					"percentageOfProject" : locPercentage(linesCount, projectLoc), 
					//"clones" : createCloneJsonMap(clones, projectLoc, linesCount));
					"children" : createCloneJsonMap(clones, projectLoc, linesCount, curClone));
		
	}
	return <jsonMaps, totalDuplicationLoc>;
}

/**
 *
 */
public list[map[str, value]] createCloneJsonMap(set[node] clones, int projectLoc, int classLoc, int curClone) {
	list[map[str, value]] jsonMaps = [];
	// niet nodig me dunkt?
	if(!cloneMap[curClone]?) cloneMap[curClone] = [];
	
	for(clone <- clones){
		sourceLoc = nodeSourceLoc(clone);
		if(!isEmptyLocation(sourceLoc)) {
			linesCount = getCloneLoc(clone);	
			//currentId = createCloneId();
			currentId = getKey(clone);
			cloneMap[curClone] += currentId;
			sources += <sourceLoc.path, resourceContent(project + sourceLoc.path)>;
		jsonMaps += ("prefix_id" : getPrefixId(currentId),
					"id" :  currentId,
					// moved most to attributes field
					"attributes": (
					"LOC" : linesCount, 
					"percentageOfProject" : locPercentage(linesCount, projectLoc), 
					"percentageOfClass" : locPercentage(linesCount, classLoc), 
					"startLine" : sourceLoc.begin.line,
					"endLine" : sourceLoc.end.line,
					"clone" : getNodeSource(clone),
					"path": sourceLoc.path,
					"file": sourceLoc.file));
		}
	}
	return jsonMaps;
}

/**
 *
 */
public tuple[list[map[str, value]] jsonMaps, int duplicateLoc] createCloneDirJsonMap(map[node, set[node]] cloneClasses, int projectLoc) {
	list[map[str, value]] jsonMaps = [];
	totalDuplicationLoc = 0;
	dupfiles = {};
	for(<_ ,clones> <- toList(cloneClasses)) {
		for(clone <- clones){
			sourcePath = (nodeSourceLoc(clone)).path;
			dupfiles += sourcePath;
		}
	}
	for(filePath <- dupfiles) {
		println("file is <filePath>");
		for(<_ ,clones> <- toList(cloneClasses)) {
			curClone = createCloneId();
			linesCount = getCloneClassLoc(clones);
			totalDuplicationLoc += linesCount;
			currentId = createCloneId();
			//currentId = getKey(clones);
			jsonMaps += ("prefix_id" : getPrefixId(currentId),
						"label": filePath,
						"path" : filePath,
						"id" : currentId,
						"LOC" : linesCount, 
						"percentageOfProject" : locPercentage(linesCount, projectLoc), 
						"children" : testJsonMap(clones, projectLoc, linesCount, curClone, filePath));
							
		}
	}

	return <jsonMaps, totalDuplicationLoc>;
}

/**
 *
 */
public list[map[str, value]] testJsonMap(set[node] clones, int projectLoc, int classLoc, int curClone, str filePath) {
	list[map[str, value]] jsonMaps = [];

	for(clone <- clones){
		sourceLoc = nodeSourceLoc(clone);
		if(!isEmptyLocation(sourceLoc) && (filePath == sourceLoc.path)) {
			linesCount = getCloneLoc(clone);	
			currentId = getKey(clone);
			sources += <sourceLoc.path, resourceContent(project + sourceLoc.path)>;
		jsonMaps += ("prefix_id" : getPrefixId(currentId),
					"id" :  currentId,
					"attributes": (
					"LOC" : linesCount, 
					"percentageOfProject" : locPercentage(linesCount, projectLoc), 
					"percentageOfClass" : locPercentage(linesCount, classLoc), 
					"startLine" : sourceLoc.begin.line,
					"endLine" : sourceLoc.end.line,
					"clone" : getNodeSource(clone),
					"path": sourceLoc.path,
					"file": sourceLoc.file));
		}
	}
	return jsonMaps;
}

/**
 * 
 */
public list[map [str, value]] createCloneSourcesJsonMap() {
	list[map[str, value]] jsonMaps = [];
	for(<path, source> <- sources) {
		//jsonMaps += ("id" : id, "source" : source);
		jsonMaps += ("path" : path, "source" : source);
	}
	return jsonMaps;
}

/**
 * maakt relaties tussen clone ids [x1, x2, .., xn]
 */
public list[map [str, value]] createCloneRelationsJsonMap() {
	list[map[str, value]] jsonMaps = [];
	println("clonemap <cloneMap>");
	for(clones <- range(cloneMap)) {
		println("clones <clones>");
		for(<a, b> <- pairClones(clones)){
			println("wtf <a>,<b>");
			jsonMaps += ("source" : a, "target" : b);
		}
	}
	return jsonMaps;
}

// Answer borrowed from post below and rewritten in Rascal
// https://stackoverflow.com/questions/5360220/how-to-split-a-list-into-pairs-in-all-possible-ways
public lrel[int fst, int snd] pairClones(list[int] clones) {
	return [<clones[i], clones[j]> | i <- [0..size(clones)], j <- [(i+1)..size(clones)]];
}
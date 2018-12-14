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

/**
 * TODO:
 * - Check valeus wanted/needed from the clone attributes,
 * some not needed and/or are wrong due to restructering to dir level format.
 * 
 * - Check if json output formatting can be merged (first check above).
 *
 * - cloneclasses hebben geen info over files met zero clones.
 * Deze gooien we er nu maar zelf weer in.
 * Ziet er lelijk uit qua json maar werkt. 
 * Misschien iets beters verzinnen, anders die troep wat netter formatten.
 * 
 * Changelog Current:
 * a: changed key system, nodes are mapped to a keymap.
 * a: first create id, dan use.
 * a: prefix values are parsed by supplied int. 
 *
 * b: changed grouping of duplicates in "nodes": field of json.
 * b: Duplicates are now grouped by file location.
 * b: basic example:
 * "nodes": {
 *    "children": [
 *        {
 *            "path": "/src/test/sloctest2.java",
 *            "id": 7,
 *            "children": [
 *                {
 *                    "attributes": {
 *                        "clone": "int a = 4;"
 *                    },
 *                    "id": 5
 *                }
 *            ],
 *        },
 *        {
 *            "label": "/src/test/sloctest.java",
 *            "id": 9,
 *            "children": [
 *                {
 *                    "attributes": {
 *                        "clone": "int a = 4;"
 *                    },
 *                    "id": 3
 *                },
 *                {
 *                    "attributes": {
 *                        "clone": "int a = 4;"
 *                    },
 *                    "id": 4
 *                }
 *            ],
 *        }
 *    ]
 * 
 * c: add files with no duplicates into json object.
 * c: these are stored in "nodes" for visualstuff
 * 
 * Changelog Old:
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
private map[int, list[int]] cloneMap = ();
private rel[str path, str source] sources = {};
private map[node n, int key] nodeKeyMap = ();

/**
 *
 */
private int createCloneId() {
	idCounter += 1;
	return idCounter;
}

/**
 * if we need to iterate multiple times over the nodes
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
 *
 */
private str getPrefixId(int id) {
	return "T<cloneType>-<id>";
}

/**
 *
 */
public void writeClones(map[node, set[node]] cloneClasses, int writeType, loc projectLoc) {
	// vars dont reset while console active
	idCounter = 0;
	sources = {};
	cloneMap = ();
	nodeKeyMap = ();
	//
	project = projectLoc;
	cloneType = writeType;
	//
	
	//sources = {};
	//cloneType = writeType;
	//project = projectLoc;
	tuple[list[map[str, value]] jsonMaps, int duplicateLoc] cloneClassesJsonMap = createCloneClassJsonMap(cloneClasses, getTotalProjectLoc());
	tuple[list[map[str, value]] jsonMaps, int duplicateLoc] cloneDirsJsonMap = convertCloneByDirJsonMap(cloneClasses, getTotalProjectLoc(), projectLoc);
	writeJSON(|project://series2/src/output/| + "<writeType>_clones.json", 
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
 *
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
 * Formats duplicates based on file location.
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
 * 
 */
public list[map[str, value]] createCloneJsonMap(set[node] clones, int projectLoc, int classLoc, int curClone) {
	list[map[str, value]] jsonMaps = [];
	// 
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
 * Ugly fix!, d3 animation cannot handle empty childen nodes ([]), 
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
 * Check iff createCloneJsonMap and createCloneDirJsonMap should be separate/different, currently only different
 * by (dupFile == sourceLoc.path) check in if(!isEmptyLocation(sourceLoc) && (dupFile == sourceLoc.path)) {.
 * dunno how json "cloneClasses" is used atm.
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
					//"percentageOfProject" : locPercentage(linesCount, projectLoc), 
					//"percentageOfClass" : locPercentage(linesCount, classLoc), 
					"startLine" : sourceLoc.begin.line,
					"endLine" : sourceLoc.end.line,
					"clone" : getNodeSource(clone),
					//"path": sourceLoc.path,
					"file": sourceLoc.file
					)
				);
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
		jsonMaps += ("path" : path, "source" : source);
	}
	return jsonMaps;
}

/**
 * maakt relaties tussen clone ids [x1, x2, .., xn]
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

// Answer borrowed from post below and rewritten in Rascal
// https://stackoverflow.com/questions/5360220/how-to-split-a-list-into-pairs-in-all-possible-ways
public lrel[int fst, int snd] pairClones(list[int] clones) {
	return [<clones[i], clones[j]> | i <- [0..size(clones)], j <- [(i+1)..size(clones)]];
}
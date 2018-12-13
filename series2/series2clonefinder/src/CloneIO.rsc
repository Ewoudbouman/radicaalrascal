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
private int bsCounter = 0;
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
	nodeKeyMap = ();
	
	bsCounter = 0;
	
	sources = {};
	cloneType = writeType;
	project = projectLoc;
	tuple[list[map[str, value]] jsonMaps, int duplicateLoc] cloneClassesJsonMap = createCloneClassJsonMap(cloneClasses, getTotalProjectLoc());
	tuple[list[map[str, value]] jsonMaps, int duplicateLoc] cloneDirsJsonMap = createCloneByDirJsonMap(cloneClasses, getTotalProjectLoc(), projectLoc);
	writeJSON(|project://series2/src/output/| + "<writeType>_clones.json", 
		("duplicatesPercentage" : locPercentage(cloneClassesJsonMap.duplicateLoc, getTotalProjectLoc()),
		"label" : projectLoc, 
		"duplicatesLOC" : cloneClassesJsonMap.duplicateLoc, 
		"totalLOC" : getTotalProjectLoc(),
		"cloneClasses" : cloneClassesJsonMap.jsonMaps,
		"nodes" : ("children" : cloneDirsJsonMap.jsonMaps),
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
					"children" : createCloneJsonMap(clones, projectLoc, linesCount, curClone));
		
	}
	return <jsonMaps, totalDuplicationLoc>;
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
public tuple[list[map[str, value]] jsonMaps, int duplicateLoc] createCloneByDirJsonMap(map[node, set[node]] cloneClasses, int projectLoc, loc resource) {
	list[map[str, value]] jsonMaps = [];
	totalDuplicationLoc = 0;
	dupfiles = {};
	for(<_ ,clones> <- toList(cloneClasses)) {
		for(clone <- clones){
			dupfiles += ((nodeSourceLoc(clone)).path);
		}
	}
	for(filePath <- dupfiles) {
		for(<_ ,clones> <- toList(cloneClasses)) {
			if(checkEmptyLeafs(clones, filePath)) {
				curClone = createCloneId();
				linesCount = getCloneClassLoc(clones);
				totalDuplicationLoc += linesCount;
				currentId = createCloneId();
				jsonMaps += ("prefix_id" : getPrefixId(currentId),
							"label": filePath,
							"path" : filePath,
							"id" : currentId,
							"LOC" : linesCount, 
							//percentageOfProject" : locPercentage(linesCount, projectLoc), 
							"children" : createCloneDirJsonMap(clones, projectLoc, linesCount, curClone, filePath));
				}							
		}
	}
	//check files

	// add files with zero clones!
	// 
	allFiles = filesInProject(resource);
	for(file <- allFiles) {
		if(file notin dupfiles) {
			currentId = createCloneId();
			jsonMaps += ("prefix_id" : getPrefixId(currentId),
						"label": file,
						"path" : file,
						"id" : currentId,
						"LOC" : (0), 
						"percentageOfProject" : 0, 
						"children" : [
							("prefix_id" : getPrefixId(currentId),
							"id" :  currentId,
							"attributes": (
							"LOC" : 0,
							"percentageOfProject" : 0, 
							"percentageOfClass" : 0, 
							"startLine" : 0,
							"endLine" : 0,
							"clone" : 0,
							"path": "",
							"file": ""))
						]);
			
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
			currentId = getKey(clone);
			cloneMap[curClone] += currentId;
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
 * Ugly fix!, animation cannot handle empty nodes, 
 */
 
public bool checkEmptyLeafs (set[node] clones, str filePath) {
	for(clone <- clones){
		sourceLoc = nodeSourceLoc(clone);
		if(!isEmptyLocation(sourceLoc) && (filePath == sourceLoc.path)) {
			return true;
		}
	}
	return false;
}

/**
 * Check iff createCloneJsonMap and createCloneDirJsonMap should be separate/different, currently only different
 * by (filePath == sourceLoc.path) check in if(!isEmptyLocation(sourceLoc) && (filePath == sourceLoc.path)) {.
 * dunno how json "cloneClasses" is used atm.
 */
public list[map[str, value]] createCloneDirJsonMap(set[node] clones, int projectLoc, int classLoc, int curClone, str filePath) {
	list[map[str, value]] jsonMaps = [];

	//println("IS EMPTY: <isEmpty(clones)>");
	//for(clone <- clones){
	//	println("wtffffffffffff");
	//	println(clone);
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
						//"percentageOfProject" : locPercentage(linesCount, projectLoc), 
						//"percentageOfClass" : locPercentage(linesCount, classLoc), 
						"startLine" : sourceLoc.begin.line,
						"endLine" : sourceLoc.end.line,
						"clone" : getNodeSource(clone),
						//"path": sourceLoc.path,
						"file": sourceLoc.file));
		} //else {
		//	println("wat is deze empty = <!isEmptyLocation(sourceLoc)>, equal = <filePath == sourceLoc.path> ");
		//}
	}
	//if (jsonMaps == []) {
	//	bsCounter += 1;
	//	jsonMaps = [("id": bsCounter)];
	//}
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
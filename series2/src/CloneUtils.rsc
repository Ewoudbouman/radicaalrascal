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

/**
 * Normalize the AST tokens to remove subtle differences.
 * Clone types 2/3
 * check from:
 * https://github.com/usethesource/rascal/blob/master/src/org/rascalmpl/library/lang/java/m3/AST.rsc
 *
 * TODO: fix checks
*/
public set[Declaration] normalizeAst(set[Declaration] x) {
	
	return visit(x) {
		//
		// data Declaration
		//
		case \enumConstant(_, arguments, class)  => \enumConstant("ec", arguments, class)
		case \enumConstant(_, arguments)  => \enumConstant("ec", arguments)
		case \class(_ , extends, implements, body)  => \class("c", extends, implements, body)
		case \interface(_, extends, implements, body)  => \interface("interface", extends, implements, body)
		case \method(TYPEDING, _, parameters, exceptions, impl) => \method(wildcard(), "m", parameters, exceptions, impl)
		//
		// Check: The called signature: method(loc, str, TypeSymbol, list[TypeSymbol]),
		//case meth4: \method(TYPEDING, _ , parameters, exceptions)  => \method(wildcard(), "m" , parameters, exceptions)
		case \constructor(name, parameters, exceptions, impl)  => \constructor("c", parameters, exceptions, impl)
		case \typeParameter(name, extendsList)  => \typeParameter("tp", extendsList)
		case \annotationType(_, body)  => \annotationType("at", body)
		case \annotationTypeMember(TYPEDING, _)  => \annotationTypeMember(wildcard(), "atm")
		case \annotationTypeMember(TYPEDING, _, defaultBlock)  => \annotationTypeMember(wildcard(), "atm", defaultBlock)
		case \parameter(TYPEDING, _, extraDimensions)  => \parameter(wildcard(), "param", extraDimensions)
		case \vararg(TYPEDING, _)  => \vararg(wildcard(), "vararg")
		//
		// data Expression 
		//
		case \characterLiteral(_) => \characterLiteral("clit")
		case \fieldAccess(isSuper, expression, _) => \fieldAccess(isSuper, expression, "fac")
		case \methodCall(isSuper, _,  arguments) => \methodCall(isSuper, "mc" ,  arguments)
		case \methodCall(isSuper, receiver, _,  arguments) => \methodCall(isSuper, receiver,"mc",  arguments)
		// Check: IF RIGHT? less clones not more
		//case \number(_) => \number("1")
		case \booleanLiteral(_) => \booleanLiteral(true)
		case \stringLiteral(_) => \stringLiteral("fransie")
		case \type(_) => \type(wildcard())
		case \variable(_, extraDimensions) => \variable("vardec", extraDimensions) 
		case \variable(_, extraDimensions, \initializer) => \variable("vardec", extraDimensions, \initializer)
		// Check: debug this
		//case \simpleName(_) => \simpleName("MOEILIJK")
		case \markerAnnotation(_) => \markerAnnotation("markerAnnotation")
		case \normalAnnotation(_,  memberValuePairs) => \normalAnnotation("normalAnnotation",  memberValuePairs)
		case \memberValuePair(_, \value) => \memberValuePair("membervp", \value)            
		case \singleMemberAnnotation(_, \value) => \singleMemberAnnotation("singlema", \value)
		//
		// data Statement 
		//		
		case \break(_) => \break("brexit")
		case \continue(_) => \continue("continue")
		case \label(_, body) => \label("labelname", body)
		// data Modifier
		// check modifier?
		
	}
}
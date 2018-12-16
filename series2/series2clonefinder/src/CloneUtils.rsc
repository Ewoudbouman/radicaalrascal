module CloneUtils

import IO;
import lang::java::m3::Core;
import lang::java::jdt::m3::AST;
import lang::java::jdt::m3::Core;
//import lang::java::m3::TypeSymbol;
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
 * https://github.com/usethesource/rascal/blob/master/src/org/rascalmpl/library/lang/java/m3/AST.rsc
 *
 * Normalizes all the names of variables, types, literals and functions
 *
 * TODO: 
 * check data Modifier
 * find resources of what to dooo
*/

public node normalizeValues(node x) {
	
	return visit(x) {
		//
		// data Declaration
		//
		case \enumConstant(_, a, b) => \enumConstant("ec", a, b)
		case \enumConstant(_, a) => \enumConstant("ec", a)
		case \class(_, a, b, c)  => \class("c", a, b, c)
		case \interface(_, a, b, c) => \interface("interface", a, b, c)
		case \method(x, _, a, b, c) => \method(wildcard(), "method", a, b, c)
		case \method(x, _, a, b) => \method(wildcard(), "method", a, b)
		case \constructor(_, a, b, c) => \constructor("c", a, b, c)
		case \typeParameter(_, list[Type] extendsList) => \typeParameter("tp", extendsList)
		case \annotationType(_, a) => \annotationType("at", a)
		case \annotationTypeMember(Type \type, _) => \annotationTypeMember(wildcard(), "atm")
		case \annotationTypeMember(Type \type, _, a) => \annotationTypeMember(wildcard(), "atm", a)
		case \parameter(Type \type, _, a) => \parameter(wildcard(), "param", a)
		case \vararg(Type \type, _) => \vararg(wildcard(), "vararg")
		//
		// data Expression 
		//
		case \characterLiteral(_) => 
			\characterLiteral("clit")
		case \fieldAccess(bool isSuper, Expression expression, _) => 
			\fieldAccess(isSuper, expression, "fac")
		case \fieldAccess(bool isSuper, _) => 
			\fieldAccess(isSuper, "fac")
		case \methodCall(bool isSuper, _, list[Expression] arguments) => 
			\methodCall(isSuper, "mc" ,  arguments)
		case \methodCall(bool isSuper, Expression receiver, _, list[Expression] arguments) => 
			\methodCall(isSuper, receiver, "mc",  arguments)
		case \number(_) =>
			\number("caseNumber")
		//case \number(str a) : println("case number <a>");
		case \booleanLiteral(_) => 
			\booleanLiteral(true)
		case \stringLiteral(_) => 
			\stringLiteral("fransie")
		case \type(_) => 
			\type(wildcard())
		case \variable(_, a) => variable("variable", a)
		case \variable(_, a, b) => variable("variable", a, b)
		// Check: debug this
		//case \simpleName(_) => 
		//	\simpleName("MOEILIJK")
		case \markerAnnotation(_) => 
			\markerAnnotation("markerAnnotation")
		case \normalAnnotation(_,  memberValuePairs) => 
			\normalAnnotation("normalAnnotation",  memberValuePairs)
		case \memberValuePair(_, Expression \value) => 
			\memberValuePair("membervp", \value)            
		case \singleMemberAnnotation(_, Expression \value) => 
			\singleMemberAnnotation("singlema", \value)
		//
		// data Statement 
		//		
		case \break(_) => 
			\break("brexit")
		case \continue(_) => 
			\continue("continue")
		case \label(_, Statement body) => 
			\label("labelname", body)
		// data Modifier
		//
		// weet niet wat deze hiero doen :')
		//
		//case \arrayType(Type \type) => \wildcard()
		//case \parameterizedType(Type \type) => \wildcard()
		//case \qualifiedType(Type qualifier, Expression simpleName) => \wildcard()
		//case \simpleType(Expression typeName) => \wildcard()
		case \simpleName(_) => simpleName("simpleName")
		//case \unionType(list[Type] types) => \wildcard()
		//case \wildcard() => \wildcard()
		//case \upperbound(Type \type) => \wildcard()
		//case \lowerbound(Type \type) => \wildcard()
		//case \TypeSymbol::\int() => \double()
		//case Type toType(\float()) = \float();
		//case \int() => \int() //\double()
		/*
		case \short() => \double()
		case \long() => \double()
		case \float() => \double()
		case \double() => \double()
		case \char() => \double()
		case \string() => \double()
		case \byte() => \double()
		//case \void() => \double()
		case \boolean() => \double()
		*/
	}
}
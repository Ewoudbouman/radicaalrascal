module NodeNormalizer

import IO;
import lang::java::jdt::m3::AST;


/**
 * Normalize the AST tokens to remove subtle differences.
 * Clone types 2/3
 * https://github.com/usethesource/rascal/blob/master/src/org/rascalmpl/library/lang/java/m3/AST.rsc
 *
 *
 * Should be in a seperate module to avoid weird (???) import conflicts
 */
set[Declaration] normalizeValues(set[Declaration] x) {
	
	return visit(x) {
		//
		// data Declaration
		//
		case \enumConstant(_, list[Expression] arguments, Declaration class) => 
			\enumConstant("ec", arguments, class)
		case \enumConstant(_, list[Expression] arguments) => 
			\enumConstant("ec", arguments)
		case \class(_, list[Type] extends, list[Type] implements, list[Declaration] body)  => 
			\class("c", extends, implements, body)
		case \interface(_, list[Type] extends, list[Type] implements, list[Declaration] body) => 
			\interface("interface", extends, implements, body)
		case \method(x, _, y, z, q) => \method(x, "method", y, z, q)
		case \method(x, _, y, z) => \method(x, "method", y, z)
		case \constructor(_, list[Declaration] parameters, list[Expression] exceptions, Statement impl) => 
			\constructor("c", parameters, exceptions, impl)
		case \typeParameter(_, list[Type] extendsList) => 
			\typeParameter("tp", extendsList)
		case \annotationType(_, list[Declaration] body) =>
			\annotationType("at", body)
		case \annotationTypeMember(Type \type, _) => 
			\annotationTypeMember(wildcard(), "atm")
		case \annotationTypeMember(Type \type, _, Expression defaultBlock) => 
			\annotationTypeMember(wildcard(), "atm", defaultBlock)
		case \parameter(Type \type, _, int extraDimensions) => 
			\parameter(wildcard(), "param", extraDimensions)
		case \vararg(Type \type, _) => 
			\vararg(wildcard(), "vararg")
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
			\number("1337")
		case \booleanLiteral(_) => 
			\booleanLiteral(true)
		case \stringLiteral(_) => 
			\stringLiteral("fransie")
		case \type(_) => 
			\type(wildcard())
		case \variable(_, a) => 
			variable("variable", a)
		case \variable(_, a, b) => 
			variable("variable", a, b)
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
		//
		// data Modifier
		//
		case \simpleName(_) => 
			simpleName("simpleName")
    	case \int() => 
    		double()
    	case short() => 
    		double()
    	case long() => 
    		double()
    	case float() => 
    		double()
    	case double() => 
    		double()
    	case char() => 
    		double()
    	case string() => 
    		double()
    	case byte() => 
    		double()
    	case \boolean() => 
    		double()
	}
}
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
 * TODO: check howto handle TYPEDING
*/

public set[Declaration] normalizeAst(set[Declaration] x) {
	return visit(x) {
		//
		// data Declaration
		//
		//case \compilationUnit(list[Declaration] imports, list[Declaration] types)  => \ 
		//case \compilationUnit(Declaration package, list[Declaration] imports, list[Declaration] types)  => \
		//case \enum(str name, list[Type] implements, list[Declaration] constants, list[Declaration] body)  => \
		case ec3: \enumConstant(_, arguments, class)  => \enumConstant("ec", arguments, class)
		case ec2: \enumConstant(_, arguments)  => \enumConstant("ec", arguments)
		case cl4: \class(_ , extends, implements, body)  => \class("c", extends, implements, body)
		//case \class(list[Declaration] body)  => \
		case intf4: \interface(_, extends, implements, body)  => \interface("interface", extends, implements, body)
		//case \field(Type \type, list[Expression] fragments)  => \
		//case \initializer(Statement initializerBody)  => \
		case meth5: \method(TYPEDING, _, parameters, exceptions, impl)  => \method(TYPEDING, "m", parameters, exceptions, impl)
		//
		// CHECk: The called signature: method(loc, str, TypeSymbol, list[TypeSymbol]),
		//
		//case meth4: \method(TYPEDING, _ , parameters, exceptions)  => \method(TYPEDING, "m" , parameters, exceptions)
		case cs4: \constructor(name, parameters, exceptions, impl)  => \constructor("c", parameters, exceptions, impl)
		//case \import(str name)  => \
		//case \package(str name)  => \
		//case \package(Declaration parentPackage, str name)  => \
		//case \variables(Type \type, list[Expression] \fragments)  => \
		case tp2: \typeParameter(name, extendsList)  => \typeParameter("tp", extendsList)
		case at2: \annotationType(_, body)  => \annotationType("at", body)
		case atm2: \annotationTypeMember(TYPEDING, _)  => \annotationTypeMember(TYPEDING, "atm")
		case atm3: \annotationTypeMember(TYPEDING, _, defaultBlock)  => \annotationTypeMember(TYPEDING, "atm", defaultBlock)
		case par3: \parameter(TYPEDING, _, extraDimensions)  => \parameter(TYPEDING, "param", extraDimensions)
		case varg2: \vararg(TYPEDING, _)  => \vararg(TYPEDING, "vararg")
		//
		// data Expression 
		//	
		//case \arrayAccess(array, index) =>
		//case \newArray(Type \type,  dimensions, init) =>
		//case \newArray(Type \type,  dimensions) =>
		//case \arrayInitializer( elements) =>
		//case \assignment(lhs, operator, rhs) =>
		//case \cast(Type \type, expression) =>
		case cl1: \characterLiteral(_) => \characterLiteral("clit")
		//case \newObject(expr, Type \type,  args, Declaration class) =>
		//case \newObject(expr, Type \type,  args) =>
		//case \newObject(Type \type,  args, Declaration class) =>
		//case \newObject(Type \type,  args) =>
		//case \qualifiedName(qualifier, expression) =>
		//case \conditional(expression, thenBranch, elseBranch) =>
		case fa3: \fieldAccess(isSuper, expression, _) => \fieldAccess(isSuper, expression, "fac")
		//case \fieldAccess(isSuper, name) =>
		//case \instanceof(leftSide, Type rightSide) =>
		case mc3: \methodCall(isSuper, _,  arguments) => \methodCall(isSuper, "mc" ,  arguments)
		case mc4: \methodCall(isSuper, receiver, _,  arguments) => \methodCall(isSuper, receiver,"mc",  arguments)
		//case \null() =>
		case nsingle: \number(_) => \number("123")
		case bl1: \booleanLiteral(_) => \booleanLiteral(true)
		case sl1: \stringLiteral(_) => \stringLiteral("fransie")
		case t1: \type(_) => \type(_)
		case v2: \variable(_, extraDimensions) => \variable("vardec", extraDimensions) 
		case v3: \variable(_, extraDimensions, \initializer) => \variable("vardec", extraDimensions, \initializer)
		//case \bracket(expression) =>
		//case \this() =>
		//case \this(thisExpression) =>
		//case \super() =>
		//case \declarationExpression(Declaration decl) =>
		//case \infix(lhs, operator, rhs) =>
		//case \postfix(operand, operator) =>
		//case \prefix(operator, operand) =>
		case sn1: \simpleName(_) => \simpleName("MOEILIJK")
		case ma1: \markerAnnotation(_) => \markerAnnotation("markerAnnotation")
		case na2: \normalAnnotation(_,  memberValuePairs) => \normalAnnotation("normalAnnotation",  memberValuePairs)
		case mvp2: \memberValuePair(_, \value) => \memberValuePair("membervp", \value)            
		case sma2: \singleMemberAnnotation(_, \value) => \singleMemberAnnotation("singlema", \value)
		//
		// data Statement 
		//		
		//case \assert(expression) => 
		//case \assert(expression, message) => 
		//case \block(statements) => 
		//case \break() => 
		case b1: \break(_) => \break("brexit")
		//case \continue() => 
		case con1: \continue(_) => \continue("continue")
		//case \do(body, condition) => 
		//case \empty() => 
		//case \foreach(Declaration parameter, collection, body) => 
		//case \for(initializers, condition, updaters, body) => 
		//case \for(initializers, updaters, body) => 
		//case \if(condition, thenBranch) => 
		//case \if(condition, thenBranch, elseBranch) => 
		case la2: \label(_, body) => \label("labelname", body)
		//case \return(expression) => 
		//case \return() => 
		//case \switch(expression, statements) => 
		//case \case(expression) => 
		//case \default//case() => 
		//case \synchronizedStatement(lock, body) => 
		//case \throw(expression) => 
		//case \try(body, catchClauses) => 
		//case \try(body, catchClauses, \finally) =>                                         
		//case \catch(Declaration exception, body) => 
		//case \declarationStatement(Declaration declaration) => 
		//case \while(condition, body) => 
		//case \expressionStatement(stmt) => 
		//case \constructorCall(isSuper, expr, arguments) => 
		//case \constructorCall(isSuper, arguments) => 
		//
		// data Type 
		//
		// check relevantie
		//
		// data Modifier
		//
		// niet revelant?
	}
}
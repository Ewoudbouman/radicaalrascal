module tests::duplication::types::type2

private int checkSize(loc fst, loc snd) {
	set[Declaration] asts = {};
	asts += createAstFromFile(fst, true);
	asts += createAstFromFile(snd, true);
	
	return size(findClones(asts));
}

private int checkSizeNormalized(loc fst, loc snd) {
	set[Declaration] asts = {};
	asts += createAstFromFile(fst, true);
	asts += createAstFromFile(snd, true);
	
	return size(findClones(normalizeAst(asts)));
}

test bool T2A2A2() {
	return (checkSizeNormalized(t2A, t2A) == 4);
}

test bool T2A2B2() {
	return (checkSizeNormalized(t2A, t2B) == 4);
}

// blablalba
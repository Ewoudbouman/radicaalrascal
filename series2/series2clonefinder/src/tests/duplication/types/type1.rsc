module tests::duplication::types::type1

private int checkSize(loc fst, loc snd) {
	set[Declaration] asts = {};
	asts += createAstFromFile(fst, true);
	asts += createAstFromFile(snd, true);
	
	return size(findClones(asts));
}

test bool T1A1B1() {
	return (checkSize(t1A, t1B) == 4);
}

test bool T1A1C1() {
	return (checkSize(t1A, t1C) == 4);
}

test bool T1B1C1() {
	return (checkSize(t1B, t1C) == 4);
}

test bool T1A1A2() {
	return (checkSize(t1A, t2A) == 1);
}

test bool T1A1B2() {
	return (checkSize(t1A, t2B) == 1);
}

// bla bla
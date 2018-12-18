module tests::RunAllTests

// checks the scenario based cases

extend tests::duplication::types::type1;
extend tests::duplication::types::type2;
extend tests::duplication::types::type3;

// checks some utils

extend tests::utils::TestUtils;

// checks the given project

extend tests::ast::astFunctions;

import { Bundleview, isLeaf, randomLeaf } from './lib/bundleview.js';
import TreeGenerator from './tree-generator/tree-generator.js';

//type1 clones
d3.json("series2/series2clonefinder/src/output/1_clones.json", function(error, root) {    
    if (error) throw error;

    new Bundleview(root, '#type1');
});

//type2 clones
d3.json("series2/series2clonefinder/src/output/2_clones.json", function(error, root) {    
    if (error) throw error;

    new Bundleview(root, '#type2');
});

//type3 clones
d3.json("series2/series2clonefinder/src/output/3_clones.json", function(error, root) {    
    if (error) throw error;

    new Bundleview(root, '#type3');
});

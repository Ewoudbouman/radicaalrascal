import { Bundleview, isLeaf, randomLeaf } from './lib/bundleview.js';
import TreeGenerator from './tree-generator/tree-generator.js';

//d3.json("example/clones.json", function(error, root) {
d3.json("series2/series2clonefinder/src/output/1_clones.json", function(error, root) {    
    if (error) throw error;

    new Bundleview(root, '#clone-view');
});

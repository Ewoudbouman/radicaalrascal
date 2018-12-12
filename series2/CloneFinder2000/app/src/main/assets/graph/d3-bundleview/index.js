import { Bundleview, isLeaf, randomLeaf } from './lib/bundleview.js';
import TreeGenerator from './tree-generator/tree-generator.js';

new Bundleview(JSON.parse(Android.loadData()), '#clone-view');
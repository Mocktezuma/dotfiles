'use strict';

const fs = require('fs');
const path = require('path');
const parser = require('./');

const css = fs.readFileSync(path.resolve(__dirname, './test/fixtures/ayyo.css'), 'utf8');

if (typeof console.profile !== 'function') {
	console.profile = label => console.time(label);
	console.profileEnd = label => console.timeEnd(label);
}

console.profile('Parse CSS');
const model = parser.default(css);
console.profileEnd('Parse CSS');

console.log(model.children.length);
// console.log(model.children.map(node => node.name).join('\n'));

// console.time('CSS Tree');
// const ast = csstree.parse(css);
// console.timeEnd('CSS Tree');

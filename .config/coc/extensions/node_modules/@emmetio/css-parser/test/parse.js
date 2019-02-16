'use strict';

const fs = require('fs');
const path = require('path');
const assert = require('assert');
const StreamReader = require('@emmetio/stream-reader');
require('babel-register');
const parse = require('../index').default;
const interpolation = require('../index').interpolation;

describe('CSS Parser', () => {
	const readFile = file => fs.readFileSync(path.resolve(__dirname, file), 'utf8');

	it('should parse properties', () => {
		const model = parse(readFile('./fixtures/properties.css'));
		let node;

		assert.equal(model.children.length, 5);

		node = model.children[0];
		assert.equal(node.name, '@a');
		assert.equal(node.value, '10');
		assert.equal(node.terminator, ';');

		node = model.children[1];
		assert.equal(node.name, '$bc');
		assert.equal(node.value, 'foo');
		assert.equal(node.terminator, ';');
		assert.equal(node.type, 'property');

		node = model.children[2];
		assert.equal(node.name, '@import');
		assert.equal(node.value, '"url"');
		assert.equal(node.terminator, ';');
		assert.equal(node.type, 'property');

		node = model.children[3];
		assert.equal(node.name, '@import');
		assert.equal(node.value, '"a", "b"');
		assert.equal(node.terminator, ';');
		assert.equal(node.type, 'property');

		node = model.children[4];
		assert.equal(node.name, '@import');
		assert.equal(node.value, 'url("foo bar")');
		assert.equal(node.terminator, undefined);
		assert.equal(node.type, 'property');
	});

	it('should parse sections', () => {
		const model = parse(readFile('./fixtures/sections.css'));
		let node;

		assert.equal(model.children.length, 3);

		node = model.children[0];
		assert.equal(node.type, 'rule');
		assert.equal(node.selector, 'body');
		assert.equal(node.children.length, 2);

		assert.equal(node.children[0].type, 'property');
		assert.equal(node.children[0].name, 'padding');
		assert.equal(node.children[0].value, '10px');

		assert.equal(node.children[1].type, 'rule');
		assert.equal(node.children[1].selector, '&:hover &::before');

		node = model.children[1];
		assert.equal(node.type, 'at-rule');
		assert.equal(node.name, 'media');
		assert.equal(node.expression, 'print');
		// assert.equal(node.expressions[0].type, 'fragments');
		// assert.equal(node.expressions[0].valueOf(), 'print');
		assert.equal(node.children.length, 1);

		assert.equal(node.children[0].type, 'rule');
		assert.equal(node.children[0].selector, 'a[foo="b:a;r"]::before');
		assert.equal(node.children[0].children.length, 1);

		// test complex selector with LESS-style mixins
		node = node.children[0].firstChild;
		assert.equal(node.type, 'rule');
		assert.equal(node.selector, '::slotted(.foo)');
		assert.equal(node.children.length, 3);

		assert.equal(node.children[0].type, 'property');
		assert.equal(node.children[0].name, '.foo.bar');
		assert.equal(node.children[0].value, null);

		assert.equal(node.children[1].type, 'property');
		assert.equal(node.children[1].name, 'a');
		assert.equal(node.children[1].value, 'b');

		assert.equal(node.children[2].type, 'property');
		assert.equal(node.children[2].name, '#baz.bar');
		assert.equal(node.children[2].value, null);

		// test multiline sector
		node = model.children[2];
		assert.equal(node.type, 'rule');
		assert.equal(node.selector, '.foo,\n#bar');
		assert.equal(node.children.length, 1);

		assert.equal(node.children[0].type, 'property');
		assert.equal(node.children[0].name, 'margin');
		assert.equal(node.children[0].value, 'auto');
	});

	it('should handle comments', () => {
		const model = parse(readFile('./fixtures/comments.scss'));
		let node;

		assert.equal(model.children.length, 1);

		node = model.firstChild;
		assert.equal(node.type, 'rule');
		assert.equal(node.selector, 'foo /* a:b; */, bar');
		assert.equal(node.children.length, 1);

		node = node.firstChild;
		assert.equal(node.type, 'rule');
		assert.equal(node.selector, 'a, // c:b {}\n\tb');
		assert.equal(node.children.length, 1);

		node = node.firstChild;
		assert.equal(node.type, 'property');
		assert.equal(node.name, 'padding');
		assert.equal(node.value, '0');
	});

	it('should handle url() token', () => {
		const model = parse(readFile('./fixtures/url.css'));
		assert.equal(model.children.length, 2);

		let node = model.firstChild;
		assert.equal(node.children.length, 2);
		assert.equal(node.children[0].name, 'font-family');
		assert.equal(node.children[0].value, '\'RubArial\'');
		assert.equal(node.children[1].name, 'src');
		assert.equal(node.children[1].value.length, 3132);
	});

	it('should handle interpolation tokens', () => {
		const model = parse(readFile('./fixtures/interpolation.scss'));
		assert.equal(model.children.length, 1);

		let node = model.firstChild;
		// console.log(node);
		assert.equal(node.selector, '.#{$foo + 1}bar');
		assert.equal(node.parsedSelector.length, 1);

		// Interpolation in selector
		const selector = node.parsedSelector[0];
		assert.equal(selector.size, 3);
		assert.equal(selector.item(0).type, 'unknown');
		assert.equal(selector.item(0).valueOf(), '.');
		assert.equal(selector.item(1).type, 'interpolation');
		assert.equal(selector.item(1).valueOf(), '#{$foo + 1}');

		// Interpolation in property
		const prop = node.firstChild;
		assert.equal(prop.name, 'padding-#{$bar}@{@baz}');
		assert.equal(prop.parsedName.size, 3);
		assert.equal(prop.parsedName.item(0).type, 'ident');
		assert.equal(prop.parsedName.item(0).valueOf(), 'padding-');
		assert.equal(prop.parsedName.item(1).type, 'interpolation');
		assert.equal(prop.parsedName.item(1).valueOf(), '#{$bar}');
		assert.equal(prop.parsedName.item(1).item(0).valueOf(), '$bar');
		assert.equal(prop.parsedName.item(2).type, 'interpolation');
		assert.equal(prop.parsedName.item(2).valueOf(), '@{@baz}');
		assert.equal(prop.parsedName.item(2).item(0).valueOf(), '@baz');

		assert.equal(prop.parsedValue.length, 1);
		assert.equal(prop.parsedValue[0].size, 3);
		assert.equal(prop.parsedValue[0].item(0).valueOf(), '10px');
		assert.equal(prop.parsedValue[0].item(2).valueOf(), '#{$baz}');
	});

	it('should detect interpolation in string', () => {
		const stream = new StreamReader('"a: #{$a}, b: #{length($b)}"');
		const result = [];
		let token;

		while (!stream.eof()) {
			if (token = interpolation(stream)) {
				result.push(token);
			} else {
				stream.next();
			}
		}

		assert.equal(result.length, 2);
	});
});

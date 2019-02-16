'use strict';

const fs = require('fs');
const path = require('path');
const assert = require('assert');
require('babel-register');
const parse = require('../index').default;

describe('Property Fragments', () => {
	const parseProperty = prop => parse(prop).firstChild;
	it('should parse simple property', () => {
		const prop = parseProperty('padding: 10px 20% ;');

		assert.equal(prop.name, 'padding');

		assert.equal(prop.value, '10px 20%');
		assert.equal(prop.parsedValue.length, 1);

		const item = prop.parsedValue[0];
		assert.equal(item.type, 'item');
		assert.equal(item.size, 3);

		let sub = item.item(0);
		assert.equal(sub.type, 'number');
		assert.equal(sub.valueOf(), '10px');
		assert.equal(sub.item(0).valueOf(), '10');
		assert.equal(sub.item(1).valueOf(), 'px');

		assert.equal(item.item(1).type, 'whitespace');

		sub = item.item(2);
		assert.equal(sub.type, 'number');
		assert.equal(sub.valueOf(), '20%');
		assert.equal(sub.item(0).valueOf(), '20');
		assert.equal(sub.item(1).valueOf(), '%');
	});

	it('should parse URL', () => {
		const prop = parseProperty('background:url(http://example.com/image.jpg)');

		assert.equal(prop.name, 'background');
		assert.equal(prop.value, 'url(http://example.com/image.jpg)');

		const url = prop.parsedValue[0].item(0);

		assert.equal(url.type, 'url');
		assert.equal(url.valueOf(), 'url(http://example.com/image.jpg)');
		assert.equal(url.item(0).valueOf(), 'http://example.com/image.jpg');
	});

	it('should parse multiple values', () => {
		const prop = parseProperty('foo: rgb(1, 2, 3), 10px 20%, bar(baz())');

		assert.equal(prop.name, 'foo');
		assert.equal(prop.value, 'rgb(1, 2, 3), 10px 20%, bar(baz())');

		assert.equal(prop.parsedValue.length, 3);

		let part = prop.parsedValue[0];
		let item = part.item(0);
		assert.equal(item.type, 'function');
		assert.equal(item.item(0).valueOf(), 'rgb', 'Function name');
		assert.equal(item.item(1).type, 'arguments', 'Function arguments');
		assert.equal(item.item(1).size, 3);
		assert.equal(item.item(1).item(0).valueOf(), '1');
		assert.equal(item.item(1).item(1).valueOf(), '2');
		assert.equal(item.item(1).item(2).valueOf(), '3');

		part = prop.parsedValue[1];
		assert.equal(part.size, 3);

		item = part.item(0);
		assert.equal(item.type, 'number');
		assert.equal(item.item(0).valueOf(), '10');
		assert.equal(item.item(1).valueOf(), 'px');

		item = part.item(2);
		assert.equal(item.type, 'number');
		assert.equal(item.item(0).valueOf(), '20');
		assert.equal(item.item(1).valueOf(), '%');

		part = prop.parsedValue[2];
		item = part.item(0);
		assert.equal(item.type, 'function');
		assert.equal(item.item(0).valueOf(), 'bar');
		assert.equal(item.item(1).size, 1);

		const innerFn = item.item(1).item(0).item(0);
		assert.equal(innerFn.type, 'function');
		assert.equal(innerFn.item(0).valueOf(), 'baz');
		assert.equal(innerFn.valueOf(), 'baz()');
	});
});

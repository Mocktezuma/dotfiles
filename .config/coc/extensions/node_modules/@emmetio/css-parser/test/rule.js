'use strict';

const assert = require('assert');
require('babel-register');
const parse = require('../index').default;

describe('Rule Fragments', () => {
	const parseRule = source => parse(source).firstChild;

	it('should consume single selector', () => {
		const rule = parseRule('  div.class1.class2#id { } ');

		assert.equal(rule.start, 2);
		assert.equal(rule.end, 26);

		assert.equal(rule.selector, 'div.class1.class2#id');
		assert.equal(rule.selectorToken.start, 2);
		assert.equal(rule.selectorToken.end, 22);
		assert.equal(rule.parsedSelector.length, 1);

		const selector = rule.parsedSelector[0];

		assert.equal(selector.valueOf(), 'div.class1.class2#id');
		assert.equal(selector.size, 4);

		let item = selector.item(0);
		assert.equal(item.type, 'ident');
		assert.equal(item.valueOf(), 'div');

		item = selector.item(1);
		assert.equal(item.type, 'class');
		assert.equal(item.valueOf(), '.class1');
		assert.equal(item.item(0).valueOf(), 'class1');

		item = selector.item(2);
		assert.equal(item.type, 'class');
		assert.equal(item.valueOf(), '.class2');
		assert.equal(item.item(0).valueOf(), 'class2');

		item = selector.item(3);
		assert.equal(item.type, 'id');
		assert.equal(item.valueOf(), '#id');
		assert.equal(item.item(0).valueOf(), 'id');
	});

	it('should consume multiple selectors', () => {
		const rule = parseRule('a, [foo="bar,baz"], /* c */ .d { }');
		assert.equal(rule.selector, 'a, [foo="bar,baz"], /* c */ .d');
		assert.equal(rule.parsedSelector.length, 3);

		let selector, item;

		selector = rule.parsedSelector[0];
		assert.equal(selector.valueOf(), 'a');
		assert.equal(selector.size, 1);

		selector = rule.parsedSelector[1];
		assert.equal(selector.valueOf(), '[foo="bar,baz"]');
		assert.equal(selector.size, 1);

		item = selector.item(0);
		assert.equal(item.type, 'attribute');
		assert.equal(item.item(0).valueOf(), 'foo');
		assert.equal(item.item(1).valueOf(), '=');
		assert.equal(item.item(2).valueOf(), '"bar,baz"');
		assert.equal(item.item(2).item(0).valueOf(), 'bar,baz');

		selector = rule.parsedSelector[2];
		assert.equal(selector.valueOf(), '.d');
		assert.equal(selector.size, 1);
	});

	it('should consume arguments', () => {
		const rule = parseRule('@media (min-width: 700px), handheld and (orientation: landscape) {  }');
		let expr, item, arg;

		assert.equal(rule.type, 'at-rule');
		assert.equal(rule.name, 'media');
		assert.equal(rule.parsedExpression.length, 2);

		expr = rule.parsedExpression[0];
		assert.equal(expr.valueOf(), '(min-width: 700px)');

		item = expr.item(0);
		assert.equal(item.type, 'arguments');
		assert.equal(item.size, 1);

		arg = item.item(0);
		assert.equal(arg.type, 'argument');

		assert.equal(arg.item(0).type, 'ident');
		assert.equal(arg.item(0).valueOf(), 'min-width');
		assert.equal(arg.item(1).type, 'separator');
		assert.equal(arg.item(1).valueOf(), ':');
		assert.equal(arg.item(2).type, 'whitespace');
		assert.equal(arg.item(3).type, 'number');
		assert.equal(arg.item(3).valueOf(), '700px');

		expr = rule.parsedExpression[1];
		assert.equal(expr.valueOf(), 'handheld and (orientation: landscape)');
	});

	it('should consume pseudo-selectors', () => {
		const rule = parseRule('a:hover, b::before {  }');

		assert.equal(rule.selector, 'a:hover, b::before');
		assert.equal(rule.parsedSelector.length, 2);

		let sel = rule.parsedSelector[0];
		assert.equal(sel.size, 2);
		assert.equal(sel.item(0).type, 'ident');
		assert.equal(sel.item(0).valueOf(), 'a');
		assert.equal(sel.item(1).type, 'pseudo');
		assert.equal(sel.item(1).valueOf(), ':hover');
		assert.equal(sel.item(1).item(0).valueOf(), 'hover');

		sel = rule.parsedSelector[1];
		assert.equal(sel.size, 2);
		assert.equal(sel.item(0).type, 'ident');
		assert.equal(sel.item(0).valueOf(), 'b');
		assert.equal(sel.item(1).type, 'pseudo');
		assert.equal(sel.item(1).valueOf(), '::before');
		assert.equal(sel.item(1).item(0).valueOf(), 'before');
	});
});

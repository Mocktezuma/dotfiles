'use strict';

import StreamReader from '@emmetio/stream-reader';
import Token from './tokens/token';
import consumeToken from './tokens/index';
import { last, trimFormatting } from './utils';

/**
 * Parses CSS rule selector
 * @param  {String|StreamReader} source
 * @return {Token[]}
 */
export function parseSelector(source) {
	return parseList(source, 'selector');
}

/**
 * Parses CSS property name. Mostly used for LESS where
 * property-like entry might be used as a mixin call
 * @param {String|StreamReader} source
 * @return {Token}
 */
export function parsePropertyName(source) {
	const stream = typeof source === 'string' ? new StreamReader(source) : source;
	const items = [];

	while (!stream.eof()) {
		items.push(consumeToken(stream));
	}

	let token;
	if (items.length === 1) {
		token = items[0];
	} else {
		token = new Token(stream, 'property-name', stream.start, stream.end);
		for (let i = 0, il = items.length; i < il; i++) {
			token.add(items[i]);
		}
	}

	return token;
}

/**
 * Parses CSS property value
 * @param  {String|StreamReader} source
 * @return {Token[]}
 */
export function parsePropertyValue(source) {
	return parseList(source);
}

/**
 * Parses @media CSS rule expression
 * @param  {String|StreamReader} source
 * @return {Token[]}
 */
export function parseMediaExpression(source) {
	return parseList(source);
}

/**
 * Parses given source into a set of tokens, separated by comma. Each token contains
 * parsed sub-items as independent tokens and so on. Mostly used to parse
 * selectors and property values
 * @param  {String|StreamReader} source     Source to parse
 * @param  {String}             [tokenType] Type of first-level tokens.
 *                                          Default is `item`
 * @return {Token[]}
 */
export function parseList(source, tokenType) {
	tokenType = tokenType || 'item';
	const stream = typeof source === 'string' ? new StreamReader(source) : source;
	const items = [];
	const fragments = [];
	const flush = () => {
		const clean = trimFormatting(fragments);

		if (clean.length) {
			const item = new Token(stream, tokenType, clean[0].start, last(clean).end);
			for (let i = 0; i < clean.length; i++) {
				item.add(clean[i]);
			}
			items.push(item);
		}

		fragments.length = 0;
	};

	let token;
	while (!stream.eof()) {
		if (stream.eat(44 /* , */)) {
			flush();
		} else if (token = consumeToken(stream)) {
			if (token.type !== 'comment') {
				fragments.push(token);
			}
		} else {
			throw stream.error('Unexpected character');
		}
	}

	flush();
	return items;
}

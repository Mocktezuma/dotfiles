'use strict';

import Node from './node';
import { last, valueOf } from './utils';
import { parseSelector } from './parse';

/**
 * Creates CSS rule from given tokens
 * @param  {StreamReader} stream
 * @param  {Token[]} tokens
 * @param  {Token} [content]
 * @return {Rule}
 */
export default function createRule(stream, tokens, contentStart, contentEnd) {
	if (!tokens.length) {
		return null;
	}

	const name = tokens[0];
	name.end = last(tokens).end;

	return new Rule(stream, name, contentStart, contentEnd);
}

/**
 * Represents CSS rule
 * @type {Node}
 */
export class Rule extends Node {
	/**
	 * @param {StreamReader} stream
	 * @param {Token} name         Rule’s name token
	 * @param {Token} contentStart Rule’s content start token
	 * @param {Token} [contentEnd] Rule’s content end token
	 */
	constructor(stream, name, contentStart, contentEnd) {
		super('rule');
		this.stream = stream;
		this.selectorToken = name;
		this.contentStartToken = contentStart;
		this.contentEndToken = contentEnd || contentStart;
		this._parsedSelector = null;
	}

	/**
	 * Returns rule selector
	 * @return {String}
	 */
	get selector() {
		return valueOf(this.selectorToken);
	}

	get parsedSelector() {
		if (!this._parsedSelector) {
			this._parsedSelector = parseSelector(this.selectorToken.limit());
		}

		return this._parsedSelector;
	}

	/**
	 * Returns node’s start position in stream
	 * @return {*}
	 */
	get start() {
		return this.selectorToken && this.selectorToken.start;
	}

	/**
	 * Returns node’s end position in stream
	 * @return {*}
	 */
	get end() {
		const token = this.contentEndToken || this.contentStartToken || this.nameToken;
		return token && token.end;
	}
}

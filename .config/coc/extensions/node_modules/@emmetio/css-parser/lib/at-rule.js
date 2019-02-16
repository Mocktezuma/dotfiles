'use strict';

import Node from './node';
import Token from './tokens/token';
import { parseMediaExpression } from './parse';
import { valueOf, last } from './utils';

/**
 * Creates CSS rule from given tokens
 * @param  {StreamReader} stream
 * @param  {Token[]} tokens
 * @param  {Token} [content]
 * @return {Rule}
 */
export default function createAtRule(stream, tokens, contentStart, contentEnd) {
	if (!tokens.length) {
		return null;
	}

	let ix = 0, expression;
	const name = tokens[ix++];
    
	if (ix < tokens.length) {
		expression = tokens[ix++];
		expression.type = 'expression';
		expression.end = last(tokens).end;
	} else {
		expression = new Token(stream, 'expression', name.end, name.end);
	}

	return new AtRule(stream, name, expression, contentStart, contentEnd);
}

export class AtRule extends Node {
	constructor(stream, name, expression, contentStart, contentEnd) {
		super('at-rule');
		this.stream = stream;
		this.nameToken = name;
		this.expressionToken = expression;
		this.contentStartToken = contentStart;
		this.contentEndToken = contentEnd || contentStart;
		this._parsedExpression = null;
	}

	/**
	 * Returns at-rule name
	 * @return {String}
	 */
	get name() {
		return valueOf(this.nameToken && this.nameToken.item(0));
	}

	get expression() {
		return valueOf(this.expressionToken);
	}

	get parsedExpression() {
		if (!this._parsedExpression) {
			this._parsedExpression = parseMediaExpression(this.expressionToken.limit());
		}

		return this._parsedExpression;
	}

	/**
	 * Returns node’s start position in stream
	 * @return {*}
	 */
	get start() {
		return this.nameToken && this.nameToken.start;
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

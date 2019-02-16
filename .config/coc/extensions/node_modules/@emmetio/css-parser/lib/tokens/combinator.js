'use strict';

import Token from './token';
import { consume } from '../utils';

const ADJACENT_SIBLING = 43;  // +
const GENERAL_SIBLING  = 126; // ~
const CHILD            = 62;  // >
const NESTING          = 38;  // &

const types = {
	[ADJACENT_SIBLING]: 'adjacentSibling',
	[GENERAL_SIBLING]: 'generalSibling',
	[CHILD]: 'child',
	[NESTING]: 'nesting'
};

/**
 * Consumes combinator token from given string
 */
export default function(stream) {
	if (isCombinator(stream.peek())) {
		const start = stream.pos;
		const type = types[stream.next()];
		const token = new Token(stream, 'combinator', start);

		token.property('type', type);
		return token;
	}
}

export function eatCombinator(stream) {
	return consume(stream, isCombinator);
}

function isCombinator(code) {
	return code === ADJACENT_SIBLING || code === GENERAL_SIBLING
		|| code === NESTING || code === CHILD;
}

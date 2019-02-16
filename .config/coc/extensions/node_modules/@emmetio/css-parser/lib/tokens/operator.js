'use strict';

import Token from './token';
import { consume } from '../utils';

const NOT          = 33; // !
const MULTIPLY     = 42; // *
const PLUS         = 43; // +
const MINUS        = 45; // -
const DIVIDE       = 47; // /
const LESS_THAN    = 60; // <
const EQUALS       = 61; // =
const GREATER_THAN = 62; // <

export default function operator(stream) {
	return eatOperator(stream) && new Token(stream, 'operator');
}

export function eatOperator(stream) {
	if (consume(stream, isEquality)) {
		stream.eatWhile(EQUALS);
		return true;
	} else if (consume(stream, isOperator)) {
		return true;
	}

	return false;
}

function isEquality(code) {
	return code === NOT || code === LESS_THAN || code === EQUALS || code === GREATER_THAN;
}

function isOperator(code) {
	return code === MULTIPLY || code === PLUS || code === MINUS || code === DIVIDE
		|| isEquality(code);
}

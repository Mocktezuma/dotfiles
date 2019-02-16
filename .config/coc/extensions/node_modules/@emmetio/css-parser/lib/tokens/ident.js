'use strict';

import { isAlpha, isNumber } from '@emmetio/stream-reader-utils';
import Token from './token';

const HYPHEN     = 45;
const UNDERSCORE = 95;

export default function ident(stream) {
	return eatIdent(stream) && new Token(stream, 'ident');
}

export function eatIdent(stream) {
	const start = stream.pos;

	stream.eat(HYPHEN);
	if (stream.eat(isIdentStart)) {
		stream.eatWhile(isIdent);
		stream.start = start;
		return true;
	}

	stream.pos = start;
	return false;
}

export function isIdentStart(code) {
	return code === UNDERSCORE || code === HYPHEN || isAlpha(code) || code >= 128;
}

export function isIdent(code) {
	return isNumber(code) || isIdentStart(code);
}

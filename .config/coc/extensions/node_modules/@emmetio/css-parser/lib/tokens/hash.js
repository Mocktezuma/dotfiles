'use strict';

import { isAlpha, isNumber } from '@emmetio/stream-reader-utils';
import Token from './token';
import prefixed, { eatPrefixed } from './prefixed';
import { consumeWhile } from '../utils';

const HASH = 35;

export default function hash(stream) {
	return prefixed(stream, 'hash', HASH, hashValue, true);
}

export function eatHash(stream) {
	return eatPrefixed(stream, HASH, eatHashValue, true);
}

function hashValue(stream) {
	if (eatHashValue(stream)) {
		return new Token(stream, 'hash-value');
	}
}

function eatHashValue(stream) {
	return consumeWhile(stream, isHashValue);
}

function isHashValue(code) {
	return isNumber(code) || isAlpha(code, 65 /* A */, 70 /* F */)
		|| code === 95 /* _ */ || code === 45 /* - */
		|| code > 128; /* non-ASCII */
}

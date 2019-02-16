'use strict';

import { isQuote, isSpace } from '@emmetio/stream-reader-utils';
import Token from './token';
import { consumeWhile } from '../utils';

/**
 * Consumes unquoted value from given stream
 * @param  {StreamReader} stream
 * @return {UnquotedToken}
 */
export default function(stream) {
	return eatUnquoted(stream) && new Token(stream, 'unquoted');
}

export function eatUnquoted(stream) {
	return consumeWhile(stream, isUnquoted);
}

function isUnquoted(code) {
	return !isNaN(code) && !isQuote(code) && !isSpace(code)
		&& code !== 40 /* ( */ && code !== 41 /* ) */ && code !== 92 /* \ */
		&& !isNonPrintable(code);
}

function isNonPrintable(code) {
	return (code >= 0 && code <= 8) || code === 11
	|| (code >= 14 && code <= 31) || code === 127;
}

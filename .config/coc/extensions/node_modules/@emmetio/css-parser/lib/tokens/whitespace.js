'use strict';

import { isSpace } from '@emmetio/stream-reader-utils';
import Token from './token';
import { consumeWhile } from '../utils';

/**
 * Consumes white-space tokens from given stream
 */
export default function whitespace(stream) {
	return eatWhitespace(stream) && new Token(stream, 'whitespace');
}

export function eatWhitespace(stream) {
	return consumeWhile(stream, isSpace);
}

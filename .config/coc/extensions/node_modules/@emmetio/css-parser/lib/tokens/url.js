'use strict';

import Token from './token';
import string, { eatString } from './string';
import unquoted, { eatUnquoted } from './unquoted';
import { eatWhitespace } from './whitespace';
import { eatString as eatStringPrefix } from '../utils';

/**
 * Consumes URL token from given stream
 * @param  {StreamReader} stream
 * @return {Token}
 */
export default function url(stream) {
	const start = stream.pos;

	if (eatStringPrefix(stream, 'url(')) {
		eatWhitespace(stream);
		const value = string(stream) || unquoted(stream);
		eatWhitespace(stream);
		stream.eat(41); // )

		return new Token(stream, 'url', start).add(value);
	}

	stream.pos = start;
}

export function eatUrl(stream) {
	const start = stream.pos;

	if (eatStringPrefix(stream, 'url(')) {
		eatWhitespace(stream);
		eatString(stream) || eatUnquoted(stream);
		eatWhitespace(stream);
		stream.eat(41); // )
		stream.start = start;

		return true;
	}

	stream.pos = start;
	return false;
}

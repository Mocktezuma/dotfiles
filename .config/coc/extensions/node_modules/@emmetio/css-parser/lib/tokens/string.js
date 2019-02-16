'use strict';

import { isQuote } from '@emmetio/stream-reader-utils';
import Token from './token';
import interpolation from './interpolation';

/**
 * Consumes quoted string from current string and returns token with consumed
 * data or `null`, if string wasn’t consumed
 * @param  {StreamReader} stream
 * @return {StringToken}
 */
export default function string(stream) {
	return eatString(stream, true);
}

export function eatString(stream, asToken) {
	let ch = stream.peek(), pos, tokens, token;

	if (isQuote(ch)) {
		stream.start = stream.pos;
		stream.next();
		const quote = ch;
		const valueStart = stream.pos;

		while (!stream.eof()) {
			pos = stream.pos;
			if (stream.eat(quote) || stream.eat(isNewline)) {
				// found end of string or newline without preceding '\',
				// which is not allowed (don’t throw error, for now)
				break;
			} else if (stream.eat(92 /* \ */)) {
				// backslash allows newline in string
				stream.eat(isNewline);
			} else if (asToken && (token = interpolation(stream))) {
				if (!tokens) {
					tokens = [token];
				} else {
					tokens.push(token);
				}
			}

			stream.next();
		}

		// Either reached EOF or explicitly stopped at string end
		// NB use extra `asToken` param to return boolean instead of token to reduce
		// memory allocations and improve performance
		if (asToken) {
			const token = new Token(stream, 'string');
			const inner = new Token(stream, 'unquoted', valueStart, pos);
			inner.add(tokens);
			token.add(inner);
			token.property('quote', quote);
			return token;
		}

		return true;
	}

	return false;
}

function isNewline(code) {
	return code === 10  /* LF */ || code === 13 /* CR */;
}

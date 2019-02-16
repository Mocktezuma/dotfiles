'use strict';

import Token from './token';
import { RULE_START, RULE_END } from './separator';
import { eatPair } from '@emmetio/stream-reader-utils';
import { eatString } from './string';

const HASH = 35; // #
const AT   = 64; // @

/**
 * Consumes interpolation token, e.g. `#{expression}`
 * @param  {StreamReader} stream
 * @param  {Function} tokenConsumer
 * @return {Token}
 */
export default function interpolation(stream, tokenConsumer) {
	const start = stream.pos;
	tokenConsumer = tokenConsumer || defaultTokenConsumer;

	if ((stream.eat(HASH) || stream.eat(AT)) && stream.eat(RULE_START)) {
		const container = new Token(stream, 'interpolation', start);
		let stack = 1, token;

		while (!stream.eof()) {
			if (stream.eat(RULE_START)) {
				stack++;
			} else if (stream.eat(RULE_END)) {
				stack--;
				if (!stack) {
					container.end = stream.pos;
					return container;
				}
			} else if (token = tokenConsumer(stream)) {
				container.add(token);
			} else {
				break;
			}
		}
	}

	stream.pos = start;
}

export function eatInterpolation(stream) {
	const start = stream.pos;

	if ((stream.eat(HASH) || stream.eat(AT)) && eatPair(stream, RULE_START, RULE_END)) {
		stream.start = start;
		return true;
	}

	stream.pos = start;
	return false;
}

function defaultTokenConsumer(stream) {
	const start = stream.pos;

	while (!stream.eof()) {
		if (stream.peek() === RULE_END) {
			break;
		}

		eatString(stream) || stream.next();
	}

	if (start !== stream.pos) {
		return new Token(stream, 'expression', start);
	}
}

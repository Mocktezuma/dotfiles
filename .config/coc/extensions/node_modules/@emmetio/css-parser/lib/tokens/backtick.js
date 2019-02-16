'use strict';

import Token from './token';
import { eatPair } from '@emmetio/stream-reader-utils';

const BACKTICK = 96; // `

/**
 * Consumes backtick token, e.g. `...`
 * @param  {StreamReader} stream
 * @param  {Function} tokenConsumer
 * @return {Token}
 */
export default function backtick(stream) {
	if (eatBacktick(stream)) {
		return new Token(stream, 'backtick');
	}
}

export function eatBacktick(stream) {
	const start = stream.pos;

	if (eatPair(stream, BACKTICK, BACKTICK)) {
		stream.start = start;
		return true;
	}

	return false;
}

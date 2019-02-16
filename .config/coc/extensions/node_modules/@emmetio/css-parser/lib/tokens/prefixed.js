'use strict';

import Token from './token';

export default function prefixed(stream, tokenType, prefix, body, allowEmptyBody) {
	const start = stream.pos;

	if (stream.eat(prefix)) {
		const bodyToken = body(stream, start);
		if (bodyToken || allowEmptyBody) {
			stream.start = start;
			return new Token(stream, tokenType, start).add(bodyToken);
		}
	}

	stream.pos = start;
}

export function eatPrefixed(stream, prefix, body, allowEmptyBody) {
	const start = stream.pos;

	if (stream.eat(prefix) && (stream.eatWhile(body) || allowEmptyBody)) {
		stream.start = start;
		return true;
	}

	stream.pos = start;
	return false;
}

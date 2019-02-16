'use strict';

import Token from './token';
import { RULE_START, RULE_END } from './separator';
import { last, trimFormatting } from '../utils';

const ARGUMENTS_START = 40;  // (
const ARGUMENTS_END   = 41;  // )

export default function(stream, tokenConsumer) {
	if (stream.peek() === ARGUMENTS_START) {
		const start = stream.pos;
		stream.next();

		const tokens = [];
		let t;
		// in LESS, it’s possible to separate arguments list either by `;` or `,`.
		// In first case, we should keep comma-separated item as a single argument
		let usePropTerminator = false;

		while (!stream.eof()) {
			if (isUnexpectedTerminator(stream.peek()) || stream.eat(ARGUMENTS_END)) {
				break;
			}

			t = tokenConsumer(stream);
			if (!t) {
				break;
			}

			if (isSemicolonSeparator(t)) {
				usePropTerminator = true;
			}

			tokens.push(t);
		}

		stream.start = start;
		return createArgumentList(stream, tokens, usePropTerminator);
	}
}

function isUnexpectedTerminator(code) {
	return code === RULE_START || code === RULE_END;
}

function createArgumentList(stream, tokens, usePropTerminator) {
	const argsToken = new Token(stream, 'arguments');
	const isSeparator = usePropTerminator ? isSemicolonSeparator : isCommaSeparator;
	let arg = [];

	for (let i = 0, il = tokens.length, token; i < il; i++) {
		token = tokens[i];
		if (isSeparator(token)) {
			argsToken.add(createArgument(stream, arg) || createEmptyArgument(stream, token.start));
			arg.length = 0;
		} else {
			arg.push(token);
		}
	}

	if (arg.length) {
		argsToken.add(createArgument(stream, arg));
	}

	return argsToken;
}

function createArgument(stream, tokens) {
	tokens = trimFormatting(tokens);

	if (tokens.length) {
		const arg = new Token(stream, 'argument', tokens[0].start, last(tokens).end);

		for (let i = 0; i < tokens.length; i++) {
			arg.add(tokens[i]);
		}

		return arg;
	}
}

function createEmptyArgument(stream, pos) {
	const token = new Token(stream, 'argument', pos, pos);
	token.property('empty', true);
	return token;
}

function isCommaSeparator(token) {
	return token.property('type') === 'comma';
}

function isSemicolonSeparator(token) {
	return token.property('type') === 'propertyTerminator';
}

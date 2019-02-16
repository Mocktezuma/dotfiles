'use strict';

import { isNumber } from '@emmetio/stream-reader-utils';
import Token from './token';
import { eatIdent } from './ident';
import { consume } from '../utils';

const DOT = 46; // .

/**
 * Consumes number from given string, e.g. `10px`
 * @param  {StreamReader} stream
 * @return {NumberToken}
 */
export default function number(stream) {
	if (eatNumericPart(stream)) {
		const start = stream.start;
		const num = new Token(stream, 'value');
		const unit = eatUnitPart(stream) ? new Token(stream, 'unit') : null;

		return new Token(stream, 'number', start).add(num).add(unit);
	}
}

export function eatNumber(stream) {
	if (eatNumericPart(stream)) {
		const start = stream.start;
		eatUnitPart(stream);
		stream.start = start;

		return true;
	}

	return false;
}

function eatNumericPart(stream) {
	const start = stream.pos;

	stream.eat(isOperator);
	if (stream.eatWhile(isNumber)) {
		stream.start = start;
		const decimalEnd = stream.pos;

		if (!(stream.eat(DOT) && stream.eatWhile(isNumber))) {
			stream.pos = decimalEnd;
		}

		return true;
	} else if (stream.eat(DOT) && stream.eatWhile(isNumber)) {
		stream.start = start;
		return true;
	}

	// TODO eat exponent part

	stream.pos = start;
	return false;
}

function eatUnitPart(stream) {
	return eatIdent(stream) || eatPercent(stream);
}

function eatPercent(stream) {
	return consume(stream, 37 /* % */);
}

function isOperator(code) {
	return code === 45 /* - */ || code === 43 /* + */;
}

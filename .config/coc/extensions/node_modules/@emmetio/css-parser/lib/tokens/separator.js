'use strict';

import Token from './token';
import { consume } from '../utils';

export const COMMA           = 44;  // ,
export const PROP_DELIMITER  = 58;  // :
export const PROP_TERMINATOR = 59;  // ;
export const RULE_START      = 123; // {
export const RULE_END        = 125; // }

const types = new Map()
	.set(COMMA, 'comma')
	.set(PROP_DELIMITER, 'propertyDelimiter')
	.set(PROP_TERMINATOR, 'propertyTerminator')
	.set(RULE_START, 'ruleStart')
	.set(RULE_END, 'ruleEnd');

/**
 * Consumes separator token from given string
 */
export default function separator(stream) {
	if (isSeparator(stream.peek())) {
		const start = stream.pos;
		const type = types.get(stream.next());
		const token = new Token(stream, 'separator', start);

		token.property('type', type);
		return token;
	}
}

export function eatSeparator(stream) {
	return consume(stream, isSeparator);
}

function isSeparator(code) {
	return code === COMMA
		|| code === PROP_DELIMITER || code === PROP_TERMINATOR
		|| code === RULE_START || code === RULE_END;
}

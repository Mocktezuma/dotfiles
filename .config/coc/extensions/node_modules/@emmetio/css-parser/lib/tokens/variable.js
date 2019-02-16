'use strict';

import Token from './token';
import { isIdent } from './ident';
import prefixed, { eatPrefixed } from './prefixed';
import { consumeWhile } from '../utils';

const VARIABLE = 36; // $

/**
 * Consumes SCSS variable from given stream
 */
export default function variable(stream) {
	return prefixed(stream, 'variable', VARIABLE, variableName);
}

export function eatVariable(stream) {
	return eatPrefixed(stream, VARIABLE, eatVariableName);
}

function variableName(stream) {
	if (eatVariableName(stream)) {
		return new Token(stream, 'name');
	}
}

function eatVariableName(stream) {
	return consumeWhile(stream, isVariableName);
}

function isVariableName(code) {
	return code === VARIABLE || isIdent(code);
}

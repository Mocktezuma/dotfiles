'use strict';

import ident, { eatIdent } from './ident';
import prefixed, { eatPrefixed } from './prefixed';

const IMPORTANT = 33; // !

/**
 * Consumes !important token
 * @param  {StreamReader} stream
 * @return {Token}
 */
export default function important(stream) {
	return prefixed(stream, 'important', IMPORTANT, ident);
}

export function eatImportant(stream) {
	return eatPrefixed(stream, IMPORTANT, eatIdent);
}

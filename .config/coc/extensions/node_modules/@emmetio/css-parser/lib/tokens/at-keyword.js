'use strict';

import ident, { eatIdent } from './ident';
import prefixed, { eatPrefixed } from './prefixed';

const AT = 64; // @

/**
 * Consumes at-keyword from given stream
 */
export default function atKeyword(stream) {
	return prefixed(stream, 'at-keyword', AT, ident);
}

export function eatAtKeyword(stream) {
	return eatPrefixed(stream, AT, eatIdent);
}

'use strict';

import ident, { eatIdent } from './ident';
import prefixed, { eatPrefixed } from './prefixed';

const ID = 35; // #

/**
 * Consumes id fragment from given stream, e.g. `#foo`
 * @param  {StreamReader} stream
 * @return {Token}
 */
export default function id(stream) {
	return prefixed(stream, 'id', ID, ident);
}

export function eatId(stream) {
	return eatPrefixed(stream, ID, eatIdent);
}

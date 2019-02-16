'use strict';

import ident, { eatIdent } from './ident';
import prefixed, { eatPrefixed } from './prefixed';

const CLASS = 46; // .

/**
 * Consumes class fragment from given stream, e.g. `.foo`
 * @param  {StreamReader} stream
 * @return {ClassToken}
 */
export default function className(stream) {
	return prefixed(stream, 'class', CLASS, ident);
}

export function eatClassName(stream) {
	return eatPrefixed(stream, CLASS, eatIdent);
}

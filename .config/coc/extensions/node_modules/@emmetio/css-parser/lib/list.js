'use strict';

import StreamReader from '@emmetio/stream-reader';
import Token from './tokens/token';
import consumeToken from './tokens/index';
import { last, trimFormatting } from './utils';

/**
 * Parses given source into a set of tokens, separated by comma. Each token contains
 * parsed sub-items as independent tokens and so on. Mostly used to parse
 * selectors and property values
 * @param  {String|StreamReader} source     Source to parse
 * @param  {String}             [tokenType] Type of first-level tokens.
 *                                          Default is `item`
 * @return {Token[]}
 */
export default function parseList(source, tokenType) {
	tokenType = tokenType || 'item';
	const stream = typeof source === 'string' ? new StreamReader(source) : source;
	const items = [];
	const fragments = [];
	const flush = () => {
		const clean = trimFormatting(fragments);

		if (clean.length) {
			const item = new Token(stream, tokenType, clean[0].start, last(clean).end);
			for (let i = 0; i < clean.length; i++) {
				item.add(clean[i]);
			}
			items.push(item);
		}

		fragments.length = 0;
	};

	let token;
	while (!stream.eof()) {
		if (stream.eat(44 /* , */)) {
			flush();
		} else if (token = consumeToken(stream)) {
			if (token.type !== 'comment') {
				fragments.push(token);
			}
		} else {
			throw stream.error('Unexpected character');
		}
	}

	flush();
	return items;
}

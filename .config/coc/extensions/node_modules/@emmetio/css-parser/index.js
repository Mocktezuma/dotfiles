'use strict';

import StreamReader from '@emmetio/stream-reader';
import Stylesheet from './lib/stylesheet';
import createRule from './lib/rule';
import createAtRule from './lib/at-rule';
import createProperty from './lib/property';
import { parseMediaExpression, parsePropertyName, parsePropertyValue, parseSelector } from './lib/parse';

import consumeToken, { any, selector, value, keyword, formatting } from './lib/tokens/index';
import atKeyword from './lib/tokens/at-keyword';
import Token from './lib/tokens/token';
import ident from './lib/tokens/ident';
import comment from './lib/tokens/comment';
import backtick, { eatBacktick } from './lib/tokens/backtick';
import interpolation, { eatInterpolation } from './lib/tokens/interpolation';
import string, { eatString } from './lib/tokens/string';
import whitespace, { eatWhitespace } from './lib/tokens/whitespace';
import url, { eatUrl } from './lib/tokens/url';
import variable from './lib/tokens/variable';

const LBRACE          = 40;  // (
const RBRACE          = 41;  // )
const PROP_DELIMITER  = 58;  // :
const PROP_TERMINATOR = 59;  // ;
const RULE_START      = 123; // {
const RULE_END        = 125; // }

export default function parseStylesheet(source) {
	const stream = typeof source === 'string' ? new StreamReader(source) : source;
	const root = new Stylesheet();
	let ctx = root, child, accum, token;
	let tokens = [];
	const flush = () => {
		if (accum) {
			tokens.push(accum);
			accum = null;
		}
	};

	while (!stream.eof()) {
		if (eatWhitespace(stream)) {
			continue;
		}

		if (token = comment(stream)) {
			root.addComment(token);
			continue;
		}

		stream.start = stream.pos;

		if (stream.eatWhile(PROP_DELIMITER)) {
			// Property delimiter can be either a real property delimiter or a
			// part of pseudo-selector.
			if (!tokens.length) {
				if (accum) {
					// No consumed tokens yet but pending token: most likely it’s
					// a CSS property
					flush();
				} else {
					// No consumend or accumulated token, seems like a start of
					// pseudo-selector, e.g. `::slotted`
					accum = new Token(stream, 'preparse');
				}
			}
			// Skip delimiter if there are already consumend tokens: most likely
			// it’s a part of pseudo-selector
		} else if (stream.eat(PROP_TERMINATOR)) {
			flush();
			ctx.add(createProperty(stream, tokens, new Token(stream, 'termintator')));
			tokens.length = 0;
		} else if (stream.eat(RULE_START)) {
			flush();
			if (tokens.length > 0) {
				child = tokens[0].type === 'at-keyword'
				? createAtRule(stream, tokens, new Token(stream, 'body-start'))
				: createRule(stream, tokens, new Token(stream, 'body-start'));
				ctx.add(child);
				ctx = child;
				tokens.length = 0;
			}
		} else if (stream.eat(RULE_END)) {
			flush();

			// Finalize context section
			ctx.add(createProperty(stream, tokens));

			if (ctx.type !== 'stylesheet') {
				// In case of invalid stylesheet with redundant `}`,
				// don’t modify root section.
				ctx.contentEndToken = new Token(stream, 'body-end');
				ctx = ctx.parent;
			}

			tokens.length = 0;
		} else if (token = atKeyword(stream)) {
			// Explictly consume @-tokens since it defines how rule or property
			// should be pre-parsed
			flush();
			tokens.push(token);
		} else if (eatUrl(stream) || eatInterpolation(stream) || eatBacktick(stream) 
				|| eatBraces(stream, root) || eatString(stream) || stream.next()) {
			// NB explicitly consume `url()` token since it may contain
			// an unquoted url like `http://example.com` which interferes
			// with single-line comment
			accum = accum || new Token(stream, 'preparse');
			accum.end = stream.pos;
		} else {
			throw new Error(`Unexpected end-of-stream at ${stream.pos}`);
		}
	}

	if (accum) {
		tokens.push(accum);
	}

	// Finalize all the rest properties
	ctx.add(createProperty(stream, tokens));

	// Finalize unterminated rules
	stream.start = stream.pos;
	while (ctx && ctx !== root) {
		ctx.contentEndToken = new Token(stream, 'body-end');
		ctx = ctx.parent;
	}

	return root;
}

/**
 * Parses given source into tokens
 * @param  {String|StreamReader} source
 * @param  {Function} [consumer] Token consumer function, for example, `selector`,
 * `value` etc. from `lib/tokens` module. Default is generic `consumeToken`
 * @return {Token[]}
 */
export function lexer(source, consumer) {
	consumer = consumer || consumeToken;
	const stream = typeof source === 'string' ? new StreamReader(source) : source;
	const result = [];
	let token;

	while (!stream.eof() && (token = consumer(stream))) {
		result.push(token);
	}

	return result;
}

// Export tokens for later re-parsing in preprocessor stylesheets
export {
	// tokens
	Token, any, selector, value, keyword, variable,
	formatting, comment, whitespace, ident, string, url,
	interpolation, backtick,

	// parsers
	parseMediaExpression, parsePropertyName, parsePropertyValue, parseSelector,

	// helpers
	createProperty, createRule, createAtRule
};

/**
 * Consumes content inside round braces. Mostly used to skip `;` token inside
 * expressions since in LESS it is also used to separate function arguments
 * @param  {StringReader} stream
 * @param  {Stylesheet}   root   A stylesheet root. Used to accumulate comments
 * @return {Boolean}
 */
function eatBraces(stream, root) {
	if (stream.eat(LBRACE)) {
		let stack = 1, token;

		while (!stream.eof()) {
			if (stream.eat(RBRACE)) {
				stack--;
				if (!stack) {
					break;
				}
			} else if (stream.eat(LBRACE)) {
				stack++;
			} else if (eatUrl(stream) || eatString(stream)) {
				continue;
			} else if (token = comment(stream)) {
				root.addComment(token);
				continue;
			} else {
				stream.next();
			}
		}

		return true;
	}

	return false;
}

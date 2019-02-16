'use strict';

import args from './arguments';
import atKeyword from './at-keyword';
import attribute from './attribute';
import backtick from './backtick';
import className from './class';
import combinator from './combinator';
import comment from './comment';
import hash from './hash';
import id from './id';
import ident from './ident';
import important from './important';
import interpolation from './interpolation';
import number from './number';
import operator from './operator';
import pseudo from './pseudo';
import separator from './separator';
import string from './string';
import url from './url';
import variable from './variable';
import whitespace from './whitespace';

import Token from './token';

/**
 * Group tokens by commonly used context
 */

export default function consumeToken(stream) {
	const _token = any(stream) || args(stream, consumeToken);
	if (_token && _token.type === 'ident') {
		const _args = args(stream, consumeToken);
		if (_args) {
			// An identifier followed by arguments – function call
			return new Token(stream, 'function', _token.start, _args.end).add(_token).add(_args);
		}
	}

	return _token || unknown(stream);
}

export function any(stream) {
	return formatting(stream) || url(stream) || selector(stream) || value(stream)
		|| separator(stream);
}

export function selector(stream) {
	return interpolation(stream) || backtick(stream) || ident(stream) || atKeyword(stream)
		|| className(stream) || id(stream) || pseudo(stream) || attribute(stream)
		|| combinator(stream);
}

export function value(stream) {
	return url(stream) || string(stream) || interpolation(stream) || backtick(stream) 
		|| number(stream) || hash(stream) || keyword(stream) || important(stream) 
		|| operator(stream);
}

export function keyword(stream) {
	return backtick(stream) || variable(stream) || atKeyword(stream) || ident(stream);
}

export function formatting(stream) {
	return comment(stream) || whitespace(stream);
}

export function unknown(stream) {
	stream.start = stream.pos;
	const ch = stream.next();
	if (ch != null) {
		return new Token(stream, 'unknown');
	}
}

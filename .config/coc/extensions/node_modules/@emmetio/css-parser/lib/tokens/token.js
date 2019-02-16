'use strict';

/**
 * A structure describing text fragment in content stream. It may contain
 * other sub-fragments (also tokens) that represent current fragments’ logical
 * parts
 */
export default class Token {
	/**
	 * @param {StreamReader} stream
	 * @param {String}       type    Token type
	 * @param {Object}       [start] Tokens’ start position in `stream`
	 * @param {Object}       [end]   Tokens’ end position in `stream`
	 */
	constructor(stream, type, start, end) {
		this.stream = stream;
		this.start = start != null ? start : stream.start;
		this.end = end != null ? end : stream.pos;
		this.type = type;

		this._props = null;
		this._value = null;
		this._items = null;
	}

	get size() {
		return this._items ? this._items.length : 0;
	}

	get items() {
		return this._items;
	}

	clone(start, end) {
		return new this.constructor(this.stream, this.type,
			start != null ? start : this.start,
			end != null ? end : this.end);
	}

	add(item) {
		if (Array.isArray(item)) {
			for (let i = 0, il = item.length; i < il; i++) {
				this.add(item[i]);
			}
		} else if (item) {
			if (!this._items) {
				this._items = [item];
			} else {
				this._items.push(item);
			}
		}

		return this;
	}

	remove(item) {
		if (this._items) {
			const ix = this._items.indexOf(item);
			if (ix !== -1 ) {
				this._items.splice(ix, 1);
			}
		}

		return this;
	}

	item(i) {
		const size = this.size;
		return this._items && this._items[(size + i) % size];
	}

	limit() {
		return this.stream.limit(this.start, this.end);
	}

	slice(from, to) {
		const token = this.clone();
		const items = this._items && this._items.slice(from, to);
		if (items && items.length) {
			token.start = items[0].start;
			token.end = items[items.length - 1].end;
			token.add(items);
		} else if (items) {
			// Empty token
			token.start = token.end;
		}

		return token;
	}

	property(name, value) {
		if (typeof value !== 'undefined') {
			// set property value
			if (!this._props) {
				this._props = {};
			}

			this._props[name] = value;
		}

		return this._props && this._props[name];
	}

	/**
	 * Returns token textual representation
	 * @return {String}
	 */
	toString() {
		return `${this.valueOf()} [${this.start}, ${this.end}] (${this.type})`;
	}

	valueOf() {
		if (this._value === null) {
			this._value = this.stream.substring(this.start, this.end);
		}

		return this._value;
	}
}

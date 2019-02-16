'use strict';

import Node from './node';

export default class Stylesheet extends Node {
	constructor() {
		super('stylesheet');
		this.comments = [];
	}

	/**
	 * Returns node’s start position in stream
	 * @return {*}
	 */
	get start() {
		const node = this.firstChild;
		return node && node.start;
	}

	/**
	 * Returns node’s end position in stream
	 * @return {*}
	 */
	get end() {
		const node = this.children[this.children.length - 1];
		return node && node.end;
	}

	/**
	 * Adds comment token into a list.
	 * This somewhat awkward feature is required to properly detect comment
	 * ranges. Specifically, in Atom: it’s API provides scopes limited to current
	 * line only
	 * @param {Token} token
	 */
	addComment(token) {
		this.comments.push(token);
	}
}

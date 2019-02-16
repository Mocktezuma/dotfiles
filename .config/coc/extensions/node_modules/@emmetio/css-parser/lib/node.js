'use strict';

/**
 * Abstract container that contains nested nodes or other containers
 */
export default class Node {
	constructor(type) {
		this.type = type;
		this.children = [];
		this.parent = null;
	}

	get firstChild() {
		return this.children[0];
	}

	get nextSibling() {
		const ix = this.index();
		return ix !== -1 ? this.parent.children[ix + 1] : null;
	}

	get previousSibling() {
		const ix = this.index();
		return ix !== -1 ? this.parent.children[ix - 1] : null;
	}

	/**
	 * Returns current element’s index in parent list of child nodes
	 * @return {Number}
	 */
	index() {
		return this.parent ? this.parent.children.indexOf(this) : -1;
	}

	/**
	 * Adds given node as a child
	 * @param {Node} node
	 * @return {Node} Current node
	 */
	add(node) {
		if (node) {
			node.remove();
			this.children.push(node);
			node.parent = this;
		}
		return this;
	}

	/**
	 * Removes current node from its parent
	 * @return {Node} Current node
	 */
	remove() {
		if (this.parent) {
			const ix = this.index();
			if (ix !== -1) {
				this.parent.children.splice(ix, 1);
				this.parent = null;
			}
		}

		return this;
	}
}

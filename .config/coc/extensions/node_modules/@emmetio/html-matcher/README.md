# Minimalistic and ultra-fast HTML parser & matcher

The goal of this project is to provide minimalistic and fast HTML/XML parser with that holds source mapping of matched tags and its attributes. The project is optimized for finding HTML/XML tag pairs from arbitrary position in source code. Also, it can be used for parsing full document into DOM.

Example:

```js
import { findPair } from '@emmetio/html-matcher';

const content = '<div><a href="http://emmet.io">Example</a></div>';

// find tag pair at character 35
const match = findPair(content, 35);

console.log(m.type); // "tag", may also return "comment"
console.log(m.start); // { cursor: 0, pos: 5 }
console.log(m.end); // { cursor: 0, pos: 42 }

// get open and close parts
console.log(m.open.name.value); // "a"
console.log(m.open.name.start); // { cursor: 0, pos: 6 }
console.log(m.open.name.end); // { cursor: 0, pos: 7 }
```

All token locations are represented as `{cursor, pos}` object where `cursor` is a pointer to a code chunk in content reader and `pos` is a character location in given code chunk (see below).

## Content Reader

HTML Matcher is designed to work inside text editors. Most editors holds source code as a set of code chunks (lines of code in most cases) to optimize its parsing and rendering. Getting a full source code from editor might be very resource-consuming, especially on large files.

To overcome this problem, you may pass *content reader* instead of string as data source. Content reader is an object with the following interface:

```js
const lines = 'foo\nbar\nbaz'.split('\n').map(line => line + '\n');

const contentReader = {
	cursor: 0, // a pointer to a data chunk

	// Returns a code chunk for given cursor
	charCodeAt(cursor, pos) {
		return lines[cursor].charCodeAt(pos);
	}

	// Returns length of code chunk, identified by `cursor`
	length(cursor) {
		return lines[cursor].length;
	}

	substring(from, to) {
		
	}

	// Returns cursor for next code chunk from given cursor
	// or `null` if there’s no next chunk
	next(cursor) {
		cursor++;
		return cursor < lines.length ? cursor : null;
	}

	// Returns cursor for previous code chunk from given cursor
	// or `null` if there’s no previous chunk
	prev(cursor) {
		cursor--;
		return cursor >= 0 ? cursor : null;
	}
}
```

*TBD*

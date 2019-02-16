'use strict';

if (process.platform === 'linux') {
  module.exports = require('ws');
} else {
  // Provided at build time.
  // eslint-disable-next-line import/no-unresolved
  module.exports = require('./uws.js');
}

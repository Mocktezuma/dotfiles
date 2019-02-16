'use strict';

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

// Provides native APIs for RPCIPC transport.
//
// Because we're passing through some native APIs, e.g. net, we recast its API
// to something more browser-safe, so don't assume the APIs are 1:1 or behave
// exactly like the native APIs.

var process = require('process');
var path = require('path');
var fs = require('fs');
var net = require('net');
var EventEmitter = require('events');

var IS_WINDOWS = process.platform === 'win32';

var SOCKET_PATH = void 0;
if (IS_WINDOWS) {
  SOCKET_PATH = '\\\\?\\pipe\\discord-ipc';
} else {
  var temp = process.env.XDG_RUNTIME_DIR || process.env.TMPDIR || process.env.TMP || process.env.TEMP || '/tmp';
  SOCKET_PATH = path.join(temp, 'discord-ipc');
}

// converts Node.js Buffer to ArrayBuffer
function toArrayBuffer(buffer) {
  return buffer.buffer.slice(buffer.byteOffset, buffer.byteOffset + buffer.byteLength);
}

function getAvailableSocket(testSocketPathFn) {
  var tries = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : 0;
  var lastErr = arguments[2];

  if (tries > 9) {
    return Promise.reject(new Error('Max tries exceeded, last error: ' + lastErr));
  }

  var socketPath = SOCKET_PATH + '-' + tries;

  return testSocketPathFn(socketPath).then(function () {
    if (!IS_WINDOWS) {
      try {
        fs.unlinkSync(socketPath);
      } catch (err) {}
    }
    return socketPath;
  }, function (err) {
    return getAvailableSocket(testSocketPathFn, tries + 1, err);
  });
}

function recastNetSocket(socket) {
  var Socket = function (_EventEmitter) {
    _inherits(Socket, _EventEmitter);

    function Socket() {
      _classCallCheck(this, Socket);

      var _this = _possibleConstructorReturn(this, (Socket.__proto__ || Object.getPrototypeOf(Socket)).call(this));

      _this._didHandshake = false;

      socket.on('error', function (err) {
        return _this.emit('error', err);
      });
      socket.on('close', function () {
        return _this.emit('close');
      });
      socket.on('readable', function () {
        return _this.emit('readable');
      });
      return _this;
    }

    _createClass(Socket, [{
      key: 'pause',
      value: function pause() {
        socket.pause();
      }
    }, {
      key: 'destroy',
      value: function destroy() {
        socket.destroy();
      }

      // for data sending, we recast Buffer to ArrayBuffer on the way out
      // and ArrayBuffer to Buffer on the way in

    }, {
      key: 'write',
      value: function write(buffer) {
        socket.write(Buffer.from(buffer));
      }
    }, {
      key: 'end',
      value: function end(buffer) {
        socket.end(Buffer.from(buffer));
      }
    }, {
      key: 'read',
      value: function read(len) {
        var buf = socket.read(len);
        if (!buf) return buf;
        return toArrayBuffer(buf);
      }
    }]);

    return Socket;
  }(EventEmitter);

  return new Socket();
}

function recastNetServer(server) {
  var Server = function (_EventEmitter2) {
    _inherits(Server, _EventEmitter2);

    function Server() {
      _classCallCheck(this, Server);

      var _this2 = _possibleConstructorReturn(this, (Server.__proto__ || Object.getPrototypeOf(Server)).call(this));

      server.on('error', function (err) {
        return _this2.emit('error', err);
      });
      return _this2;
    }

    _createClass(Server, [{
      key: 'address',
      value: function address() {
        return server.address();
      }
    }, {
      key: 'listen',
      value: function listen(socketPath, onListening) {
        server.listen(socketPath, function () {
          onListening();
        });
      }
    }, {
      key: 'listening',
      get: function get() {
        return !!server.listening;
      }
    }]);

    return Server;
  }(EventEmitter);

  return new Server();
}

var proxiedNet = {
  createConnection: function createConnection(socketPath) {
    var socket = net.createConnection(socketPath);
    return recastNetSocket(socket);
  },
  createServer: function createServer(onConnection) {
    var server = net.createServer(function (socket) {
      onConnection(recastNetSocket(socket));
    });
    return recastNetServer(server);
  }
};

module.exports = {
  getAvailableSocket: getAvailableSocket,
  net: proxiedNet
};

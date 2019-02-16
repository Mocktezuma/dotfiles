'use strict';

var _get = function get(object, property, receiver) { if (object === null) object = Function.prototype; var desc = Object.getOwnPropertyDescriptor(object, property); if (desc === undefined) { var parent = Object.getPrototypeOf(object); if (parent === null) { return undefined; } else { return get(parent, property, receiver); } } else if ("value" in desc) { return desc.value; } else { var getter = desc.get; if (getter === undefined) { return undefined; } return getter.call(receiver); } };

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

// Provides native APIs for RPCWebSocket transport.
//
// Because we're passing through some native APIs, e.g. net, we recast its API
// to something more browser-safe, so don't assume the APIs are 1:1 or behave
// exactly like the native APIs.

var EventEmitter = require('events');
var http = require('http');
var ws = require('./ws');
var httpProxy = require('./httpProxy');

var origInstanceMap = new WeakMap();

// converts Node.js Buffer to ArrayBuffer
function toArrayBuffer(buffer) {
  return buffer.buffer.slice(buffer.byteOffset, buffer.byteOffset + buffer.byteLength);
}

function recastHTTPProxy(proxy) {
  function web(_req, _res, opts) {
    // this is coming from web, so we need to get the original
    // instances from the recasts
    var req = origInstanceMap.get(_req);
    var res = origInstanceMap.get(_res);
    proxy.web(req, res, opts);
  }

  return {
    web: web
  };
}

function createProxyServer(opts) {
  var proxy = httpProxy.createProxyServer(opts);
  return recastHTTPProxy(proxy);
}

function recastWSSocket(socket) {
  var WSSocket = function (_EventEmitter) {
    _inherits(WSSocket, _EventEmitter);

    function WSSocket() {
      _classCallCheck(this, WSSocket);

      var _this = _possibleConstructorReturn(this, (WSSocket.__proto__ || Object.getPrototypeOf(WSSocket)).call(this));

      _this.upgradeReq = {
        url: socket.upgradeReq.url,
        headers: {
          origin: socket.upgradeReq.headers.origin
        }
      };

      socket.on('error', function (err) {
        return _this.emit('error', err);
      });
      socket.on('close', function (code, message) {
        return _this.emit('close', code, message);
      });
      socket.on('message', function (data) {
        if (data instanceof Buffer) {
          data = toArrayBuffer(data);
        }
        _this.emit('message', data);
      });
      return _this;
    }

    _createClass(WSSocket, [{
      key: 'send',
      value: function send(data) {
        var opts = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {};

        if (opts.binary) {
          data = Buffer.from(data);
        }
        socket.send(data, opts);
      }
    }, {
      key: 'close',
      value: function close(code, message) {
        socket.close(code, message);
      }
    }]);

    return WSSocket;
  }(EventEmitter);

  return new WSSocket();
}

function getWrappedWSServer() {
  var wss = void 0;

  return function (_EventEmitter2) {
    _inherits(ProxiedWSServer, _EventEmitter2);

    function ProxiedWSServer(opts) {
      _classCallCheck(this, ProxiedWSServer);

      // opts.server that comes in is our remapped server, so we
      // get the original
      var _this2 = _possibleConstructorReturn(this, (ProxiedWSServer.__proto__ || Object.getPrototypeOf(ProxiedWSServer)).call(this));

      if (opts.server) {
        opts.server = origInstanceMap.get(opts.server);
      }

      wss = new ws.Server(opts);
      wss.on('connection', function (socket) {
        return _this2.emit('connection', recastWSSocket(socket));
      });
      return _this2;
    }

    return ProxiedWSServer;
  }(EventEmitter);
}

var proxiedWS = {
  get Server() {
    return getWrappedWSServer();
  }
};

function recastHTTPReq(req) {
  var ProxiedHTTPRequest = function (_EventEmitter3) {
    _inherits(ProxiedHTTPRequest, _EventEmitter3);

    function ProxiedHTTPRequest() {
      var _ref;

      var _temp, _this3, _ret;

      _classCallCheck(this, ProxiedHTTPRequest);

      for (var _len = arguments.length, args = Array(_len), _key = 0; _key < _len; _key++) {
        args[_key] = arguments[_key];
      }

      return _ret = (_temp = (_this3 = _possibleConstructorReturn(this, (_ref = ProxiedHTTPRequest.__proto__ || Object.getPrototypeOf(ProxiedHTTPRequest)).call.apply(_ref, [this].concat(args))), _this3), _this3.attached = false, _temp), _possibleConstructorReturn(_this3, _ret);
    }

    _createClass(ProxiedHTTPRequest, [{
      key: 'on',
      value: function on(evt) {
        var _this4 = this,
            _get2;

        // We need to attach listeners for data only on data event, which sets the
        // request to flowing mode.
        if (evt === 'data' && !this.attached) {
          req.on('error', function (err) {
            return _this4.emit('error', err);
          });
          req.on('end', function () {
            return _this4.emit('end');
          });
          req.on('data', function (data) {
            // force cast the data to a string
            // this is because we only deal with string data on http requests so far
            _this4.emit('data', '' + data);
          });
          this.attached = true;
        }

        for (var _len2 = arguments.length, args = Array(_len2 > 1 ? _len2 - 1 : 0), _key2 = 1; _key2 < _len2; _key2++) {
          args[_key2 - 1] = arguments[_key2];
        }

        (_get2 = _get(ProxiedHTTPRequest.prototype.__proto__ || Object.getPrototypeOf(ProxiedHTTPRequest.prototype), 'on', this)).call.apply(_get2, [this, evt].concat(args));
      }
    }, {
      key: 'url',
      get: function get() {
        return req.url;
      }
    }, {
      key: 'method',
      get: function get() {
        return req.method;
      }
    }, {
      key: 'headers',
      get: function get() {
        return req.headers;
      }
    }]);

    return ProxiedHTTPRequest;
  }(EventEmitter);

  var recast = new ProxiedHTTPRequest();

  origInstanceMap.set(recast, req);
  return recast;
}

function recastHTTPRes(res) {
  var ProxiedHTTPResponse = function () {
    function ProxiedHTTPResponse() {
      _classCallCheck(this, ProxiedHTTPResponse);
    }

    _createClass(ProxiedHTTPResponse, [{
      key: 'setHeader',
      value: function setHeader(header, value) {
        res.setHeader(header, value);
      }
    }, {
      key: 'writeHead',
      value: function writeHead(status, headers) {
        res.writeHead(status, headers);
      }
    }, {
      key: 'end',
      value: function end(body) {
        res.end(body);
      }
    }]);

    return ProxiedHTTPResponse;
  }();

  var recast = new ProxiedHTTPResponse();

  origInstanceMap.set(recast, res);
  return recast;
}

function createWrappedHTTPServer() {
  var server = http.createServer();

  var ProxiedHTTPServer = function (_EventEmitter4) {
    _inherits(ProxiedHTTPServer, _EventEmitter4);

    function ProxiedHTTPServer() {
      _classCallCheck(this, ProxiedHTTPServer);

      var _this5 = _possibleConstructorReturn(this, (ProxiedHTTPServer.__proto__ || Object.getPrototypeOf(ProxiedHTTPServer)).call(this));

      server.on('error', function (err) {
        return _this5.emit('error', err);
      });
      server.on('request', function (_req, _res) {
        var req = recastHTTPReq(_req);
        var res = recastHTTPRes(_res);
        _this5.emit('request', req, res);
      });
      return _this5;
    }

    _createClass(ProxiedHTTPServer, [{
      key: 'address',
      value: function address() {
        return server.address();
      }
    }, {
      key: 'listen',
      value: function listen(port, host, callback) {
        server.listen(port, host, callback);
      }
    }, {
      key: 'listening',
      get: function get() {
        return server.listening;
      }
    }]);

    return ProxiedHTTPServer;
  }(EventEmitter);

  var recast = new ProxiedHTTPServer();

  origInstanceMap.set(recast, server);
  return recast;
}

var proxiedHTTP = {
  createServer: createWrappedHTTPServer
};

module.exports = {
  createProxyServer: createProxyServer,
  ws: proxiedWS,
  http: proxiedHTTP
};

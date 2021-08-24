/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, { enumerable: true, get: getter });
/******/ 		}
/******/ 	};
/******/
/******/ 	// define __esModule on exports
/******/ 	__webpack_require__.r = function(exports) {
/******/ 		if(typeof Symbol !== 'undefined' && Symbol.toStringTag) {
/******/ 			Object.defineProperty(exports, Symbol.toStringTag, { value: 'Module' });
/******/ 		}
/******/ 		Object.defineProperty(exports, '__esModule', { value: true });
/******/ 	};
/******/
/******/ 	// create a fake namespace object
/******/ 	// mode & 1: value is a module id, require it
/******/ 	// mode & 2: merge all properties of value into the ns
/******/ 	// mode & 4: return value when already ns object
/******/ 	// mode & 8|1: behave like require
/******/ 	__webpack_require__.t = function(value, mode) {
/******/ 		if(mode & 1) value = __webpack_require__(value);
/******/ 		if(mode & 8) return value;
/******/ 		if((mode & 4) && typeof value === 'object' && value && value.__esModule) return value;
/******/ 		var ns = Object.create(null);
/******/ 		__webpack_require__.r(ns);
/******/ 		Object.defineProperty(ns, 'default', { enumerable: true, value: value });
/******/ 		if(mode & 2 && typeof value != 'string') for(var key in value) __webpack_require__.d(ns, key, function(key) { return value[key]; }.bind(null, key));
/******/ 		return ns;
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "/packs/";
/******/
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = "./app/javascript/packs/notifications.js");
/******/ })
/************************************************************************/
/******/ ({

/***/ "./app/javascript/packs/notifications.js":
/*!***********************************************!*\
  !*** ./app/javascript/packs/notifications.js ***!
  \***********************************************/
/*! no static exports found */
/***/ (function(module, exports) {

throw new Error("Module build failed (from ./node_modules/babel-loader/lib/index.js):\nSyntaxError: /home/mvelev/Blurred/app/javascript/packs/notifications.js: Unexpected token, expected \"{\" (2:2)\n\n  1 | class Notifications\n> 2 |   constructor: ->\n    |   ^\n  3 |     @notifications = $(\"[data-behavior='notifications']\")\n  4 | \n  5 |     if @notifications.length > 0\n    at Parser._raise (/home/mvelev/Blurred/node_modules/@babel/parser/lib/index.js:763:17)\n    at Parser.raiseWithData (/home/mvelev/Blurred/node_modules/@babel/parser/lib/index.js:756:17)\n    at Parser.raise (/home/mvelev/Blurred/node_modules/@babel/parser/lib/index.js:750:17)\n    at Parser.unexpected (/home/mvelev/Blurred/node_modules/@babel/parser/lib/index.js:8930:16)\n    at Parser.expect (/home/mvelev/Blurred/node_modules/@babel/parser/lib/index.js:8916:28)\n    at Parser.parseClassBody (/home/mvelev/Blurred/node_modules/@babel/parser/lib/index.js:12134:10)\n    at Parser.parseClass (/home/mvelev/Blurred/node_modules/@babel/parser/lib/index.js:12110:22)\n    at Parser.parseStatementContent (/home/mvelev/Blurred/node_modules/@babel/parser/lib/index.js:11390:21)\n    at Parser.parseStatement (/home/mvelev/Blurred/node_modules/@babel/parser/lib/index.js:11348:17)\n    at Parser.parseBlockOrModuleBlockBody (/home/mvelev/Blurred/node_modules/@babel/parser/lib/index.js:11930:25)\n    at Parser.parseBlockBody (/home/mvelev/Blurred/node_modules/@babel/parser/lib/index.js:11916:10)\n    at Parser.parseTopLevel (/home/mvelev/Blurred/node_modules/@babel/parser/lib/index.js:11279:10)\n    at Parser.parse (/home/mvelev/Blurred/node_modules/@babel/parser/lib/index.js:12984:10)\n    at parse (/home/mvelev/Blurred/node_modules/@babel/parser/lib/index.js:13037:38)\n    at parser (/home/mvelev/Blurred/node_modules/@babel/core/lib/parser/index.js:54:34)\n    at parser.next (<anonymous>)\n    at normalizeFile (/home/mvelev/Blurred/node_modules/@babel/core/lib/transformation/normalize-file.js:99:38)\n    at normalizeFile.next (<anonymous>)\n    at run (/home/mvelev/Blurred/node_modules/@babel/core/lib/transformation/index.js:31:50)\n    at run.next (<anonymous>)\n    at Function.transform (/home/mvelev/Blurred/node_modules/@babel/core/lib/transform.js:27:41)\n    at transform.next (<anonymous>)\n    at step (/home/mvelev/Blurred/node_modules/gensync/index.js:254:32)\n    at gen.next (/home/mvelev/Blurred/node_modules/gensync/index.js:266:13)\n    at async.call.value (/home/mvelev/Blurred/node_modules/gensync/index.js:216:11)\n    at errback.call (/home/mvelev/Blurred/node_modules/gensync/index.js:184:28)\n    at runGenerator.errback (/home/mvelev/Blurred/node_modules/@babel/core/lib/gensync-utils/async.js:72:7)\n    at val (/home/mvelev/Blurred/node_modules/gensync/index.js:108:33)\n    at step (/home/mvelev/Blurred/node_modules/gensync/index.js:280:14)\n    at gen.next (/home/mvelev/Blurred/node_modules/gensync/index.js:266:13)");

/***/ })

/******/ });
//# sourceMappingURL=notifications-a48a2043085c0e81a9e1.js.map
(function (global, factory) {
	typeof exports === 'object' && typeof module !== 'undefined' ? module.exports = factory() :
	typeof define === 'function' && define.amd ? define(factory) :
	(global = global || self, global.FileUploadWithPreview = factory());
}(this, (function () { 'use strict';

	function createCommonjsModule(fn, module) {
		return module = { exports: {} }, fn(module, module.exports), module.exports;
	}

	var runtime_1 = createCommonjsModule(function (module) {
	/**
	 * Copyright (c) 2014-present, Facebook, Inc.
	 *
	 * This source code is licensed under the MIT license found in the
	 * LICENSE file in the root directory of this source tree.
	 */

	var runtime = (function (exports) {

	  var Op = Object.prototype;
	  var hasOwn = Op.hasOwnProperty;
	  var undefined$1; // More compressible than void 0.
	  var $Symbol = typeof Symbol === "function" ? Symbol : {};
	  var iteratorSymbol = $Symbol.iterator || "@@iterator";
	  var asyncIteratorSymbol = $Symbol.asyncIterator || "@@asyncIterator";
	  var toStringTagSymbol = $Symbol.toStringTag || "@@toStringTag";

	  function define(obj, key, value) {
	    Object.defineProperty(obj, key, {
	      value: value,
	      enumerable: true,
	      configurable: true,
	      writable: true
	    });
	    return obj[key];
	  }
	  try {
	    // IE 8 has a broken Object.defineProperty that only works on DOM objects.
	    define({}, "");
	  } catch (err) {
	    define = function(obj, key, value) {
	      return obj[key] = value;
	    };
	  }

	  function wrap(innerFn, outerFn, self, tryLocsList) {
	    // If outerFn provided and outerFn.prototype is a Generator, then outerFn.prototype instanceof Generator.
	    var protoGenerator = outerFn && outerFn.prototype instanceof Generator ? outerFn : Generator;
	    var generator = Object.create(protoGenerator.prototype);
	    var context = new Context(tryLocsList || []);

	    // The ._invoke method unifies the implementations of the .next,
	    // .throw, and .return methods.
	    generator._invoke = makeInvokeMethod(innerFn, self, context);

	    return generator;
	  }
	  exports.wrap = wrap;

	  // Try/catch helper to minimize deoptimizations. Returns a completion
	  // record like context.tryEntries[i].completion. This interface could
	  // have been (and was previously) designed to take a closure to be
	  // invoked without arguments, but in all the cases we care about we
	  // already have an existing method we want to call, so there's no need
	  // to create a new function object. We can even get away with assuming
	  // the method takes exactly one argument, since that happens to be true
	  // in every case, so we don't have to touch the arguments object. The
	  // only additional allocation required is the completion record, which
	  // has a stable shape and so hopefully should be cheap to allocate.
	  function tryCatch(fn, obj, arg) {
	    try {
	      return { type: "normal", arg: fn.call(obj, arg) };
	    } catch (err) {
	      return { type: "throw", arg: err };
	    }
	  }

	  var GenStateSuspendedStart = "suspendedStart";
	  var GenStateSuspendedYield = "suspendedYield";
	  var GenStateExecuting = "executing";
	  var GenStateCompleted = "completed";

	  // Returning this object from the innerFn has the same effect as
	  // breaking out of the dispatch switch statement.
	  var ContinueSentinel = {};

	  // Dummy constructor functions that we use as the .constructor and
	  // .constructor.prototype properties for functions that return Generator
	  // objects. For full spec compliance, you may wish to configure your
	  // minifier not to mangle the names of these two functions.
	  function Generator() {}
	  function GeneratorFunction() {}
	  function GeneratorFunctionPrototype() {}

	  // This is a polyfill for %IteratorPrototype% for environments that
	  // don't natively support it.
	  var IteratorPrototype = {};
	  IteratorPrototype[iteratorSymbol] = function () {
	    return this;
	  };

	  var getProto = Object.getPrototypeOf;
	  var NativeIteratorPrototype = getProto && getProto(getProto(values([])));
	  if (NativeIteratorPrototype &&
	      NativeIteratorPrototype !== Op &&
	      hasOwn.call(NativeIteratorPrototype, iteratorSymbol)) {
	    // This environment has a native %IteratorPrototype%; use it instead
	    // of the polyfill.
	    IteratorPrototype = NativeIteratorPrototype;
	  }

	  var Gp = GeneratorFunctionPrototype.prototype =
	    Generator.prototype = Object.create(IteratorPrototype);
	  GeneratorFunction.prototype = Gp.constructor = GeneratorFunctionPrototype;
	  GeneratorFunctionPrototype.constructor = GeneratorFunction;
	  GeneratorFunction.displayName = define(
	    GeneratorFunctionPrototype,
	    toStringTagSymbol,
	    "GeneratorFunction"
	  );

	  // Helper for defining the .next, .throw, and .return methods of the
	  // Iterator interface in terms of a single ._invoke method.
	  function defineIteratorMethods(prototype) {
	    ["next", "throw", "return"].forEach(function(method) {
	      define(prototype, method, function(arg) {
	        return this._invoke(method, arg);
	      });
	    });
	  }

	  exports.isGeneratorFunction = function(genFun) {
	    var ctor = typeof genFun === "function" && genFun.constructor;
	    return ctor
	      ? ctor === GeneratorFunction ||
	        // For the native GeneratorFunction constructor, the best we can
	        // do is to check its .name property.
	        (ctor.displayName || ctor.name) === "GeneratorFunction"
	      : false;
	  };

	  exports.mark = function(genFun) {
	    if (Object.setPrototypeOf) {
	      Object.setPrototypeOf(genFun, GeneratorFunctionPrototype);
	    } else {
	      genFun.__proto__ = GeneratorFunctionPrototype;
	      define(genFun, toStringTagSymbol, "GeneratorFunction");
	    }
	    genFun.prototype = Object.create(Gp);
	    return genFun;
	  };

	  // Within the body of any async function, `await x` is transformed to
	  // `yield regeneratorRuntime.awrap(x)`, so that the runtime can test
	  // `hasOwn.call(value, "__await")` to determine if the yielded value is
	  // meant to be awaited.
	  exports.awrap = function(arg) {
	    return { __await: arg };
	  };

	  function AsyncIterator(generator, PromiseImpl) {
	    function invoke(method, arg, resolve, reject) {
	      var record = tryCatch(generator[method], generator, arg);
	      if (record.type === "throw") {
	        reject(record.arg);
	      } else {
	        var result = record.arg;
	        var value = result.value;
	        if (value &&
	            typeof value === "object" &&
	            hasOwn.call(value, "__await")) {
	          return PromiseImpl.resolve(value.__await).then(function(value) {
	            invoke("next", value, resolve, reject);
	          }, function(err) {
	            invoke("throw", err, resolve, reject);
	          });
	        }

	        return PromiseImpl.resolve(value).then(function(unwrapped) {
	          // When a yielded Promise is resolved, its final value becomes
	          // the .value of the Promise<{value,done}> result for the
	          // current iteration.
	          result.value = unwrapped;
	          resolve(result);
	        }, function(error) {
	          // If a rejected Promise was yielded, throw the rejection back
	          // into the async generator function so it can be handled there.
	          return invoke("throw", error, resolve, reject);
	        });
	      }
	    }

	    var previousPromise;

	    function enqueue(method, arg) {
	      function callInvokeWithMethodAndArg() {
	        return new PromiseImpl(function(resolve, reject) {
	          invoke(method, arg, resolve, reject);
	        });
	      }

	      return previousPromise =
	        // If enqueue has been called before, then we want to wait until
	        // all previous Promises have been resolved before calling invoke,
	        // so that results are always delivered in the correct order. If
	        // enqueue has not been called before, then it is important to
	        // call invoke immediately, without waiting on a callback to fire,
	        // so that the async generator function has the opportunity to do
	        // any necessary setup in a predictable way. This predictability
	        // is why the Promise constructor synchronously invokes its
	        // executor callback, and why async functions synchronously
	        // execute code before the first await. Since we implement simple
	        // async functions in terms of async generators, it is especially
	        // important to get this right, even though it requires care.
	        previousPromise ? previousPromise.then(
	          callInvokeWithMethodAndArg,
	          // Avoid propagating failures to Promises returned by later
	          // invocations of the iterator.
	          callInvokeWithMethodAndArg
	        ) : callInvokeWithMethodAndArg();
	    }

	    // Define the unified helper method that is used to implement .next,
	    // .throw, and .return (see defineIteratorMethods).
	    this._invoke = enqueue;
	  }

	  defineIteratorMethods(AsyncIterator.prototype);
	  AsyncIterator.prototype[asyncIteratorSymbol] = function () {
	    return this;
	  };
	  exports.AsyncIterator = AsyncIterator;

	  // Note that simple async functions are implemented on top of
	  // AsyncIterator objects; they just return a Promise for the value of
	  // the final result produced by the iterator.
	  exports.async = function(innerFn, outerFn, self, tryLocsList, PromiseImpl) {
	    if (PromiseImpl === void 0) PromiseImpl = Promise;

	    var iter = new AsyncIterator(
	      wrap(innerFn, outerFn, self, tryLocsList),
	      PromiseImpl
	    );

	    return exports.isGeneratorFunction(outerFn)
	      ? iter // If outerFn is a generator, return the full iterator.
	      : iter.next().then(function(result) {
	          return result.done ? result.value : iter.next();
	        });
	  };

	  function makeInvokeMethod(innerFn, self, context) {
	    var state = GenStateSuspendedStart;

	    return function invoke(method, arg) {
	      if (state === GenStateExecuting) {
	        throw new Error("Generator is already running");
	      }

	      if (state === GenStateCompleted) {
	        if (method === "throw") {
	          throw arg;
	        }

	        // Be forgiving, per 25.3.3.3.3 of the spec:
	        // https://people.mozilla.org/~jorendorff/es6-draft.html#sec-generatorresume
	        return doneResult();
	      }

	      context.method = method;
	      context.arg = arg;

	      while (true) {
	        var delegate = context.delegate;
	        if (delegate) {
	          var delegateResult = maybeInvokeDelegate(delegate, context);
	          if (delegateResult) {
	            if (delegateResult === ContinueSentinel) continue;
	            return delegateResult;
	          }
	        }

	        if (context.method === "next") {
	          // Setting context._sent for legacy support of Babel's
	          // function.sent implementation.
	          context.sent = context._sent = context.arg;

	        } else if (context.method === "throw") {
	          if (state === GenStateSuspendedStart) {
	            state = GenStateCompleted;
	            throw context.arg;
	          }

	          context.dispatchException(context.arg);

	        } else if (context.method === "return") {
	          context.abrupt("return", context.arg);
	        }

	        state = GenStateExecuting;

	        var record = tryCatch(innerFn, self, context);
	        if (record.type === "normal") {
	          // If an exception is thrown from innerFn, we leave state ===
	          // GenStateExecuting and loop back for another invocation.
	          state = context.done
	            ? GenStateCompleted
	            : GenStateSuspendedYield;

	          if (record.arg === ContinueSentinel) {
	            continue;
	          }

	          return {
	            value: record.arg,
	            done: context.done
	          };

	        } else if (record.type === "throw") {
	          state = GenStateCompleted;
	          // Dispatch the exception by looping back around to the
	          // context.dispatchException(context.arg) call above.
	          context.method = "throw";
	          context.arg = record.arg;
	        }
	      }
	    };
	  }

	  // Call delegate.iterator[context.method](context.arg) and handle the
	  // result, either by returning a { value, done } result from the
	  // delegate iterator, or by modifying context.method and context.arg,
	  // setting context.delegate to null, and returning the ContinueSentinel.
	  function maybeInvokeDelegate(delegate, context) {
	    var method = delegate.iterator[context.method];
	    if (method === undefined$1) {
	      // A .throw or .return when the delegate iterator has no .throw
	      // method always terminates the yield* loop.
	      context.delegate = null;

	      if (context.method === "throw") {
	        // Note: ["return"] must be used for ES3 parsing compatibility.
	        if (delegate.iterator["return"]) {
	          // If the delegate iterator has a return method, give it a
	          // chance to clean up.
	          context.method = "return";
	          context.arg = undefined$1;
	          maybeInvokeDelegate(delegate, context);

	          if (context.method === "throw") {
	            // If maybeInvokeDelegate(context) changed context.method from
	            // "return" to "throw", let that override the TypeError below.
	            return ContinueSentinel;
	          }
	        }

	        context.method = "throw";
	        context.arg = new TypeError(
	          "The iterator does not provide a 'throw' method");
	      }

	      return ContinueSentinel;
	    }

	    var record = tryCatch(method, delegate.iterator, context.arg);

	    if (record.type === "throw") {
	      context.method = "throw";
	      context.arg = record.arg;
	      context.delegate = null;
	      return ContinueSentinel;
	    }

	    var info = record.arg;

	    if (! info) {
	      context.method = "throw";
	      context.arg = new TypeError("iterator result is not an object");
	      context.delegate = null;
	      return ContinueSentinel;
	    }

	    if (info.done) {
	      // Assign the result of the finished delegate to the temporary
	      // variable specified by delegate.resultName (see delegateYield).
	      context[delegate.resultName] = info.value;

	      // Resume execution at the desired location (see delegateYield).
	      context.next = delegate.nextLoc;

	      // If context.method was "throw" but the delegate handled the
	      // exception, let the outer generator proceed normally. If
	      // context.method was "next", forget context.arg since it has been
	      // "consumed" by the delegate iterator. If context.method was
	      // "return", allow the original .return call to continue in the
	      // outer generator.
	      if (context.method !== "return") {
	        context.method = "next";
	        context.arg = undefined$1;
	      }

	    } else {
	      // Re-yield the result returned by the delegate method.
	      return info;
	    }

	    // The delegate iterator is finished, so forget it and continue with
	    // the outer generator.
	    context.delegate = null;
	    return ContinueSentinel;
	  }

	  // Define Generator.prototype.{next,throw,return} in terms of the
	  // unified ._invoke helper method.
	  defineIteratorMethods(Gp);

	  define(Gp, toStringTagSymbol, "Generator");

	  // A Generator should always return itself as the iterator object when the
	  // @@iterator function is called on it. Some browsers' implementations of the
	  // iterator prototype chain incorrectly implement this, causing the Generator
	  // object to not be returned from this call. This ensures that doesn't happen.
	  // See https://github.com/facebook/regenerator/issues/274 for more details.
	  Gp[iteratorSymbol] = function() {
	    return this;
	  };

	  Gp.toString = function() {
	    return "[object Generator]";
	  };

	  function pushTryEntry(locs) {
	    var entry = { tryLoc: locs[0] };

	    if (1 in locs) {
	      entry.catchLoc = locs[1];
	    }

	    if (2 in locs) {
	      entry.finallyLoc = locs[2];
	      entry.afterLoc = locs[3];
	    }

	    this.tryEntries.push(entry);
	  }

	  function resetTryEntry(entry) {
	    var record = entry.completion || {};
	    record.type = "normal";
	    delete record.arg;
	    entry.completion = record;
	  }

	  function Context(tryLocsList) {
	    // The root entry object (effectively a try statement without a catch
	    // or a finally block) gives us a place to store values thrown from
	    // locations where there is no enclosing try statement.
	    this.tryEntries = [{ tryLoc: "root" }];
	    tryLocsList.forEach(pushTryEntry, this);
	    this.reset(true);
	  }

	  exports.keys = function(object) {
	    var keys = [];
	    for (var key in object) {
	      keys.push(key);
	    }
	    keys.reverse();

	    // Rather than returning an object with a next method, we keep
	    // things simple and return the next function itself.
	    return function next() {
	      while (keys.length) {
	        var key = keys.pop();
	        if (key in object) {
	          next.value = key;
	          next.done = false;
	          return next;
	        }
	      }

	      // To avoid creating an additional object, we just hang the .value
	      // and .done properties off the next function object itself. This
	      // also ensures that the minifier will not anonymize the function.
	      next.done = true;
	      return next;
	    };
	  };

	  function values(iterable) {
	    if (iterable) {
	      var iteratorMethod = iterable[iteratorSymbol];
	      if (iteratorMethod) {
	        return iteratorMethod.call(iterable);
	      }

	      if (typeof iterable.next === "function") {
	        return iterable;
	      }

	      if (!isNaN(iterable.length)) {
	        var i = -1, next = function next() {
	          while (++i < iterable.length) {
	            if (hasOwn.call(iterable, i)) {
	              next.value = iterable[i];
	              next.done = false;
	              return next;
	            }
	          }

	          next.value = undefined$1;
	          next.done = true;

	          return next;
	        };

	        return next.next = next;
	      }
	    }

	    // Return an iterator with no values.
	    return { next: doneResult };
	  }
	  exports.values = values;

	  function doneResult() {
	    return { value: undefined$1, done: true };
	  }

	  Context.prototype = {
	    constructor: Context,

	    reset: function(skipTempReset) {
	      this.prev = 0;
	      this.next = 0;
	      // Resetting context._sent for legacy support of Babel's
	      // function.sent implementation.
	      this.sent = this._sent = undefined$1;
	      this.done = false;
	      this.delegate = null;

	      this.method = "next";
	      this.arg = undefined$1;

	      this.tryEntries.forEach(resetTryEntry);

	      if (!skipTempReset) {
	        for (var name in this) {
	          // Not sure about the optimal order of these conditions:
	          if (name.charAt(0) === "t" &&
	              hasOwn.call(this, name) &&
	              !isNaN(+name.slice(1))) {
	            this[name] = undefined$1;
	          }
	        }
	      }
	    },

	    stop: function() {
	      this.done = true;

	      var rootEntry = this.tryEntries[0];
	      var rootRecord = rootEntry.completion;
	      if (rootRecord.type === "throw") {
	        throw rootRecord.arg;
	      }

	      return this.rval;
	    },

	    dispatchException: function(exception) {
	      if (this.done) {
	        throw exception;
	      }

	      var context = this;
	      function handle(loc, caught) {
	        record.type = "throw";
	        record.arg = exception;
	        context.next = loc;

	        if (caught) {
	          // If the dispatched exception was caught by a catch block,
	          // then let that catch block handle the exception normally.
	          context.method = "next";
	          context.arg = undefined$1;
	        }

	        return !! caught;
	      }

	      for (var i = this.tryEntries.length - 1; i >= 0; --i) {
	        var entry = this.tryEntries[i];
	        var record = entry.completion;

	        if (entry.tryLoc === "root") {
	          // Exception thrown outside of any try block that could handle
	          // it, so set the completion value of the entire function to
	          // throw the exception.
	          return handle("end");
	        }

	        if (entry.tryLoc <= this.prev) {
	          var hasCatch = hasOwn.call(entry, "catchLoc");
	          var hasFinally = hasOwn.call(entry, "finallyLoc");

	          if (hasCatch && hasFinally) {
	            if (this.prev < entry.catchLoc) {
	              return handle(entry.catchLoc, true);
	            } else if (this.prev < entry.finallyLoc) {
	              return handle(entry.finallyLoc);
	            }

	          } else if (hasCatch) {
	            if (this.prev < entry.catchLoc) {
	              return handle(entry.catchLoc, true);
	            }

	          } else if (hasFinally) {
	            if (this.prev < entry.finallyLoc) {
	              return handle(entry.finallyLoc);
	            }

	          } else {
	            throw new Error("try statement without catch or finally");
	          }
	        }
	      }
	    },

	    abrupt: function(type, arg) {
	      for (var i = this.tryEntries.length - 1; i >= 0; --i) {
	        var entry = this.tryEntries[i];
	        if (entry.tryLoc <= this.prev &&
	            hasOwn.call(entry, "finallyLoc") &&
	            this.prev < entry.finallyLoc) {
	          var finallyEntry = entry;
	          break;
	        }
	      }

	      if (finallyEntry &&
	          (type === "break" ||
	           type === "continue") &&
	          finallyEntry.tryLoc <= arg &&
	          arg <= finallyEntry.finallyLoc) {
	        // Ignore the finally entry if control is not jumping to a
	        // location outside the try/catch block.
	        finallyEntry = null;
	      }

	      var record = finallyEntry ? finallyEntry.completion : {};
	      record.type = type;
	      record.arg = arg;

	      if (finallyEntry) {
	        this.method = "next";
	        this.next = finallyEntry.finallyLoc;
	        return ContinueSentinel;
	      }

	      return this.complete(record);
	    },

	    complete: function(record, afterLoc) {
	      if (record.type === "throw") {
	        throw record.arg;
	      }

	      if (record.type === "break" ||
	          record.type === "continue") {
	        this.next = record.arg;
	      } else if (record.type === "return") {
	        this.rval = this.arg = record.arg;
	        this.method = "return";
	        this.next = "end";
	      } else if (record.type === "normal" && afterLoc) {
	        this.next = afterLoc;
	      }

	      return ContinueSentinel;
	    },

	    finish: function(finallyLoc) {
	      for (var i = this.tryEntries.length - 1; i >= 0; --i) {
	        var entry = this.tryEntries[i];
	        if (entry.finallyLoc === finallyLoc) {
	          this.complete(entry.completion, entry.afterLoc);
	          resetTryEntry(entry);
	          return ContinueSentinel;
	        }
	      }
	    },

	    "catch": function(tryLoc) {
	      for (var i = this.tryEntries.length - 1; i >= 0; --i) {
	        var entry = this.tryEntries[i];
	        if (entry.tryLoc === tryLoc) {
	          var record = entry.completion;
	          if (record.type === "throw") {
	            var thrown = record.arg;
	            resetTryEntry(entry);
	          }
	          return thrown;
	        }
	      }

	      // The context.catch method must only be called with a location
	      // argument that corresponds to a known catch block.
	      throw new Error("illegal catch attempt");
	    },

	    delegateYield: function(iterable, resultName, nextLoc) {
	      this.delegate = {
	        iterator: values(iterable),
	        resultName: resultName,
	        nextLoc: nextLoc
	      };

	      if (this.method === "next") {
	        // Deliberately forget the last sent value so that we don't
	        // accidentally pass it on to the delegate.
	        this.arg = undefined$1;
	      }

	      return ContinueSentinel;
	    }
	  };

	  // Regardless of whether this script is executing as a CommonJS module
	  // or not, return the runtime object so that we can declare the variable
	  // regeneratorRuntime in the outer scope, which allows this module to be
	  // injected easily by `bin/regenerator --include-runtime script.js`.
	  return exports;

	}(
	  // If this script is executing as a CommonJS module, use module.exports
	  // as the regeneratorRuntime namespace. Otherwise create a new empty
	  // object. Either way, the resulting object will be used to initialize
	  // the regeneratorRuntime variable at the top of this file.
	   module.exports 
	));

	try {
	  regeneratorRuntime = runtime;
	} catch (accidentalStrictMode) {
	  // This module should not be running in strict mode, so the above
	  // assignment should always work unless something is misconfigured. Just
	  // in case runtime.js accidentally runs in strict mode, we can escape
	  // strict mode using a global Function call. This could conceivably fail
	  // if a Content Security Policy forbids using Function, but in that case
	  // the proper solution is to fix the accidental strict mode problem. If
	  // you've misconfigured your bundler to force strict mode and applied a
	  // CSP to forbid Function, and you're not willing to fix either of those
	  // problems, please detail your unique predicament in a GitHub issue.
	  Function("r", "regeneratorRuntime = r")(runtime);
	}
	});

	var regenerator = runtime_1;

	function asyncGeneratorStep(gen, resolve, reject, _next, _throw, key, arg) {
	  try {
	    var info = gen[key](arg);
	    var value = info.value;
	  } catch (error) {
	    reject(error);
	    return;
	  }

	  if (info.done) {
	    resolve(value);
	  } else {
	    Promise.resolve(value).then(_next, _throw);
	  }
	}

	function _asyncToGenerator(fn) {
	  return function () {
	    var self = this,
	        args = arguments;
	    return new Promise(function (resolve, reject) {
	      var gen = fn.apply(self, args);

	      function _next(value) {
	        asyncGeneratorStep(gen, resolve, reject, _next, _throw, "next", value);
	      }

	      function _throw(err) {
	        asyncGeneratorStep(gen, resolve, reject, _next, _throw, "throw", err);
	      }

	      _next(undefined);
	    });
	  };
	}

	var asyncToGenerator = _asyncToGenerator;

	function _classCallCheck(instance, Constructor) {
	  if (!(instance instanceof Constructor)) {
	    throw new TypeError("Cannot call a class as a function");
	  }
	}

	var classCallCheck = _classCallCheck;

	function _defineProperties(target, props) {
	  for (var i = 0; i < props.length; i++) {
	    var descriptor = props[i];
	    descriptor.enumerable = descriptor.enumerable || false;
	    descriptor.configurable = true;
	    if ("value" in descriptor) descriptor.writable = true;
	    Object.defineProperty(target, descriptor.key, descriptor);
	  }
	}

	function _createClass(Constructor, protoProps, staticProps) {
	  if (protoProps) _defineProperties(Constructor.prototype, protoProps);
	  if (staticProps) _defineProperties(Constructor, staticProps);
	  return Constructor;
	}

	var createClass = _createClass;

	/* eslint-disable */
	// this is for matches in older ie browsers
	if (!Element.prototype.matches) {
	  Element.prototype.matches = Element.prototype.matchesSelector || Element.prototype.mozMatchesSelector || Element.prototype.msMatchesSelector || Element.prototype.oMatchesSelector || Element.prototype.webkitMatchesSelector || function (s) {
	    var matches = (this.document || this.ownerDocument).querySelectorAll(s),
	        i = matches.length;

	    while (--i >= 0 && matches.item(i) !== this) {}

	    return i > -1;
	  };
	} // https://tc39.github.io/ecma262/#sec-array.prototype.findindex


	if (!Array.prototype.findIndex) {
	  Object.defineProperty(Array.prototype, 'findIndex', {
	    value: function value(predicate) {
	      // 1. Let O be ? ToObject(this value).
	      if (this == null) {
	        throw new TypeError('"this" is null or not defined');
	      }

	      var o = Object(this); // 2. Let len be ? ToLength(? Get(O, "length")).

	      var len = o.length >>> 0; // 3. If IsCallable(predicate) is false, throw a TypeError exception.

	      if (typeof predicate !== 'function') {
	        throw new TypeError('predicate must be a function');
	      } // 4. If thisArg was supplied, let T be thisArg; else let T be undefined.


	      var thisArg = arguments[1]; // 5. Let k be 0.

	      var k = 0; // 6. Repeat, while k < len

	      while (k < len) {
	        // a. Let Pk be ! ToString(k).
	        // b. Let kValue be ? Get(O, Pk).
	        // c. Let testResult be ToBoolean(? Call(predicate, T, « kValue, k, O »)).
	        // d. If testResult is true, return k.
	        var kValue = o[k];

	        if (predicate.call(thisArg, kValue, k, o)) {
	          return k;
	        } // e. Increase k by 1.


	        k++;
	      } // 7. Return -1.


	      return -1;
	    },
	    configurable: true,
	    writable: true
	  });
	} // this is for custom events in older ie browsers
	// https://developer.mozilla.org/en-US/docs/Web/API/CustomEvent/CustomEvent


	(function () {
	  if (typeof window.CustomEvent === "function") return false;

	  function CustomEvent(event, params) {
	    params = params || {
	      bubbles: false,
	      cancelable: false,
	      detail: null
	    };
	    var evt = document.createEvent('CustomEvent');
	    evt.initCustomEvent(event, params.bubbles, params.cancelable, params.detail);
	    return evt;
	  }

	  CustomEvent.prototype = window.Event.prototype;
	  window.CustomEvent = CustomEvent;
	})();
	/* eslint-enable */

	var FileUploadWithPreview = /*#__PURE__*/function () {
	  function FileUploadWithPreview(uploadId, options) {
	    classCallCheck(this, FileUploadWithPreview);

	    // Make sure uploadId was specified
	    if (!uploadId) {
	      throw new Error('No uploadId found. You must initialize file-upload-with-preview with a unique uploadId.');
	    } // Set initial variables


	    this.uploadId = uploadId;
	    this.options = options || {};
	    this.options.showDeleteButtonOnImages = this.options.hasOwnProperty('showDeleteButtonOnImages') ? this.options.showDeleteButtonOnImages : true;
	    this.options.text = this.options.hasOwnProperty('text') ? this.options.text : {
	      chooseFile: 'Choose file...'
	    };
	    this.options.text.chooseFile = this.options.text.hasOwnProperty('chooseFile') ? this.options.text.chooseFile : 'Choose file...';
	    this.options.text.browse = this.options.text.hasOwnProperty('browse') ? this.options.text.browse : 'Browse';
	    this.options.text.selectedCount = this.options.text.hasOwnProperty('selectedCount') ? this.options.text.selectedCount : 'files selected';
	    this.options.maxFileCount = this.options.hasOwnProperty('maxFileCount') ? this.options.maxFileCount : 0;
	    this.cachedFileArray = [];
	    this.currentFileCount = 0; // Grab the custom file container elements

	    this.el = document.querySelector(".custom-file-container[data-upload-id=\"".concat(this.uploadId, "\"]"));

	    if (!this.el) {
	      throw new Error("Could not find a 'custom-file-container' with the id of: ".concat(this.uploadId));
	    }

	    this.input = this.el.querySelector('input[type="file"]');
	    this.inputLabel = this.el.querySelector('.custom-file-container__custom-file__custom-file-control');
	    this.imagePreview = this.el.querySelector('.custom-file-container__image-preview');
	    this.clearButton = this.el.querySelector('.custom-file-container__image-clear');
	    this.inputLabel.innerHTML = this.options.text.chooseFile;
	    this.addBrowseButton(this.options.text.browse); // Make sure all elements have been attached

	    if (!this.el || !this.input || !this.inputLabel || !this.imagePreview || !this.clearButton) {
	      throw new Error("Cannot find all necessary elements. Please make sure you have all the necessary elements in your html for the id: ".concat(this.uploadId));
	    } // Check if images option is set


	    this.options.images = this.options.hasOwnProperty('images') ? this.options.images : {}; // Set the base64 background images

	    this.baseImage = this.options.images.hasOwnProperty('baseImage') ? this.options.images.baseImage : 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAiQAAAD6CAMAAACmhqw0AAAA+VBMVEUAAAD29u3u7unt7ent7enu7uju7uihoqCio6Gio6KjpKOkpaSmpqSmp6WoqKaqq6mqq6qrq6qsrautrauur62wsa6xsa+xsrCys7GztLK0tbK1trS2t7S3t7W4uba5ure6u7e7vLm8vbu9vrvAwL3Awb3DxMHFxcPGxsPHx8TIycXLzMjLzMnMzMnNzsrPz8vP0MzQ0M3S0s/U1NDV1dLX19TY2NTY2NXZ2dba2tXb29bc3Nfc3Njc3dnd3dre3tre39vg4Nvh4dzi4t3i4t7j497k5N/k5ODl5eDl5eHl5uLm5uHn5+Lo6OPp6eTq6uXr6+bs7Oft7eh54KxIAAAAB3RSTlMAHKbl5uztvql9swAABA1JREFUeNrt3VlT01AYgOG0oEEE910URNzFBVFcqCgKirLU/P8fI3QYbEOSdtrMyJzzvHfMlFx833NBQuY0SRrN8UwqabzZSJLGaYNQVacaSdMUVF0zGTMEVTeWmIH6BYkgESSCRJAIEkEiSCRIBIkgESSCRJAIEkEiQSJIBIkgESSCRJAIEgkSQSJIBIkgESSCRJBIkAgSQSJIBIkgESSCRIJEkAgSQSJIBIkgkSARJIJEkAgSQSJIBIkEiSARJIJEkAgSQSJIJEgEiSARJIJEkAgSQSJBIkgEiSARJIJEkAgSCRJBIkgEiSARJIJEgkSQ5PvxbdS+tyEJuZVb0+noTV579geSQGs/SOvqxiYkYfYwra+rbUhC7NNEjUjSJ5CE2P06jaTnIAmxKwe7vb468t3N14WOki1IAuzMwWrf1HCh3Q6S95AEWGe1b0/WlSCBBBJIIAkdSXvt1aNXa21IICld7dJU5+epJUggKV7tzuzRA4/ZHUggKVrtfNdjsXlIIClY7XLPw9NlSCA5vtqLPUguQgLJsdX+zv0fZhsSSPKrXckhWSn5jV8zG5DEiuR1DsnrEiOX0vMbkESKZDWHZLXMSFqsBJIIkOz1vn40sVdqpFgJJDHc3dzsQXKzwkihEkhiQLI+2f3y+3qVkSIlkMSAJFvsQrJYbaRACSRRIMlenj0UcPZlPyPHlUASB5Jsc+7cwevMc5v9jRxTAkkkSPbb+riVZYMYySuBJB4kJRUYySmBJHYkhUZ6lUASOZISIz1KIIkbSamRbiWQxIZkvT2YkS4lkESGpDV9tz2YkX9KIIkLSWs6TY+U9DFypASSqJC0OicfHSrpa2T/k5BEh6R1eDpWR8kARtIZSGJD0jo6QW1fySBGIIkOSavrlL27PwcxAklsSFo9JzFOppBAkl9ta5jTOiGJCslQRiCJCslwRiCJCcmQRiCJCMmwRiCJB8mXoU+YhyQaJM9TSCCBBBJIIIEEEkgggQQSSCCJAsnyzLA9hiQWJCfnSpBAAgkkkATXxFCnPxfU7iB5B0mAXT5Y7Z3t0Y087SDZgCTA7tX6bZ5TGSQBtlwrkgVIgmy+RiMXdiEJsp3b9Rn5nEESaC/O1/P3yMJuBkm4bX94O2rvNiKbWXRIBIkgESSCRJAIEkEiQSJIBIkgESSCRJAIEgkSQSJIBIkgESSCRIJEkAgSQSJIBIkgESQSJIJEkAgSQSJIBIkgkSARJIJEkAgSQSJIBIkEiSARJIJEkAgSQSJIJEgEiSARJIJEkAgSCRJBIkgEiSARJIJEkEiQCBJBIkgEiSARJIJEgkSQCBJBIkgEiSARJBIkgkSQ6P8gGTMDVTeWNA1B1TWTxmlTUFWnGknSaI4bhMoabzaSv+4BHFVoHZzfAAAAAElFTkSuQmCC';
	    this.successPdfImage = this.options.images.hasOwnProperty('successPdfImage') ? this.options.images.successPdfImage : 'data:image/png;base64,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';
	    this.successVideoImage = this.options.images.hasOwnProperty('successVideoImage') ? this.options.images.successVideoImage : 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAfQAAAD6CAYAAABXq7VOAAAABGdBTUEAALGPC/xhBQAAEpNJREFUeAHt3UtsXOd1B/BvJPFlWaRIPWxZcQLHUSorsEwLltMEMRzYQJBsvEi66C4IkFW7aldZpkHQbRdFu6nX3dVAgGyCAOkiruvIcfwCEtlyJAe2RSUUORJpmZRIccIrWX6QQ3Ie987cOfc3G0szc7/vO79zjL9mho/a3NylRnIjQIAAAQIEBlpg10Cf3uEJECBAgACBWwIC3SAQIECAAIEAAgI9QBOVQIAAAQIEBLoZIECAAAECAQQEeoAmKoEAAQIECAh0M0CAAAECBAIICPQATVQCAQIECBAQ6GaAAAECBAgEEBDoAZqoBAIECBAgINDNAAECBAgQCCAg0AM0UQkECBAgQECgmwECBAgQIBBAQKAHaKISCBAgQICAQDcDBAgQIEAggIBAD9BEJRAgQIAAAYFuBggQIECAQAABgR6giUogQIAAAQIC3QwQIECAAIEAAgI9QBOVQIAAAQIEBLoZIECAAAECAQQEeoAmKoEAAQIECAh0M0CAAAECBAIICPQATVQCAQIECBAQ6GaAAAECBAgEEBDoAZqoBAIECBAgINDNAAECBAgQCCAg0AM0UQkECBAgQECgmwECBAgQIBBAQKAHaKISCBAgQICAQDcDBAgQIEAggIBAD9BEJRAgQIAAAYFuBggQIECAQAABgR6giUogQIAAAQIC3QwQIECAAIEAAgI9QBOVQIAAAQIEBLoZIECAAAECAQQEeoAmKoEAAQIECAh0M0CAAAECBAIICPQATVQCAQIECBAQ6GaAAAECBAgEEBDoAZqoBAIECBAgINDNAAECBAgQCCAg0AM0UQkECBAgQECgmwECBAgQIBBAQKAHaKISCBAgQICAQDcDBAgQIEAggIBAD9BEJRAgQIAAAYFuBggQIECAQAABgR6giUogQIAAAQIC3QwQIECAAIEAAgI9QBOVQIAAAQIEBLoZIECAAAECAQQEeoAmKoEAAQIECAh0M0CAAAECBAIICPQATVQCAQIECBAQ6GaAAAECBAgEEBDoAZqoBAIECBAgINDNAAECBAgQCCAg0AM0UQkECBAgQECgmwECBAgQIBBAQKAHaKISCBAgQICAQDcDBAgQIEAggIBAD9BEJRAgQIAAAYFuBggQIECAQAABgR6giUogQIAAAQIC3QwQIECAAIEAAgI9QBOVQIAAAQIEBLoZIECAAAECAQQEeoAmKoEAAQIECAh0M0CAAAECBAIICPQATVQCAQIECBAQ6GaAAAECBAgEEBDoAZqoBAIECBAgINDNAAECBAgQCCAg0AM0UQkECBAgQECgmwECBAgQIBBAQKAHaKISCBAgQICAQDcDBAgQIEAggIBAD9BEJRAgQIAAAYFuBggQIECAQAABgR6giUogQIAAAQIC3QwQIECAAIEAAgI9QBOVQIAAAQIEBLoZIECAAAECAQQEeoAmKoEAAQIECAh0M0CAAAECBAIICPQATVQCAQIECBAQ6GaAAAECBAgEEBDoAZqoBAIECBAgINDNAAECBAgQCCAg0AM0UQkECBAgQECgmwECBAgQIBBAQKAHaKISCBAgQICAQDcDBAgQIEAggIBAD9BEJRAgQIAAAYFuBggQIECAQAABgR6giUogQIAAAQIC3QwQIECAAIEAAgI9QBOVQIAAAQIEBLoZIECAAAECAQQEeoAmKoEAAQIECAh0M0CAAAECBAIICPQATVQCAQIECBAQ6GaAAAECBAgEEBDoAZqoBAIECBAgINDNAAECBAgQCCAg0AM0UQkECBAgQECgmwECBAgQIBBAQKAHaKISCBAgQICAQDcDBAgQIEAggIBAD9BEJRAgQIAAAYFuBggQIECAQAABgR6giUogQIAAAQIC3QwQIECAAIEAAgI9QBOVQIAAAQIEBLoZIECAAAECAQQEeoAmKoEAAQIECAh0M0CAAAECBAIICPQATVQCAQIECBAQ6GaAAAECBAgEEBDoAZqoBAIECBAgINDNAAECBAgQCCAg0AM0UQkECBAgQECgmwECBAgQIBBAQKAHaKISCBAgQICAQDcDBAgQIEAggIBAD9BEJRAgQIAAAYFuBggQIECAQAABgR6giUogQIAAAQIC3QwQIECAAIEAAgI9QBOVQIAAAQIEBLoZIECAAAECAQQEeoAmKoEAAQIECAh0M0CAAAECBAIICPQATVQCAQIECBAQ6GaAAAECBAgEEBDoAZqoBAIECBAgINDNAAECBAgQCCAg0AM0UQkECBAgQECgmwECBAgQIBBAQKAHaKISCBAgQICAQDcDBAgQIEAggIBAD9BEJRAgQIAAAYFuBggQIECAQAABgR6giUogQIAAAQIC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';
	    this.successFileAltImage = this.options.images.hasOwnProperty('successFileAltImage') ? this.options.images.successFileAltImage : 'data:image/png;base64,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';
	    this.backgroundImage = this.options.images.hasOwnProperty('backgroundImage') ? this.options.images.backgroundImage : 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAiQAAAD6CAYAAACRWFwGAAAABGdBTUEAALGPC/xhBQAADFNJREFUeAHt2jFOG1EUQNH5VpBGLnEVxB7CDpJVZRHZSLaRLIE9IFy5tSwRaTKjpEOU1i18XFmA7OfzXnEFjGl9nM+nx8vlz49lmb5N0/J5+5oHAQIECBAgQOB6AuM4xvRrnj993+8PL+NfjLw9rzFyf7039coECBAgQIAAgfcCa5Sc5vnuaff/NyNi5L2RrxAgQIAAAQJXFlh/IXLYWmS3Pvl65ffy8gQIECBAgACBDwW2Ftmt/zPy8OFP+AYBAgQIECBA4OoCy8MaJB4ECBAgQIAAgVZAkLT+3p0AAQIECBBYBQSJMyBAgAABAgRyAUGSr8AABAgQIECAgCBxAwQIECBAgEAuIEjyFRiAAAECBAgQECRugAABAgQIEMgFBEm+AgMQIECAAAECgsQNECBAgAABArmAIMlXYAACBAgQIEBAkLgBAgQIECBAIBcQJPkKDECAAAECBAgIEjdAgAABAgQI5AKCJF+BAQgQIECAAAFB4gYIECBAgACBXECQ5CswAAECBAgQICBI3AABAgQIECCQCwiSfAUGIECAAAECBASJGyBAgAABAgRyAUGSr8AABAgQIECAgCBxAwQIECBAgEAuIEjyFRiAAAECBAgQECRugAABAgQIEMgFBEm+AgMQIECAAAECgsQNECBAgAABArmAIMlXYAACBAgQIEBAkLgBAgQIECBAIBcQJPkKDECAAAECBAgIEjdAgAABAgQI5AKCJF+BAQgQIECAAAFB4gYIECBAgACBXECQ5CswAAECBAgQICBI3AABAgQIECCQCwiSfAUGIECAAAECBASJGyBAgAABAgRyAUGSr8AABAgQIECAgCBxAwQIECBAgEAuIEjyFRiAAAECBAgQECRugAABAgQIEMgFBEm+AgMQIECAAAECgsQNECBAgAABArmAIMlXYAACBAgQIEBAkLgBAgQIECBAIBcQJPkKDECAAAECBAgIEjdAgAABAgQI5AKCJF+BAQgQIECAAAFB4gYIECBAgACBXECQ5CswAAECBAgQICBI3AABAgQIECCQCwiSfAUGIECAAAECBASJGyBAgAABAgRyAUGSr8AABAgQIECAgCBxAwQIECBAgEAuIEjyFRiAAAECBAgQECRugAABAgQIEMgFBEm+AgMQIECAAAECgsQNECBAgAABArmAIMlXYAACBAgQIEBAkLgBAgQIECBAIBcQJPkKDECAAAECBAgIEjdAgAABAgQI5AKCJF+BAQgQIECAAAFB4gYIECBAgACBXECQ5CswAAECBAgQICBI3AABAgQIECCQCwiSfAUGIECAAAECBASJGyBAgAABAgRyAUGSr8AABAgQIECAgCBxAwQIECBAgEAuIEjyFRiAAAECBAgQECRugAABAgQIEMgFBEm+AgMQIECAAAECgsQNECBAgAABArmAIMlXYAACBAgQIEBAkLgBAgQIECBAIBcQJPkKDECAAAECBAgIEjdAgAABAgQI5AKCJF+BAQgQIECAAAFB4gYIECBAgACBXECQ5CswAAECBAgQICBI3AABAgQIECCQCwiSfAUGIECAAAECBASJGyBAgAABAgRyAUGSr8AABAgQIECAgCBxAwQIECBAgEAuIEjyFRiAAAECBAgQECRugAABAgQIEMgFBEm+AgMQIECAAAECgsQNECBAgAABArmAIMlXYAACBAgQIEBAkLgBAgQIECBAIBcQJPkKDECAAAECBAgIEjdAgAABAgQI5AKCJF+BAQgQIECAAAFB4gYIECBAgACBXECQ5CswAAECBAgQICBI3AABAgQIECCQCwiSfAUGIECAAAECBASJGyBAgAABAgRyAUGSr8AABAgQIECAgCBxAwQIECBAgEAuIEjyFRiAAAECBAgQECRugAABAgQIEMgFBEm+AgMQIECAAAECgsQNECBAgAABArmAIMlXYAACBAgQIEBAkLgBAgQIECBAIBcQJPkKDECAAAECBAgIEjdAgAABAgQI5AKCJF+BAQgQIECAAAFB4gYIECBAgACBXECQ5CswAAECBAgQICBI3AABAgQIECCQCwiSfAUGIECAAAECBASJGyBAgAABAgRyAUGSr8AABAgQIECAgCBxAwQIECBAgEAuIEjyFRiAAAECBAgQECRugAABAgQIEMgFBEm+AgMQIECAAAECgsQNECBAgAABArmAIMlXYAACBAgQIEBAkLgBAgQIECBAIBcQJPkKDECAAAECBAgIEjdAgAABAgQI5AKCJF+BAQgQIECAAAFB4gYIECBAgACBXECQ5CswAAECBAgQICBI3AABAgQIECCQCwiSfAUGIECAAAECBASJGyBAgAABAgRyAUGSr8AABAgQIECAgCBxAwQIECBAgEAuIEjyFRiAAAECBAgQECRugAABAgQIEMgFBEm+AgMQIECAAAECgsQNECBAgAABArmAIMlXYAACBAgQIEBAkLgBAgQIECBAIBcQJPkKDECAAAECBAgIEjdAgAABAgQI5AKCJF+BAQgQIECAAAFB4gYIECBAgACBXECQ5CswAAECBAgQICBI3AABAgQIECCQCwiSfAUGIECAAAECBASJGyBAgAABAgRyAUGSr8AABAgQIECAgCBxAwQIECBAgEAuIEjyFRiAAAECBAgQECRugAABAgQIEMgFBEm+AgMQIECAAAECgsQNECBAgAABArmAIMlXYAACBAgQIEBAkLgBAgQIECBAIBcQJPkKDECAAAECBAgIEjdAgAABAgQI5AKCJF+BAQgQIECAAAFB4gYIECBAgACBXECQ5CswAAECBAgQICBI3AABAgQIECCQCwiSfAUGIECAAAECBASJGyBAgAABAgRyAUGSr8AABAgQIECAgCBxAwQIECBAgEAuIEjyFRiAAAECBAgQECRugAABAgQIEMgFBEm+AgMQIECAAAECgsQNECBAgAABArmAIMlXYAACBAgQIEBAkLgBAgQIECBAIBcQJPkKDECAAAECBAgIEjdAgAABAgQI5AKCJF+BAQgQIECAAAFB4gYIECBAgACBXECQ5CswAAECBAgQICBI3AABAgQIECCQCwiSfAUGIECAAAECBASJGyBAgAABAgRyAUGSr8AABAgQIECAgCBxAwQIECBAgEAuIEjyFRiAAAECBAgQECRugAABAgQIEMgFBEm+AgMQIECAAAECgsQNECBAgAABArmAIMlXYAACBAgQIEBAkLgBAgQIECBAIBcQJPkKDECAAAECBAgIEjdAgAABAgQI5AKCJF+BAQgQIECAAAFB4gYIECBAgACBXECQ5CswAAECBAgQICBI3AABAgQIECCQCwiSfAUGIECAAAECBASJGyBAgAABAgRyAUGSr8AABAgQIECAgCBxAwQIECBAgEAuIEjyFRiAAAECBAgQECRugAABAgQIEMgFBEm+AgMQIECAAAECgsQNECBAgAABArmAIMlXYAACBAgQIEBAkLgBAgQIECBAIBcQJPkKDECAAAECBAgIEjdAgAABAgQI5AKCJF+BAQgQIECAAAFB4gYIECBAgACBXECQ5CswAAECBAgQICBI3AABAgQIECCQCwiSfAUGIECAAAECBASJGyBAgAABAgRyAUGSr8AABAgQIECAgCBxAwQIECBAgEAuIEjyFRiAAAECBAgQECRugAABAgQIEMgFBEm+AgMQIECAAAECgsQNECBAgAABArmAIMlXYAACBAgQIEBAkLgBAgQIECBAIBcQJPkKDECAAAECBAgIEjdAgAABAgQI5AKCJF+BAQgQIECAAAFB4gYIECBAgACBXECQ5CswAAECBAgQICBI3AABAgQIECCQCwiSfAUGIECAAAECBASJGyBAgAABAgRyAUGSr8AABAgQIECAgCBxAwQIECBAgEAuIEjyFRiAAAECBAgQECRugAABAgQIEMgFBEm+AgMQIECAAAECgsQNECBAgAABArmAIMlXYAACBAgQIEBAkLgBAgQIECBAIBcQJPkKDECAAAECBAgIEjdAgAABAgQI5AKCJF+BAQgQIECAAAFB4gYIECBAgACBXECQ5CswAAECBAgQICBI3AABAgQIECCQC6xBMl7zKQxAgAABAgQI3LDAeN2NMf2+YQEfnQABAgQIEIgFthYZ5/Pp8XJ5e16W6T6ex9sTIECAAAECNyawxshpnu+edvv94WV98mWM8XP9883xxhx8XAIECBAgQCARGMetPbYY2VrkL3ZQPayX+qtWAAAAAElFTkSuQmCC'; // Set click events

	    this.bindClickEvents(); // Let's set the placeholder image

	    this.imagePreview.style.backgroundImage = "url(\"".concat(this.baseImage, "\")"); // Check for any preset files and process these if provided

	    this.options.presetFiles = this.options.hasOwnProperty('presetFiles') ? this.options.presetFiles : null;

	    if (this.options.presetFiles) {
	      // Using thenable promises because we're in the constructor
	      this.addImagesFromPath(this.options.presetFiles).then(function () {}).catch(function (error) {
	        console.log('Error - ' + error.toString());
	        console.log('Warning - An image you added from a path is not able to be added to the cachedFileArray.');
	      });
	    }
	  }

	  createClass(FileUploadWithPreview, [{
	    key: "bindClickEvents",
	    value: function bindClickEvents() {
	      var _this = this;

	      // Grab the current instance
	      var self = this; // Deal with the change event on the input

	      self.input.addEventListener('change', function () {
	        self.addFiles(this.files);
	      }, true); // Listen for the clear button

	      this.clearButton.addEventListener('click', function () {
	        _this.clearPreviewPanel();
	      }, true); // Listen for individual clear buttons on images

	      this.imagePreview.addEventListener('click', function (event) {
	        // Listen for the specific click of a clear button
	        if (event.target.matches('.custom-file-container__image-multi-preview__single-image-clear__icon')) {
	          // Grab the clicked function
	          var clearFileButton = event.target; // Get its token

	          var fileToken = clearFileButton.getAttribute('data-upload-token'); // Get the index of the file

	          var selectedFileIndex = _this.cachedFileArray.findIndex(function (x) {
	            return x.token === fileToken;
	          });

	          _this.deleteFileAtIndex(selectedFileIndex);
	        }
	      });
	    } // Populate the cachedFileArray with images as File objects

	  }, {
	    key: "addFiles",
	    value: function addFiles(files) {
	      // Grab the current instance
	      var self = this; // In this case, the user most likely had hit cancel - which does something
	      // a little strange if they had already selected a single or multiple images -
	      // it acts like they now have *no* files - which isn't true. We'll just check here
	      // for any cached images already captured,
	      // and proceed normally. If something *does* want
	      // to clear their images, they'll use the clear button on the label we provide.

	      if (files.length === 0) {
	        return;
	      }

	      console.log(self); // Check for file count limit

	      var adjustedFilesLength = files.length;

	      if (self.options.maxFileCount > 0) {
	        if (files.length + self.cachedFileArray.length > self.options.maxFileCount) {
	          // Limit exceeded.  Truncate list.
	          adjustedFilesLength = self.options.maxFileCount - self.cachedFileArray.length;
	        }
	      } // If the input is set to allow multiple files, then we'll add to
	      // the existing file count and keep the cachedFileArray. If not,
	      // then we'll reset the file count and reset the cachedFileArray


	      if (self.input.multiple) {
	        self.currentFileCount += adjustedFilesLength;
	      } else {
	        self.currentFileCount = adjustedFilesLength;
	        self.cachedFileArray = [];
	      } // Now let's loop over the added images and
	      // act accordingly based on there were multiple images or not


	      for (var x = 0; x < adjustedFilesLength; x++) {
	        // Grab this index's file
	        var file = files[x]; // To make sure each image can be treated individually, let's give
	        // each file a unique token

	        file.token = Math.random().toString(36).substring(2, 15) + Math.random().toString(36).substring(2, 15); // File/files added.

	        self.cachedFileArray.push(file); // Process file

	        self.processFile(file);
	      } // Send out our event


	      var imagesAddedEvent = new CustomEvent('fileUploadWithPreview:imagesAdded', {
	        detail: {
	          files: files,
	          uploadId: self.uploadId,
	          cachedFileArray: self.cachedFileArray,
	          addedFilesCount: adjustedFilesLength
	        }
	      });
	      window.dispatchEvent(imagesAddedEvent);
	    } // Take a single File object and append it to the image preview panel

	  }, {
	    key: "processFile",
	    value: function processFile(file) {
	      var _this2 = this;

	      // Update our input label here based on instance currentFileCount
	      if (this.currentFileCount === 0) {
	        this.inputLabel.innerHTML = this.options.text.chooseFile;
	      } else if (this.currentFileCount === 1) {
	        this.inputLabel.innerHTML = file.name;
	      } else {
	        this.inputLabel.innerHTML = "".concat(this.currentFileCount, " ").concat(this.options.text.selectedCount);
	      }

	      this.addBrowseButton(this.options.text.browse); // Apply the 'custom-file-container__image-preview--active' class

	      this.imagePreview.classList.add('custom-file-container__image-preview--active'); // Set up our reader

	      var reader = new FileReader();
	      reader.readAsDataURL(file); // Check the file and act accordingly

	      reader.onload = function () {
	        // We'll pivot here and go through our cases.
	        // The logic we've set is basically as follows:
	        // If this is an input that only accepts a single image, then just show
	        // back that single image each time, and their file count is always 1.
	        // If they have `multiple` set on the input, then what we'll do is ADD
	        // images to the `cachedImageArray`. We'll show the images in a grid style at all times when
	        // `multiple` is set on the input. If the user wants to get rid of all the
	        // images they'll used the `x` button near the input, or the `x` button on the image.
	        ////////////////////////////////////////////////////
	        // First, we'll deal with a single selected image //
	        ////////////////////////////////////////////////////
	        if (!_this2.input.multiple) {
	          //If png, jpg/jpeg, gif, use the actual image
	          if (file.type.match('image/png') || file.type.match('image/jpeg') || file.type.match('image/gif')) {
	            _this2.imagePreview.style.backgroundImage = "url(\"".concat(reader.result, "\")");
	          } else if (file.type.match('application/pdf')) {
	            //PDF Upload
	            _this2.imagePreview.style.backgroundImage = "url(\"".concat(_this2.successPdfImage, "\")");
	          } else if (file.type.match('video/*')) {
	            //Video upload
	            _this2.imagePreview.style.backgroundImage = "url(\"".concat(_this2.successVideoImage, "\")");
	          } else {
	            //Everything else
	            _this2.imagePreview.style.backgroundImage = "url(\"".concat(_this2.successFileAltImage, "\")");
	          }
	        } //////////////////////////////////////////////////////////
	        // The next logic set is for a multiple situation, and  //
	        // they want to show multiple images                    //
	        //////////////////////////////////////////////////////////


	        if (_this2.input.multiple) {
	          // Set the main panel's background image to the blank one here
	          _this2.imagePreview.style.backgroundImage = "url(\"".concat(_this2.backgroundImage, "\")"); //If png, jpg/jpeg, gif, use the actual image

	          if (file.type.match('image/png') || file.type.match('image/jpeg') || file.type.match('image/gif')) {
	            if (_this2.options.showDeleteButtonOnImages) {
	              _this2.imagePreview.innerHTML += "\n                            <div\n                                class=\"custom-file-container__image-multi-preview\"\n                                data-upload-token=\"".concat(file.token, "\"\n                                style=\"background-image: url('").concat(reader.result, "'); \"\n                            >\n                                <span class=\"custom-file-container__image-multi-preview__single-image-clear\">\n                                    <span\n                                        class=\"custom-file-container__image-multi-preview__single-image-clear__icon\"\n                                        data-upload-token=\"").concat(file.token, "\"\n                                    >&times;</span>\n                                </span>\n                            </div>\n                        ");
	            } else {
	              _this2.imagePreview.innerHTML += "\n                            <div\n                                class=\"custom-file-container__image-multi-preview\"\n                                data-upload-token=\"".concat(file.token, "\"\n                                style=\"background-image: url('").concat(reader.result, "'); \"\n                            ></div>\n                        ");
	            }
	          } else if (file.type.match('application/pdf')) {
	            //PDF Upload
	            if (_this2.options.showDeleteButtonOnImages) {
	              _this2.imagePreview.innerHTML += "\n                            <div\n                                class=\"custom-file-container__image-multi-preview\"\n                                data-upload-token=\"".concat(file.token, "\"\n                                style=\"background-image: url('").concat(_this2.successPdfImage, "'); \"\n                            >\n                                <span class=\"custom-file-container__image-multi-preview__single-image-clear\">\n                                    <span\n                                        class=\"custom-file-container__image-multi-preview__single-image-clear__icon\"\n                                        data-upload-token=\"").concat(file.token, "\"\n                                    >&times;</span>\n                                </span>\n                            </div>\n                        ");
	            } else {
	              _this2.imagePreview.innerHTML += "\n                            <div\n                                class=\"custom-file-container__image-multi-preview\"\n                                data-upload-token=\"".concat(file.token, "\"\n                                style=\"background-image: url('").concat(_this2.successPdfImage, "'); \"\n                            ></div>\n                        ");
	            }
	          } else if (file.type.match('video/*')) {
	            //Video upload
	            if (_this2.options.showDeleteButtonOnImages) {
	              _this2.imagePreview.innerHTML += "\n                            <div\n                                class=\"custom-file-container__image-multi-preview\"\n                                style=\"background-image: url('".concat(_this2.successVideoImage, "'); \"\n                                data-upload-token=\"").concat(file.token, "\"\n                            >\n                                <span class=\"custom-file-container__image-multi-preview__single-image-clear\">\n                                    <span\n                                        class=\"custom-file-container__image-multi-preview__single-image-clear__icon\"\n                                        data-upload-token=\"").concat(file.token, "\"\n                                    >&times;</span>\n                                </span>\n                            </div>\n                        ");
	            } else {
	              _this2.imagePreview.innerHTML += "\n                            <div\n                                class=\"custom-file-container__image-multi-preview\"\n                                style=\"background-image: url('".concat(_this2.successVideoImage, "'); \"\n                                data-upload-token=\"").concat(file.token, "\"\n                            ></div>\n                        ");
	            }
	          } else {
	            //Everything else
	            if (_this2.options.showDeleteButtonOnImages) {
	              _this2.imagePreview.innerHTML += "\n                            <div\n                                class=\"custom-file-container__image-multi-preview\"\n                                style=\"background-image: url('".concat(_this2.successFileAltImage, "'); \"\n                                data-upload-token=\"").concat(file.token, "\"\n                            >\n                                <span class=\"custom-file-container__image-multi-preview__single-image-clear\">\n                                    <span\n                                        class=\"custom-file-container__image-multi-preview__single-image-clear__icon\"\n                                        data-upload-token=\"").concat(file.token, "\"\n                                    >&times;</span>\n                                </span>\n                            </div>\n                        ");
	            } else {
	              _this2.imagePreview.innerHTML += "\n                            <div\n                                class=\"custom-file-container__image-multi-preview\"\n                                style=\"background-image: url('".concat(_this2.successFileAltImage, "'); \"\n                                data-upload-token=\"").concat(file.token, "\"\n                            ></div>\n                        ");
	            }
	          }
	        }
	      };
	    } // Take an array of image paths, convert them to File objects,
	    // and display them in the image preview panel
	    // https://stackoverflow.com/questions/25046301/convert-url-to-file-or-blob-for-filereader-readasdataurl

	  }, {
	    key: "addImagesFromPath",
	    value: function addImagesFromPath(files) {
	      var _this3 = this;

	      return new Promise( /*#__PURE__*/function () {
	        var _ref = asyncToGenerator( /*#__PURE__*/regenerator.mark(function _callee(resolve, reject) {
	          var presetFiles, x, response, blob, presetFile;
	          return regenerator.wrap(function _callee$(_context) {
	            while (1) {
	              switch (_context.prev = _context.next) {
	                case 0:
	                  presetFiles = [];
	                  x = 0;

	                case 2:
	                  if (!(x < files.length)) {
	                    _context.next = 24;
	                    break;
	                  }

	                  /* eslint-disable no-await-in-loop */
	                  response = void 0;
	                  blob = void 0;
	                  _context.prev = 5;
	                  _context.next = 8;
	                  return fetch(files[x], {
	                    mode: 'cors'
	                  });

	                case 8:
	                  response = _context.sent;
	                  _context.next = 11;
	                  return response.blob();

	                case 11:
	                  blob = _context.sent;
	                  _context.next = 18;
	                  break;

	                case 14:
	                  _context.prev = 14;
	                  _context.t0 = _context["catch"](5);
	                  reject(_context.t0);
	                  return _context.abrupt("continue", 21);

	                case 18:
	                  /* eslint-enable no-await-in-loop */
	                  // Create blob and added
	                  presetFile = new Blob([blob], {
	                    type: blob.type
	                  });
	                  presetFile.name = files[x].split('/').pop();
	                  presetFiles.push(presetFile);

	                case 21:
	                  x++;
	                  _context.next = 2;
	                  break;

	                case 24:
	                  _this3.addFiles(presetFiles);

	                  resolve();

	                case 26:
	                case "end":
	                  return _context.stop();
	              }
	            }
	          }, _callee, null, [[5, 14]]);
	        }));

	        return function (_x, _x2) {
	          return _ref.apply(this, arguments);
	        };
	      }());
	    } // Take an array of File objects and display them in the image preview panel

	  }, {
	    key: "replaceFiles",
	    value: function replaceFiles(files) {
	      if (!files.length) {
	        throw new Error('Array must contain at least one file.');
	      } // Replace the cachedFileArray with the new files


	      this.cachedFileArray = files; // Call function to refresh the preview

	      this.refreshPreviewPanel();
	    } // Take a single File object and index, replace existing file at that index

	  }, {
	    key: "replaceFileAtIndex",
	    value: function replaceFileAtIndex(file, index) {
	      if (!file) {
	        throw new Error('No file found.');
	      }

	      if (!this.cachedFileArray[index]) {
	        throw new Error('There is no file at index', index);
	      } // Replace the cachedFileArray with the new files


	      this.cachedFileArray[index] = file; // Call function to refresh the preview

	      this.refreshPreviewPanel();
	    } // Delete specified File from `cachedFileArray`

	  }, {
	    key: "deleteFileAtIndex",
	    value: function deleteFileAtIndex(index) {
	      // check if index exists
	      if (!this.cachedFileArray[index]) {
	        throw new Error('There is no file at index', index);
	      } // Remove the file from the array


	      this.cachedFileArray.splice(index, 1); // Call function to refresh the preview

	      this.refreshPreviewPanel(); // Send out our deletion event

	      var imageDeletedEvent = new CustomEvent('fileUploadWithPreview:imageDeleted', {
	        detail: {
	          index: index,
	          uploadId: this.uploadId,
	          cachedFileArray: this.cachedFileArray,
	          currentFileCount: this.currentFileCount
	        }
	      });
	      window.dispatchEvent(imageDeletedEvent);
	    } // Refresh image preview panel with current cachedFileArray

	  }, {
	    key: "refreshPreviewPanel",
	    value: function refreshPreviewPanel() {
	      var _this4 = this;

	      // Clear the imagePreview pane
	      this.imagePreview.innerHTML = ''; // Reset our currentFileCount with the new proper count

	      this.currentFileCount = this.cachedFileArray.length; // Load back up the images in the pane with the new updated cachedFileArray

	      this.cachedFileArray.forEach(function (file) {
	        return _this4.processFile(file);
	      }); // If there's no images left after the latest deletion event,
	      // then let's reset the panel entirely

	      if (!this.cachedFileArray.length) {
	        this.clearPreviewPanel();
	      }
	    } // Appends a browse button to input with custom button text

	  }, {
	    key: "addBrowseButton",
	    value: function addBrowseButton(text) {
	      this.inputLabel.innerHTML += "<span class=\"custom-file-container__custom-file__custom-file-control__button\"> ".concat(text, " </span>");
	    } // Open the image browser

	  }, {
	    key: "emulateInputSelection",
	    value: function emulateInputSelection() {
	      this.input.click();
	    } // Clear the cachedFileArray and a

	  }, {
	    key: "clearPreviewPanel",
	    value: function clearPreviewPanel() {
	      this.input.value = '';
	      this.inputLabel.innerHTML = this.options.text.chooseFile;
	      this.addBrowseButton(this.options.text.browse);
	      this.imagePreview.style.backgroundImage = "url(\"".concat(this.baseImage, "\")");
	      this.imagePreview.classList.remove('custom-file-container__image-preview--active');
	      this.cachedFileArray = [];
	      this.imagePreview.innerHTML = '';
	      this.currentFileCount = 0;
	    }
	  }]);

	  return FileUploadWithPreview;
	}();

	return FileUploadWithPreview;

})));

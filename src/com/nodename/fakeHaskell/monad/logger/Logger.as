package com.nodename.fakeHaskell.monad.logger
{
	public final class Logger
	{
		private static const NO_VALUE:* = null;
		
		public static function mReturn(value:*):Logger
		{
			// TraceLog can be replaced by any class (such as ArrayLog) that implements Log:
			return new Logger(LOCK, value, new TraceLog());
		}
		
		public static function record(message:String):Logger
		{
			const aLogger:Logger = mReturn(NO_VALUE);
			aLogger._log.push(message);
			return aLogger;
		}
		
		public static function runLogger(aLogger:Logger):LogPair
		{
			return new LogPair(aLogger._value, aLogger._log);
		}
		
		protected static const LOCK:Object = {};
		
		
		private var _value:*;
		private var _log:Log;
		
		public function Logger(lock:Object, value:*, log:Log)
		{
			if (lock != LOCK)
			{
				throw new Error("Logger: invalid constructor access");
			}
			_value = value;
			_log = log;
		}
		
		// This is the >>= operator in Haskell
		public function bind(f:Function):Logger
		{
			// f :: * -> Logger
			
			// unwrap this:
			const pair1:LogPair = runLogger(this);
			const a:* = pair1.value;
			const log1:Log = pair1.log;
			
			// apply f to the value:
			const n:Logger = f(a);
			
			// unwrap the result:
			const pair2:LogPair = runLogger(n);
			const b:* = pair2.value;
			const log2:Log = pair2.log;
			
			// reassemble the monadic structure appropriately:
			return new Logger(LOCK, b, log1.concat(log2));
		}
		
		// This is the >> operator in Haskell
		// It sequences like bind() but the function f does not take an argument:
		// f :: () -> Logger
		public function chain(f:Function):Logger
		{
			// so we implement chain() by binding a function that ignores its argument:
			return bind(function(anything:*):Logger { return f(); });
		}
		
	}
}
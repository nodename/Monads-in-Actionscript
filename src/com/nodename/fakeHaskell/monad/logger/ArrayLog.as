package com.nodename.fakeHaskell.monad.logger
{
	internal final class ArrayLog implements Log
	{
		private var _log:Array;
		
		public function ArrayLog()
		{
			_log = [];
		}
		
		public function push(element:*):void
		{
			_log.push(element);
		}
		
		public function concat(other:Log):Log
		{
			const otherArrayLog:ArrayLog = other as ArrayLog;
			const newArrayLog:ArrayLog = new ArrayLog();
			const newLogArray:Array = _log.concat(otherArrayLog._log);
			newArrayLog._log = newArrayLog._log.concat(newLogArray);
			return newArrayLog;
		}
		
		public function toString():String
		{
			return "[" + _log.toString() + "]";
		}
	}
}
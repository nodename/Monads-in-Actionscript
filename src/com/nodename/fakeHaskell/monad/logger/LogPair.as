package com.nodename.fakeHaskell.monad.logger
{
	public final class LogPair
	{
		private var _a:*;
		internal function get value():* { return _a; }
		private var _log:Log;
		internal function get log():Log { return _log; }
		
		public function LogPair(a:*, log:Log)
		{
			_a = a;
			_log = log;
		}
		
		public function toString():String
		{
			return "(" + _a + "," + _log + ")";
		}
		
	}
}
package com.nodename.fakeHaskell.monad.logger
{
	internal final class TraceLog implements Log
	{
		public function TraceLog()
		{
			// nothing
		}
		
		public function push(element:*):void
		{
			trace(element);
		}
		
		public function concat(other:Log):Log
		{
			return this;
		}
		
		public function toString():String
		{
			return "";
		}
	}
}
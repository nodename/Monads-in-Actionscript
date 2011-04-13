package com.nodename.fakeHaskell.monad.logger
{
	public interface Log
	{
		function push(element:*):void;
		function concat(other:Log):Log;
		function toString():String;
	}
}
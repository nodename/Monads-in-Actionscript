package test
{
	public function theLoggerMonad():void
	{
		test1();
		test2();
		test3();
		test4();
	}
}

import com.nodename.fakeHaskell.monad.logger.Logger;
import monadicCode.globToRegex;
	
function test1():void
{
	const simpleLogger:Logger = Logger.mReturn(true);
	trace(Logger.runLogger(simpleLogger));
}

function test2():void
{
	function b():Logger { return Logger.mReturn(3.1337); }
	const logger:Logger = Logger.record("Hi, Mom!").chain(b);
	trace(Logger.runLogger(logger));
}

function test3():void
{
	const logger:Logger = globToRegex("?");
	trace(Logger.runLogger(logger));
}

function test4():void
{
	const logger:Logger = globToRegex("[abc]?[!xyz]");
	trace(Logger.runLogger(logger));
}

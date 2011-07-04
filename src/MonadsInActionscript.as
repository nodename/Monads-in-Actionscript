package
{
	import flash.display.Sprite;
	
	import test.theMaybeMonad;
	import test.theLiftMfunction;
	import test.theLoggerMonad;
	
	// A strongly-typed implementation of monads requires two features that we don't have in Actionscript:
	// 1. Parameterized types (other than Vector) so that we could specify, say,
	//	"a Maybe containing a Point" (written in C# as Maybe<Point> or in Haskell simply as Maybe Point)
	//	or "a Logger containing a RegExp" (C#: Logger<RegExp>; Haskell: Logger Regexp);
	// 2. Fully-specified Function types, so that we could specify "a Function taking a String argument and returning an Integer"
	// (C#: Func<String, Int>; Haskell: f :: String -> Integer)
	
	// So we'll be throwing stars in our monad implementations, and we'll have to be careful to keep track of
	// our parameter and return types.
	
	// None of the comments in these source files is going to explain in general what a nonad is.
	// Hopefully you will gain benefit from understanding a couple of specific monad types.
	
	public class MonadsInActionscript extends Sprite
	{
		public function MonadsInActionscript()
		{
			trace("the Maybe monad:\n");
			
			theMaybeMonad();
			
			trace("\n" +
				"\n" +
				"the liftM function:" +
				"\n");
			
			theLiftMfunction();
			
			trace("\n" +
				"\n" +
				"the Logger Monad:" +
				"\n");
			
			theLoggerMonad();
		}
	}
}


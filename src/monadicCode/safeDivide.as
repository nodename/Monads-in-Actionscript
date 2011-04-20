// safeDivide: a monadic function that uses the Maybe monad to protect us from divide-by-zero errors

// We should be able to define this function as liftM2 of the / operator

package monadicCode
{
	import com.nodename.fakeHaskell.monad.maybe.NOTHING;
	import com.nodename.fakeHaskell.monad.maybe.classes.Maybe;
	import com.nodename.fakeHaskell.monad.maybe.classes.Nothing;
	import com.nodename.fakeHaskell.monad.maybe.just;

	public function safeDivide(x:Maybe, y:Maybe):Maybe
	{
		if (x is Nothing || y is Nothing)
		{
			return NOTHING;
		}
		
		const yValue:* = y.fromJust();
		if (yValue == 0)
		{
			return NOTHING;
		}
		return just(x.fromJust() / yValue);
	}
}

/*
Here's safeDivide defined in Haskell:


(//) :: Maybe a -> Maybe a -> Maybe a
_ // Nothing = Nothing
Nothing // _  = Nothing
_ // Just 0 = Nothing
Just x // Just y = Just (x / y)

*/
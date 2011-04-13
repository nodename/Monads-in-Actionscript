package com.nodename.fakeHaskell.monad.maybe
{
	import com.nodename.fakeHaskell.monad.maybe.classes.Maybe;
	import com.nodename.fakeHaskell.monad.maybe.classes.Nothing;

	// maybe :: b -> (a -> b) -> Maybe a -> b
	public function maybe(defaultB:*, aToB:Function, maybeA:Maybe):*
	{
		if (maybeA is Nothing)
		{
			return defaultB;
		}
		else
		{
			const a:* = Maybe.fromJust(maybeA);
			return aToB(a);
		}
	}
}

/*

maybe              :: b -> (a -> b) -> Maybe a -> b
maybe n f Nothing  =  n
maybe n f (Just x) =  f x

*/
package com.nodename.fakeHaskell.monad.maybe
{
	import com.nodename.fakeHaskell.monad.maybe.classes.Maybe;
	import com.nodename.fakeHaskell.monad.maybe.just;
	
	// definitely not in Haskell, which has no null, but a very common use for Maybe in languages with null!
	public function maybeFromObject(a:*):Maybe
	{
		return a == null ? NOTHING : just(a);
	}
}
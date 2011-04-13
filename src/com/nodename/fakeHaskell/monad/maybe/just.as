package com.nodename.fakeHaskell.monad.maybe
{
	import com.nodename.fakeHaskell.monad.maybe.classes.Just;
	import com.nodename.fakeHaskell.monad.maybe.classes.Maybe;
	
	public function just(value:*):Maybe
	{
		return new Just(value);
	}
}
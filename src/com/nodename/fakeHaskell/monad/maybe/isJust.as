package com.nodename.fakeHaskell.monad.maybe
{
	import com.nodename.fakeHaskell.monad.maybe.classes.Nothing;

	public function isJust(m:Maybe):Boolean
	{
		return !(m is Nothing);
	}
}
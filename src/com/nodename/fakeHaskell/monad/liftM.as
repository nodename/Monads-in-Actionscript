package com.nodename.fakeHaskell.monad
{
	public function liftM(f:Function, Monad:Class):Function
	{
		// f :: a -> b
		
		// lambda :: a -> m b
		function lambda(i:*):Object
		{
			return Monad["mReturn"](f(i));
		}
		
		// liftedFunction :: m a -> m b
		function liftedFunction(monadicObject:/* Monad */ Object):/* Monad */ Object
		{
			return monadicObject["bind"](lambda);
		}
		
		return liftedFunction;
	}
}
/*
This is a definition of liftM in Haskell.
You can see it's quite similar.
Remember:
	>>=		is	bind expressed as an infix operator
	return	is	mReturn
	\		is	lambda

liftM :: (Monad m) => (a -> b) -> m a -> m b
liftM f m = m >>= \i ->
			return (f i)

*/
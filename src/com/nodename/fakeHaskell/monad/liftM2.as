package com.nodename.fakeHaskell.monad
{
	public function liftM2(f:Function, Monad:Class):Function
	{
		// f :: a -> b -> c
		

		// liftedFunction :: m a -> m b -> m c

		function liftedFunction(monadicObjectA:/* Monad */ Object, monadicObjectB:/* Monad */ Object):/* Monad */ Object
		{
			return monadicObjectA["bind"](
				function(a:*):/* Monad */ Object
				{
					trace("liftM2: first level");
					return monadicObjectB["bind"](
						function(b:*):/* Monad */ Object
						{
							trace("liftM2: second level");
							return Monad["mReturn"](f(a, b));
						}
					);
				}
			);
		}
		
		return liftedFunction;
	}
}
/* Here's liftM2 defined in Haskell:


liftM2 :: (Monad m) => (a -> b -> c) -> m a -> m b -> m c
liftM2 f m1 m2 =
	m1 >>= \a ->
	m2 >>= \b ->
	return (f a b)

*/
package test.maybe
{
	import com.nodename.fakeHaskell.monad.maybe.classes.Maybe;
	import com.nodename.fakeHaskell.monad.maybe.just;
	
	import monadicCode.safeDivide;

	public function safeDivideTest():void
	{
		const x:Maybe = just(5);
		const y:Maybe = just(0);
		const z:Maybe = safeDivide(x, y);
		trace(z);
		
		// Here we specify the value we want back if z should be Nothing.
		// The monad makes no assumption about that; Nothing contains no implied value:
		const result:* = z.fromMaybe(Infinity);
		trace(result);
	}
}
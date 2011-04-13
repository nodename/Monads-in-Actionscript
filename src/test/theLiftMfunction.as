package test
{
	import com.nodename.fakeHaskell.monad.liftM;
	import com.nodename.fakeHaskell.monad.maybe.classes.Maybe;
	import monadicCode.DatabaseAccess;

	public function theLiftMfunction():void
	{
		const databaseAccess:DatabaseAccess = new DatabaseAccess();
		
		// length :: String -> uint
		function length(string:String):uint { return string.length; }
		
		const monadicObject1:Maybe = databaseAccess.fullName(0);
		const monadicObject2:Maybe = databaseAccess.fullName(1);
		
		trace("monadic object 1:", monadicObject1);
		trace("monadic object 2:", monadicObject2);
		trace();
		
		// liftM() brings my function into the monad:
		
		// liftedFunction :: Maybe String -> Maybe uint
		const liftedFunction:Function = liftM(length, Maybe);
		
		// so I can apply it there:
		const result1:Maybe = liftedFunction(monadicObject1);
		const result2:Maybe = liftedFunction(monadicObject2);
		// or simply liftM(length, Maybe)(monadicObject);
		
		trace("length of monadic object 1:", result1);
		trace("length of monadic object 2:", result2);
	}
}
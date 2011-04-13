package monadicCode
{
	import com.nodename.fakeHaskell.monad.liftM2;
	import com.nodename.fakeHaskell.monad.maybe.classes.Maybe;
	import com.nodename.fakeHaskell.monad.maybe.classes.Nothing;
	import com.nodename.fakeHaskell.monad.maybe.just;
	import com.nodename.fakeHaskell.monad.maybe.maybe;
	import com.nodename.fakeHaskell.monad.maybe.maybeFromObject;
	
	// DatabaseAccess: a null-safe service class that uses the Maybe monad
	
	// Although there are null values in the DATABASE,
	// our application code contains NO null tests.
	// The Maybe monad wraps values so we never encounter a null.
	
	public final class DatabaseAccess
	{
		private static const DATABASE:Object =
		{
			firstNames: [ "Albert", "Franz", null, null ],
			lastNames: [ "Einstein", null, null, "Liszt" ]
		};
		
		public function DatabaseAccess()
		{
			// nothing
		}
			
		public function firstName(id:uint):Maybe
		{
			trace("getting firstName(" + id + ")");
			return maybeFromObject(DATABASE.firstNames[id]);
		}
		
		public function lastName(id:uint):Maybe
		{
			trace("getting lastName(" + id + ")");
			return maybeFromObject(DATABASE.lastNames[id]);
		}
		
		// fullName :: uint -> Maybe String
		public function fullName(id:uint):Maybe
		{
			return firstName(id).bind(
				function(fname:String):Maybe
				{
					return lastName(id).bind(
						function(lname:String):Maybe
						{
							// if we reach here, neither fname nor lname is null!
							// so we have achieved lazy evaluation in Actionscript
							return just(fname + " " + lname);
						}
					);
				}
			);
		}
		
		/*
		* generalizing the structure of our first version of fullname(),
		* we have written the function liftM2(),
		* which 'lifts' a function of type a -> b -> c (i.e. a function of two base-type arguments returning a base-type argument)
		* into a function of type m a -> m b -> m c (a function taking and returning the corresponding types wrapped in a monad).
		* we can now express fullName() more simply:
		*/
		
		public function fullName2(id:uint):Maybe
		{
			// joinNames :: String -> String -> String
			function joinNames(first:String, last:String):String { return first + " " + last; }
			
			// liftM2 :: (Monad m) => (a -> b -> c) -> m -> m a -> m b -> m c
			
			// liftM2(joinNames, Maybe) :: Maybe String -> Maybe String -> Maybe String
			return liftM2(joinNames, Maybe)(firstName(id), lastName(id));
			
			// Question: Is this lazy?
		}
	}
}
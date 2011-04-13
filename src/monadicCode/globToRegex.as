package monadicCode
{
	import com.nodename.fakeHaskell.monad.logger.Logger;

	public function globToRegex(cs:String):Logger
	{
		function lambda(ds:String):Logger
		{
			return Logger.mReturn('^' + ds);
		}
		
		return globToRegexPrime(cs).bind(lambda);
	}
	
	/*
	in Haskell we'd define globToRegex like this:
	
	globToRegex cs =
		globToRegex' cs >>= \ds ->
		return ('^':ds)
	
	*/
}
import com.nodename.fakeHaskell.monad.liftM;
import com.nodename.fakeHaskell.monad.logger.Logger;

function globToRegexPrime(cs:String):Logger
{
	if (cs == "")
	{
		return Logger.mReturn("$");
	}
	
	const firstChar:String = cs.charAt(0);
	cs = cs.slice(1);
	
	switch (firstChar)
	{
		case '?':
			const dotBound:Function = function():Logger
			{
				function lambda(ds:String):Logger { return Logger.mReturn('.' + ds); }
				return globToRegexPrime(cs).bind(lambda);
			}
			return Logger.record("any").chain(dotBound);
			break;
		case '*':
			const dotStarBound:Function = function():Logger
			{
				function lambda(ds:String):Logger { return Logger.mReturn('.*' + ds); }
				return globToRegexPrime(cs).bind(lambda);
			}
			return Logger.record("kleene star").chain(dotStarBound);
			break;
		case '[':
			if (cs == "")
			{
				fail("unterminated character class");
				return null;
			}
			const secondChar:String = cs.charAt(0);
			cs = cs.slice(1);
			
			switch (secondChar)
			{
				case '!':
					const thirdChar:String = cs.charAt(0);
					cs = cs.slice(1);
					const negativeLambda:Function = function(ds:String):Logger { return Logger.mReturn("[^" + thirdChar + ds); };
					return Logger.record("character class (negative)").chain(function():Logger { return charClass(cs).bind(negativeLambda); });
					break;
				default:
					const lambda:Function = function(ds:String):Logger { return Logger.mReturn("[" + secondChar + ds); };
					return Logger.record("character class").chain(function():Logger { return charClass(cs).bind(lambda); });
					break;
			}
			break;
		default:
			return null;
			break;
	}
}

function charClass(cs:String):Logger
{
	const firstChar:String = cs.charAt(0);
	cs = cs.slice(1);
	
	// lambda :: String -> Logger String
	const lambda:Function = function(ds:String):Logger { return Logger.mReturn(firstChar + ds); };
	
	switch (firstChar)
	{
		case ']':
			return globToRegexPrime(cs).bind(lambda);
			break;
		default:
			return charClass(cs).bind(lambda);
			break;
	}
}

/*
Now we use liftM to rewrite charClass() without inner functions and bind:
*/

function prepend(c:String):Function
{
	return function(cs:String):String { return c + cs; };
}

function charClass2(cs:String):Logger
{
	const firstChar:String = cs.charAt(0);
	cs = cs.slice(1);
	
	switch (firstChar)
	{
		case ']':
			return liftM(prepend(']'), Logger)(globToRegexPrime(cs));
			break;
		default:
			return liftM(prepend(firstChar), Logger)(charClass(cs));
			break;
	}
}

function fail(message:String):void
{
	throw new Error(message);
}
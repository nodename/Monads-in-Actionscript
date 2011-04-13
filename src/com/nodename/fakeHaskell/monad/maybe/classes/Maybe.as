package com.nodename.fakeHaskell.monad.maybe.classes
{
	public class Maybe
	{
		// This function is called "return" in Haskell
		// (not a great choice, but that's what it's called).
		// It wraps the value in the monad.
		public static function mReturn(value:*):Maybe
		{
			return new Just(value);
		}
		
		// The only way to get a value out of a monad is via a function provided by the monad.
		// The Maybe monad provides fromJust() and fromMaybe().
		
		public static function fromJust(m:Maybe):*
		{
			if (m is Nothing)
			{
				throw new Error("Maybe.fromJust: Nothing");
			}
			return m._value;
		}
		
		// originally implemented as a static function to match Haskell syntax
		public function fromMaybe(defaultValue:*):*
		{
			throw new Error("Maybe::fromMaybe(): abstract function");
		}
		
		// this is just a way of keeping outsiders from calling the constructor directly
		// (an AS3 implementation detail; nothing to do with the monad):
		protected static const LOCK:Object = {};
		
		protected var _value:*;
		
		public function Maybe(lock:Object, value:*)
		{
			if (lock != LOCK)
			{
				throw new Error("Maybe: invalid constructor access");
			}
			_value = value;
		}

		// this is the >>= operator in Haskell
		// f :: * -> Maybe
		public function bind(f:Function):Maybe
		{
			throw new Error("Maybe::bind(): abstract function");
		}
		
		// convenience function, not in Haskell
		public function bindMember(f:String):Maybe
		{
			throw new Error("Maybe::bindMember(): abstract function");
		}
		
		// convenience function, not in Haskell
		// booleanCondition :: * -> Boolean
		public function mIf(booleanCondition:Function):Maybe
		{
			throw new Error("Maybe::mIf(): abstract function");
		}
		
		public function toString():String
		{
			throw new Error("Maybe::toString(): abstract function");
		}
	}
}
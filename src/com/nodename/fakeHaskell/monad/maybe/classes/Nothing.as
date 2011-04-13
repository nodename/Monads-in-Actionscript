package com.nodename.fakeHaskell.monad.maybe.classes
{
	public final class Nothing extends Maybe
	{
		public static const NOTHING:Nothing = new Nothing(LOCK);
		
		public function Nothing(lock:Object)
		{
			super(lock, undefined);
		}

		override public function fromMaybe(defaultValue:*):*
		{
			return defaultValue;
		}
		
		// No matter what function f we bind to Nothing, we always get Nothing in return:
		override public function bind(f:Function):Maybe
		{
			// f :: * -> Maybe
			return NOTHING;
		}
		
		override public function bindMember(f:String):Maybe
		{
			return NOTHING;
		}

		// convenience function, not in Haskell
		// booleanCondition :: * -> Boolean
		override public function mIf(booleanCondition:Function):Maybe
		{
			return NOTHING;
		}

		override public function toString():String
		{
			return "Nothing";
		}
	}
}
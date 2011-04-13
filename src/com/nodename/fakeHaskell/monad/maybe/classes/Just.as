package com.nodename.fakeHaskell.monad.maybe.classes
{
	import com.nodename.fakeHaskell.monad.maybe.NOTHING;

	public final class Just extends Maybe
	{
		public function Just(value:*)
		{
			super(LOCK, value);
		}
		
		// f :: * -> Maybe
		override public function bind(f:Function):Maybe
		{
			return f(_value);
		}
		
		// convenience function not in Haskell
		override public function bindMember(f:String):Maybe
		{
			const member:* = _value[f];
			var newValue:*;
			
			if (member == null)
			{
				newValue = null;
			}
			else if (member is Function)
			{
				newValue = member();
			}
			else
			{
				newValue = member;
			}
			return newValue == null ? NOTHING : new Just(newValue);
		}

		// convenience function not in Haskell
		// booleanCondition :: * -> Boolean
		override public function mIf(booleanCondition:Function):Maybe
		{
			return booleanCondition(_value) ? this : NOTHING;
		}
		
		override public function fromMaybe(defaultValue:*):*
		{
			return _value;
		}
		
		override public function toString():String
		{
			const quote:String = _value is String ? '"' : '';
			return "Just " + quote + _value + quote;
		}
	}
}
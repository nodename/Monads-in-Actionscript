package test
{
	import test.maybe.safeDivideTest;

	public function theMaybeMonad():void
	{
		/*
		* The Maybe monad has two constructors, Just(a) and Nothing.
		* (We implement them as derived classes in Actionscript but that's not what they are in Haskell.)
		* But the monad itself does not specify when to invoke Just and when to invoke Nothing.
		* We'll explore two different rules we can use to make this choice:
		*/
		
		partOne_WhatTypeIsNull();
		partTwo_GoAhead_DivideByZero();
	}
}

import test.maybe.a_NullSafe_Fluent_Interface;
import test.maybe.A_NullSafe_Monadic_Service_Class;
import test.maybe.safeDivideTest;

function partOne_WhatTypeIsNull():void
{
	/*
	* A peculiarity of most if not all of our imperative languages is that types include,
	* in addition to all their valid values, the "exceptional" out-of-band value null, which we are
	* constantly testing for as a special case.
	* 
	* For these demonstrations we choose maybeFromObject(a) as our constructor rule for Maybe:
	* it will produce Nothing when a is null, and otherwise Just a.
	*/
	
	A_NullSafe_Monadic_Service_Class();
	a_NullSafe_Fluent_Interface();
}

function partTwo_GoAhead_DivideByZero():void
{
	/* 
	* In our safeDivide() function, of course, we are producing Nothing when the bare result would have been
	* a division by zero. We are integrating "exceptional" cases into our monadic type system.
	*/
	
	safeDivideTest();
}
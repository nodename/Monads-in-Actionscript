// Based on http://www.codeproject.com/KB/cs/maybemonads.aspx

/*
In this example we use the Maybe monad to build a null-safe fluent interface 
to some value objects that know nothing of monads.
*/

package test.maybe
{
	import test.vo.Address;
	import test.vo.Person;
	import com.nodename.fakeHaskell.monad.maybe.classes.Maybe;
	import com.nodename.fakeHaskell.monad.maybe.classes.Nothing;
	import com.nodename.fakeHaskell.monad.maybe.maybe;
	import com.nodename.fakeHaskell.monad.maybe.maybeFromObject;
	
	public function a_NullSafe_Fluent_Interface():void
	{
		const person1:Person = new Person(/* hasMedicalRecord: */ true, new Address("94103"));
		const person2:Person = new Person(/* hasMedicalRecord: */ false, new Address("10023"));
		const person3:Person = new Person();
		
		// getAddressPostCode :: Address -> Maybe String
		function getAddressPostCode(address:Address):Maybe { return maybeFromObject(address.postCode); }
		
		/*
		* Here's our first fluent interface solution.
		* At each step I note the expected return type.
		* Since we can't parameterize the Maybe type in Actionscript,
		* we won't get any error reports from the compiler if the types don't match up properly from step to step.
		*/
		function getPersonPostCode1(person:Person):String
		{
			return maybeFromObject(person.address)	//	-> Maybe Address
				.bind(getAddressPostCode)			//	-> Maybe String
				.fromMaybe("NONE");					//	-> String
		}
		
		// Note that in our first step we wrap the value in the Maybe monad
		// and we unwrap it only at the end of our chain of computations.
		
		// In the intervening step(s) we apply a function that takes an object of a Maybe type
		// and returns an object of the same or another Maybe type.
		
		// That function is bind(getAddressPostCode).
		// getAddressPostCode itself has the type Address -> Maybe String,
		// and bind() turns it into a function of type Maybe Address -> Maybe String.
		
		// We need a function of type M a -> M b to put into our chain;
		// so what do we gain by writing a function of type a -> M b like getAddressPostCode?
		// Well, we know it's going to be bound, so we don't have to take an argument of type M a,
		// and we won't be tempted to try unwrapping the monad in our function;
		// this would be a bad idea anyway because the monad wrapper is there
		// specifically to keep our minds off whether the "a" inside is null or not.
		// getAddressPostCode never has to check whether its argument is null.
		
		
			// no way to tell where in the chain the value became null
		
		
		// We're purposely breaking out of the monad in our side effect,
		// where we print out the postCode, which might be null.
		// We could never do this in Haskell without using the IO Monad!
		
		// sideEffect :: Address -> Maybe Address
		function sideEffect(address:Address):Maybe { trace("the value is", address.postCode); return maybeFromObject(address); }
		
		function getPersonPostCode2(person:Person):String
		{
			return maybeFromObject(person.address)
				.bind(sideEffect)
				.bind(getAddressPostCode)
				.fromMaybe("NONE");
		}
		
		function getPersonPostCode3(person:Person):String
		{
			return maybeFromObject(person.address)
				.bind(sideEffect)
				.bindMember("postCode")
				.fromMaybe("NONE");
		}
		
		function hasRecord(person:Person):Boolean { return person.hasMedicalRecord; }
		
		function getPersonPostCode4(person:Person):String
		{
			return maybeFromObject(person)
				.mIf(hasRecord)
				.bindMember("address")
				.bind(sideEffect)
				.bindMember("postCode")
				.fromMaybe("NONE");
		}
		
		trace(getPersonPostCode4(person1));
		trace(getPersonPostCode4(person2));
		trace(getPersonPostCode4(person3));
		
	}
}

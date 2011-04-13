package test.maybe
{
	public function A_NullSafe_Monadic_Service_Class():void
	{
		for (var id:uint = 0; id < 4; id++)
		{
			testDatabaseAccess(id);
		}
	}
}

import com.nodename.fakeHaskell.monad.maybe.classes.Maybe;
import monadicCode.DatabaseAccess;

function testDatabaseAccess(id:uint):void
{
	const databaseAccess:DatabaseAccess = new DatabaseAccess();
	
	const firstName:Maybe = databaseAccess.firstName(id);
	trace("firstName:", firstName);
	trace("\n\n");
	
	const lastName:Maybe = databaseAccess.lastName(id);
	trace("lastName:", lastName);
	trace("\n\n");
	
	const fullName:Maybe = databaseAccess.fullName(id);
	trace("fullName:", fullName);
	trace("\n\n");
	
	const fullName2:Maybe = databaseAccess.fullName2(id);
	trace("fullName2:", fullName2 + "\n");
	trace("\n\n");
}
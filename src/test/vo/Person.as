package test.vo
{
	public class Person
	{
		private var _address:Address;
		public function get address():Address { return _address; }
		
		private var _hasMedicalRecord:Boolean;
		public function get hasMedicalRecord():Boolean { return _hasMedicalRecord; }
		
		public function Person(hasMedicalRecord:Boolean=true, address:Address=null)
		{
			_hasMedicalRecord = hasMedicalRecord;
			_address = address;
		}
	}
}
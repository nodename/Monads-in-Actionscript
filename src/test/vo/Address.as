package test.vo
{
	public class Address
	{
		private var _postCode:String;
		public function get postCode():String { return _postCode; }
		
		public function Address(postCode:String=null)
		{
			_postCode = postCode;
		}
	}
}
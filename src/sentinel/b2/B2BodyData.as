package sentinel.b2
{
	
	import sentinel.base.Thing;
	
	
	public class B2BodyData
	{
		
		private var _body:B2Body;
		private var _owner:Thing;
		
		
		public function B2BodyData(body:B2Body)
		{
			_body = body;
		}
		
		
		public function get body():B2Body { return _body; }
		
		
		internal function get owner():Thing { return _owner; }
		internal function set owner(value:Thing):void { _owner = value; }
		
	}
	
}
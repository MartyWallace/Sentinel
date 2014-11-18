package sentinel.framework.b2
{
	
	/**
	 * Holds properties that define a <code>B2World</code>, like gravity.
	 * @author Marty Wallace.
	 */
	public class B2WorldDef
	{
		
		private var _gravity:B2Vector2D;
		private var _sleep:Boolean = false;
		private var _velocityIterations:int = 14;
		private var _positionIterations:int = 14;
		
		
		/**
		 * Constructor.
		 * 
		 * @param gravity Gravity values for the physics world.
		 * @param sleep Whether or not the world will attempt to put objects to sleep.
		 * @param velocityIterations The number of iterations used to smooth out velocities. Higher values are slower but give more accurate results.
		 * @param positionIterations The number of iterations used to smooth out positions. Higher values are slower by give more accurate results.
		 */
		public function B2WorldDef(gravity:B2Vector2D, sleep:Boolean = false, velocityIterations:int = 14, positionIterations:int = 14)
		{
			_gravity = gravity;
			_sleep = sleep;
			_velocityIterations = velocityIterations;
			_positionIterations = positionIterations;
		}
		
		
		public function get gravity():B2Vector2D { return _gravity; }
		public function get sleep():Boolean{ return _sleep; }
		public function get velocityIterations():int{ return _velocityIterations; }
		public function get positionIterations():int{ return _positionIterations; }
		
	}
	
}
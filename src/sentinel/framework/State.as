package sentinel.framework
{
	
	import sentinel.framework.graphics.IGraphicsContainer;
	import sentinel.framework.graphics.Sprite;
	
	
	/**
	 * A State is used to define a game state e.g. the main menu, settings screen, game over screen,
	 * the gameplay itself, etc.
	 * @author Marty Wallace.
	 */
	public class State extends Thing
	{
		
		private var _graphics:IGraphicsContainer;
		
		
		public function State()
		{
			super();
			
			_graphics = new Sprite();
		}
		
		
		public override function deconstruct():void
		{
			_graphics.deconstruct();
			
			super.deconstruct();
		}
		
		
		/**
		 * The graphics container representing this State visually.
		 */
		public function get graphics():IGraphicsContainer { return _graphics; }
		
		
		/**
		 * Provides a solid background color for this State.
		 */
		public function get backgroundColor():uint { return 0xFFFFFF; }
		
		/**
		 * Provides background music for this State.
		 */
		protected function get backgroundMusic():String { return null; }
		
		/**
		 * @private
		 */
		internal function get __backgroundMusic():String { return backgroundMusic; }
		
	}
	
}
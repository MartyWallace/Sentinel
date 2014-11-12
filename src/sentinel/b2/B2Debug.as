package sentinel.b2
{
	
	import flash.display.Sprite;
	import Box2D.Dynamics.b2DebugDraw;
	import sentinel.base.Game;
	import sentinel.base.IDeconstructs;
	
	
	/**
	 * Defines and encapsulates debug drawing for Box2D.
	 * 
	 * @author Marty Wallace.
	 */
	public class B2Debug implements IDeconstructs
	{
		
		public static const AABB:int = b2DebugDraw.e_aabbBit;
		public static const CENTER_OF_MASS:int = b2DebugDraw.e_centerOfMassBit;
		public static const CONTROLLER:int = b2DebugDraw.e_controllerBit;
		public static const JOINT:int = b2DebugDraw.e_jointBit;
		public static const PAIR:int = b2DebugDraw.e_pairBit;
		public static const SHAPE:int = b2DebugDraw.e_shapeBit;
		
		
		private var _game:Game;
		private var _base:b2DebugDraw;
		private var _graphics:Sprite;
		
		
		/**
		 * Constructor.
		 * 
		 * @param game A reference to the core Game class.
		 * @param lineThickness Line thickness of debug graphics.
		 * @param lineAlpha Line alpha of debug graphics.
		 * @param fillAlpha Fill alpha of debug graphics.
		 * @param flags List of drawing flags. If null or empty, <code>B2Debug.SHAPE</code> will be used.
		 */
		public function B2Debug(game:Game, lineThickness:int = 1, lineAlpha:Number = 1, fillAlpha:Number = 0.2, flags:Vector.<int> = null)
		{
			_game = game;
			
			_graphics = new Sprite();
			_base = new b2DebugDraw();
			
			_base.SetSprite(_graphics);
			_base.SetDrawScale(B2World.scale);
			_base.SetLineThickness(lineThickness);
			_base.SetAlpha(lineAlpha);
			_base.SetFillAlpha(fillAlpha);
			
			if (flags !== null && flags.length > 0)
			{
				for each(var i:int in flags)
				{
					_base.AppendFlags(i);
				}
			}
			else
			{
				_base.AppendFlags(B2Debug.SHAPE);
			}
			
			game.starling.nativeOverlay.addChild(_graphics);
		}
		
		
		public function deconstruct():void
		{
			_graphics.parent && _graphics.parent.removeChild(_graphics);
		}
		
		
		/**
		 * The native Sprite used to render the debug graphics.
		 */
		public function get graphics():Sprite { return _graphics; }
		
		/**
		 * The base b2DebugDraw instance wrapped by this class.
		 */
		public function get base():b2DebugDraw { return _base; }
		
	}
	
}
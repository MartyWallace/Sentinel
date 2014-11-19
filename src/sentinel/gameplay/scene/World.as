package sentinel.gameplay.scene
{
	
	import sentinel.framework.b2.B2Debug;
	import sentinel.framework.b2.B2World;
	import sentinel.framework.b2.B2WorldDef;
	import sentinel.framework.graphics.IGraphicsContainer;
	import sentinel.framework.graphics.Sprite;
	import sentinel.framework.Thing;
	import sentinel.gameplay.states.GameplayState;
	import sentinel.gameplay.ui.UI;
	
	
	public class World extends Thing
	{
		
		private var _physics:B2World;
		private var _camera:Camera;
		private var _frozen:Boolean = false;
		private var _graphics:IGraphicsContainer;
		private var _content:Sprite;
		private var _ticks:uint = 0;
		
		
		public function World(definition:B2WorldDef = null, debug:B2Debug = null)
		{
			if (definition !== null)
			{
				_physics = new B2World(definition, debug);
			}
			
			_graphics = new Sprite();
			_content = new Sprite();
			_camera = new Camera(this);
			
			_graphics.addChild(_content);
		}
		
		
		public override function deconstruct():void
		{
			if (_physics !== null)
			{
				_physics.deconstruct();
			}
			
			_graphics.deconstruct();
			
			super.deconstruct();
		}
		
		
		public override function update():void
		{
			if (!_frozen)
			{
				_ticks ++;
				
				if (_physics !== null) _physics.update();
				
				super.update();
			}
		}
		
		
		/**
		 * Adds a Being to this World.
		 * @param being The Being to add.
		 */
		public function add(being:Being):Being
		{
			return addT(being) as Being;
		}
		
		
		/**
		 * Removes a Being from this World.
		 * @param being The Being to remove.
		 * @param destroy Whether or not to also deconstruct the Being once removed.
		 */
		public function remove(being:Being, destroy:Boolean = false):Being
		{
			return removeT(being, destroy) as Being;
		}
		
		
		protected final override function added(thing:Thing):void
		{
			if (!(thing is GameplayState)) throw new Error("World can only be added to GameplayState.");
		}
		
		
		protected final override function removed(thing:Thing):void
		{
			if (!(thing is GameplayState)) throw new Error("World can only be removed from GameplayState.");
		}
		
		
		
		public function get ui():UI { return (parent as GameplayState).ui }
		public function get physics():B2World { return _physics; }
		public function get graphics():IGraphicsContainer { return _graphics; }
		public function get camera():Camera { return _camera; }
		public function get frozen():Boolean { return _frozen; }
		public function set frozen(value:Boolean):void { _frozen = value; }
		public function get ticks():uint { return _ticks; }
		public function get totalBeings():int { return children.length; }
		
		internal function get __content():Sprite { return _content; }
		
	}
	
}
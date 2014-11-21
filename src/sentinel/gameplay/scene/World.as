package sentinel.gameplay.scene
{
	
	import sentinel.framework.graphics.IGraphicsContainer;
	import sentinel.framework.graphics.Sprite;
	import sentinel.framework.Thing;
	import sentinel.framework.util.ObjectUtil;
	import sentinel.gameplay.physics.Debug;
	import sentinel.gameplay.physics.Engine;
	import sentinel.gameplay.physics.EngineDef;
	import sentinel.gameplay.states.GameplayState;
	import sentinel.gameplay.ui.UI;
	
	
	/**
	 * The World is the core class for dealing with collections of Beings and the interactions
	 * between those Beings.
	 * @author Marty Wallace.
	 */
	public class World extends Thing
	{
		
		private var _engine:Engine;
		private var _camera:Camera;
		private var _frozen:Boolean = false;
		private var _graphics:IGraphicsContainer;
		private var _content:Sprite;
		private var _ticks:uint = 0;
		
		
		public function World(definition:EngineDef = null, debug:Debug = null)
		{
			if (definition !== null)
			{
				_engine = new Engine(definition, debug);
			}
			
			_graphics = new Sprite();
			_content = new Sprite();
			_camera = new Camera(this);
			
			_graphics.addChild(_content);
		}
		
		
		public override function deconstruct():void
		{
			if (_engine !== null)
			{
				_engine.deconstruct();
			}
			
			_graphics.deconstruct();
			
			super.deconstruct();
		}
		
		
		public override function save():Object
		{
			var beings:Array = [];
			
			for each(var thing:Thing in children)
			{
				if (thing is Being)
				{
					var data:Object = thing.save();
					
					if (data !== null)
					{
						// Only save objects who return actual data for save(). This provides the
						// opportunity to return null from save() on Beings that shouldn't be added
						// to the save data e.g. particles, effects, bullets, etc.
						beings.push(data);
					}
				}
			}
			
			return ObjectUtil.merge({
				beings: beings
			});
		}
		
		
		public override function load(data:Object):void
		{
			super.load(data);
			
			if (data.hasOwnProperty('beings'))
			{
				for each(var def:Object in data.beings)
				{
					if (def.hasOwnProperty('type'))
					{
						var being:Being = Being.createFromSave(def.type, def);
						add(being);
					}
				}
			}
		}
		
		
		protected override function update():void
		{
			if (!_frozen)
			{
				_ticks ++;
				
				if (_engine !== null) _engine.step();
				
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
		
		
		/**
		 * Returns a list of Beings who are of the specified type.
		 * @param type The type of Beings to get.
		 */
		public function getBeingsByType(type:Class):Vector.<Being>
		{
			var output:Vector.<Being> = new <Being>[];
			for each(var thing:Thing in children)
			{
				if (thing is type)
				{
					output.push(thing);
				}
			}
			
			return output;
		}
		
		
		
		public function get ui():UI { return (parent as GameplayState).ui }
		public function get engine():Engine { return _engine; }
		public function get graphics():IGraphicsContainer { return _graphics; }
		public function get camera():Camera { return _camera; }
		public function get frozen():Boolean { return _frozen; }
		public function set frozen(value:Boolean):void { _frozen = value; }
		public function get ticks():uint { return _ticks; }
		public function get totalBeings():int { return children.length; }
		
		internal function get __content():Sprite { return _content; }
		
	}
	
}
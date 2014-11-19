package sentinel.gameplay.physics
{
	
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2World;
	import sentinel.framework.IDeconstructs;
	import sentinel.framework.Thing;
	
	
	/**
	 * Wrapper for Box2D.Dynamics.b2World.
	 * @author Marty Wallace.
	 */
	public class Engine implements IDeconstructs
	{
		
		private static var _scale:int = 30;
		
		
		/**
		 * The pixel to metre scaling ratio.
		 */
		public static function get scale():int { return _scale; }
		public static function set scale(value:int):void { _scale = value; }
		
		
		private var _base:b2World;
		private var _def:EngineDef;
		private var _debug:Debug;
		private var _destroyed:Vector.<Body> = new <Body>[];
		
		
		/**
		 * Constructor.
		 * 
		 * @param def An optional world definition.
		 * @param debug An optional debug definition.
		 */
		public function Engine(def:EngineDef = null, debug:Debug = null)
		{
			_def = def === null ? new EngineDef(new Vector2D()) : def;
			_base = new b2World(_def.gravity.base, _def.sleep);
			_debug = debug;
			
			if (debug !== null)
			{
				_base.SetDebugDraw(debug.base);
			}
			
			_base.SetContactListener(new ContactListener());
		}
		
		
		public function deconstruct():void
		{
			if (_debug !== null)
			{
				_debug.deconstruct();
				_debug = null;
			}
			
			for each(var body:Body in bodies)
			{
				body.deconstruct();
			}
			
			// Update is required to iterate over the destroyed bodies above and actually
			// destroy them.
			step();
			
			// TODO: Anything with forces? Etc?
			// ...
		}
		
		
		/**
		 * Creates a new B2Body within this world.
		 * @param type The body type. Defaults to B2Body.DYNAMIC.
		 * @param owner An optional owner of the B2Body.
		 * @return The new B2Body.
		 */
		public function createBody(type:int = 2, owner:Thing = null):Body
		{
			var def:b2BodyDef = new b2BodyDef();
			def.type = type;
			
			var baseBody:b2Body = _base.CreateBody(def);
			
			return new Body(this, baseBody, def, owner);
		}
		
		
		internal function __destroyBody(body:Body):void
		{
			if(_destroyed.indexOf(body) < 0) _destroyed.push(body);
		}
		
		
		public function step():void
		{
			while (_destroyed.length > 0)
			{
				var d:Body = _destroyed.pop();
				_base.DestroyBody(d.base);
				
				d.deconstruct();
			}
			
			_base.Step(1 / 60, _def.velocityIterations, _def.positionIterations);
			_base.ClearForces();
			
			if (_debug !== null)
			{
				_base.DrawDebugData();
			}
		}
		
		
		public function get bodies():Vector.<Body>
		{
			var result:Vector.<Body> = new <Body>[];
			var start:b2Body = _base.GetBodyList();
			
			while (start !== null)
			{
				if (start.GetUserData() !== null && start.GetUserData() is BodyData)
				{
					result.push((start.GetUserData() as BodyData).body);
				}
				
				start = start.GetNext();
			}
			
			return result;
		}
		
		
		public function get base():b2World{ return _base; }
		public function get sleeps():Boolean{ return _def.sleep; }
		public function get gravity():Vector2D { return _def.gravity; }
		public function get debug():Debug { return _debug; }
		public function get debugging():Boolean { return _debug !== null; }
		public function get totalBodies():int { return _base.GetBodyCount(); }
		
	}
	
}
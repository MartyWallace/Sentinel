package sentinel.gameplay.physics
{
	
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	import starling.events.EventDispatcher;
	import sentinel.framework.Thing;
	import sentinel.framework.IDeconstructs;
	import Box2D.Dynamics.Contacts.b2Contact;
	
	
	public class Body extends EventDispatcher implements IDeconstructs
	{
		
		public static const STATIC:int = b2Body.b2_staticBody;
		public static const DYNAMIC:int = b2Body.b2_dynamicBody;
		public static const KINEMATIC:int = b2Body.b2_kinematicBody;
		
		
		private var _base:b2Body;
		private var _engine:Engine;
		private var _def:b2BodyDef;
		private var _data:BodyData;
		private var _position:Vector2D;
		private var _fixtures:Vector.<Fixture>;
		private var _linearVelocity:Vector2D;
		private var _internalForce:Vector2D;
		
		
		public function Body(engine:Engine, body:b2Body, def:b2BodyDef, owner:Thing)
		{
			_base = body;
			_def = def;
			_engine = engine;
			_data = new BodyData(this, owner);
			_position = new Vector2D();
			_fixtures = new <Fixture>[];
			_linearVelocity = new Vector2D();
			_internalForce = new Vector2D();
			
			_base.SetUserData(_data);
		}
		
		
		public function deconstruct():void
		{
			if (_engine !== null)
			{
				destroy();
			}
			
			destroyAllFixtures();
			removeEventListeners();
			
			// TODO: More?
			// ...
		}
		
		
		public function destroy():void
		{
			if (_engine !== null)
			{
				_engine.__destroyBody(this);
				_engine = null;
				
				deconstruct();
			}
		}
		
		
		public function createFixture(shape:Shape, fixtureDef:FixtureDef = null):Fixture
		{
			var nativeFixtureDef:b2FixtureDef = new b2FixtureDef();
			nativeFixtureDef.shape = shape.__base;
			
			if (fixtureDef !== null)
			{
				nativeFixtureDef.density = fixtureDef.density;
				nativeFixtureDef.friction = fixtureDef.friction;
				nativeFixtureDef.restitution = fixtureDef.restitution;
			}
			
			var nativeFixture:b2Fixture = _base.CreateFixture(nativeFixtureDef);
			var fixture:Fixture = new Fixture(nativeFixture);
			
			_fixtures.push(fixture);
			
			
			return fixture;
		}
		
		
		public function destroyFixture(fixture:Fixture):void
		{
			var i:int = _fixtures.indexOf(fixture);
			
			if (i >= 0)
			{
				_fixtures.splice(i, 1);
				_base.DestroyFixture(fixture.__base);
			}
		}
		
		
		public function destroyAllFixtures():void
		{
			while (_fixtures.length > 0)
			{
				var f:Fixture = _fixtures.pop();
				_base.DestroyFixture(f.__base);
			}
		}
		
		
		public function moveTo(x:Number, y:Number):void
		{
			_position.x = x;
			_position.y = y;
			
			_base.SetPosition(_position.__base);
		}
		
		
		internal function get __base():b2Body { return _base; }
		
		public function get engine():Engine { return _engine; }
		public function get owner():Thing{ return _data.owner }
		public function get fixtures():Vector.<Fixture> { return _fixtures; }
		public function get totalFixtures():int { return _fixtures.length; }
		
		public function get awake():Boolean{ return _base.IsAwake(); }
		public function set awake(value:Boolean):void{ _base.SetAwake(value); }
		
		public function get isBullet():Boolean{ return _base.IsBullet(); }
		public function set isBullet(value:Boolean):void{ _base.SetBullet(value); }
		
		public function get rotation():Number{ return _base.GetAngle(); }
		public function set rotation(value:Number):void{ _base.SetAngle(value); }
		
		public function get fixedRotation():Boolean{ return _base.IsFixedRotation(); }
		public function set fixedRotation(value:Boolean):void{ _base.SetFixedRotation(value); }
		
		public function get angularDamping():Number{ return _base.GetAngularDamping(); }
		public function set angularDamping(value:Number):void{ _base.SetAngularDamping(value); }
		
		public function get linearDamping():Number{ return _base.GetLinearDamping(); }
		public function set linearDamping(value:Number):void{ _base.SetLinearDamping(value); }
		
		public function get linearVelocity():Vector2D { return _linearVelocity; }
		
		public function set linearVelocity(value:Vector2D):void
		{
			if (!value.isZero)
			{
				linearVelocityX = value.x;
				linearVelocityY = value.y;
			}
		}
		
		public function get angularVelocity():Number{ return _base.GetAngularVelocity(); }
		
		public function set angularVelocity(value:Number):void
		{
			_base.SetAngularVelocity(value);
			_base.SetAwake(true);
		}
		
		
		public function get linearVelocityX():Number{ return _base.GetLinearVelocity().x * Engine.scale; }
		
		public function set linearVelocityX(value:Number):void
		{
			_linearVelocity.x = value;
			_linearVelocity.y = _base.GetLinearVelocity().y * Engine.scale;
			_base.SetLinearVelocity(_linearVelocity.__base);
			_base.SetAwake(true);
		}
		
		public function get linearVelocityY():Number{ return _base.GetLinearVelocity().y * Engine.scale; }
		
		public function set linearVelocityY(value:Number):void
		{
			_linearVelocity.y = value;
			_linearVelocity.x = _base.GetLinearVelocity().x * Engine.scale;
			_base.SetLinearVelocity(_linearVelocity.__base);
			_base.SetAwake(true);
		}
		
		
		/**
		 * Returns the position of this Body. Modifying the <code>x</code> or <code>y</code> values
		 * of the result will not affect this Body, use <code>moveTo()</code> instead.
		 */
		public function get position():Vector2D
		{
			_position.x = _base.GetPosition().x * Engine.scale;
			_position.y = _base.GetPosition().y * Engine.scale;
			
			return _position;
		}
		
	}
	
}
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
	
	
	public class Body extends EventDispatcher implements IDeconstructs
	{
		
		public static const STATIC:int = b2Body.b2_staticBody;
		public static const DYNAMIC:int = b2Body.b2_dynamicBody;
		public static const KINEMATIC:int = b2Body.b2_kinematicBody;
		
		
		private var _base:b2Body;
		private var _world:Engine;
		private var _def:b2BodyDef;
		private var _data:BodyData;
		private var _position:Vector2D;
		private var _fixtures:Vector.<Fixture>;
		private var _linearVelocity:Vector2D;
		private var _internalForce:Vector2D;
		
		
		/**
		 * Internal - Use <code>B2World.createBody()</code>.
		 */
		public function Body(world:Engine, body:b2Body, def:b2BodyDef, owner:Thing)
		{
			_base = body;
			_def = def;
			_world = world;
			_data = new BodyData(this, owner);
			_position = new Vector2D();
			_fixtures = new <Fixture>[];
			_linearVelocity = new Vector2D();
			_internalForce = new Vector2D();
			
			_base.SetUserData(_data);
		}
		
		
		public function deconstruct():void
		{
			if (_world !== null)
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
			if (_world !== null)
			{
				_world.__destroyBody(this);
				_world = null;
				
				deconstruct();
			}
		}
		
		
		public function createFixture(shape:IShape, fixtureDef:FixtureDef = null):Fixture
		{
			var nativeFixtureDef:b2FixtureDef = new b2FixtureDef();
			nativeFixtureDef.shape = shape.base;
			
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
				_base.DestroyFixture(fixture.base);
			}
		}
		
		
		public function destroyAllFixtures():void
		{
			while (_fixtures.length > 0)
			{
				var f:Fixture = _fixtures.pop();
				_base.DestroyFixture(f.base);
			}
		}
		
		
		public function get base():b2Body { return _base; }
		public function get world():Engine { return _world; }
		public function get owner():Thing{ return _data.owner }
		
		public function get fixtures():Vector.<Fixture> { return _fixtures; }
		public function get numFixtures():int { return _fixtures.length; }
		
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
		
		public function get linearVelocity():Vector2D{ return _linearVelocity; }
		public function set linearVelocity(value:Vector2D):void { _linearVelocity = value; }
		
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
			_base.SetLinearVelocity(_linearVelocity.base);
			_base.SetAwake(true);
		}
		
		public function get linearVelocityY():Number{ return _base.GetLinearVelocity().y * Engine.scale; }
		
		public function set linearVelocityY(value:Number):void
		{
			_linearVelocity.y = value;
			_linearVelocity.x = _base.GetLinearVelocity().x * Engine.scale;
			_base.SetLinearVelocity(_linearVelocity.base);
			_base.SetAwake(true);
		}
		
		
		public function get x():Number{ return _base.GetPosition().x * Engine.scale; }
		
		public function set x(value:Number):void
		{
			_position.x = value;
			_position.y = _base.GetPosition().y * Engine.scale;
			_base.SetPosition(_position.base);
		}
		
		
		public function get y():Number{ return _base.GetPosition().y * Engine.scale; }
		
		public function set y(value:Number):void
		{
			_position.y = value;
			_position.x = _base.GetPosition().x * Engine.scale;
			_base.SetPosition(_position.base);
		}
		
	}
	
}
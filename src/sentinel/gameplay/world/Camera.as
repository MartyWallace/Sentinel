package sentinel.gameplay.world
{
	
	import sentinel.framework.BaseGame;
	import sentinel.framework.graphics.Viewport;
	import sentinel.gameplay.IPositionProvider;
	import sentinel.gameplay.physics.Vector2D;
	
	
	/**
	 * The Camera used to view a World, typically centred on the main character. It allows you to
	 * move, rotate and scale the world around a given point.
	 * @author Marty Wallace.
	 */
	public class Camera implements IPositionProvider
	{
		
		private var _world:BaseWorld;
		private var _offsetX:Number = 0;
		private var _offsetY:Number = 0;
		private var _position:Vector2D;
		private var _snap:Boolean = false;
		
		
		public function Camera(world:BaseWorld)
		{
			_world = world;
			_set(0, 0, 0, 1);
		}
		
		
		/**
		 * Move the camera ontop of a Being within the World.
		 * @param being The Being to look at.
		 * 
		 * @csharp Overloading will let us do things like lookAt(being), lookAt(vector).
		 */
		public function lookAt(being:Being):void
		{
			if (being !== null)
			{
				position = being.position;
			}
			else
			{
				// Ignore this call.
				// Being forgiving to those who potentially nullify the game character but let this
				// continue running.
			}
		}
		
		
		/**
		 * Reset the position, zoom and rotation of the camera.
		 */
		public function reset():void
		{
			_set(0, 0, 0, 1);
		}
		
		
		/**
		 * Move the Camera to the specified coordinates within the World.
		 * @param x The new x coordinate.
		 * @param y The new y coordinate.
		 */
		public function moveTo(x:Number, y:Number):void
		{
			_set(x, y, rotation, zoom);
		}
		
		
		private function _set(x:Number, y:Number, rotation:Number, zoom:Number):void
		{
			if (_snap)
			{
				x = Math.round(x);
				y = Math.round(y);
			}
			
			_world.graphics.x = viewport.width / 2 + _offsetX;
			_world.graphics.y = viewport.height / 2 + _offsetY;
			_world.graphics.rotation = -rotation;
			_world.graphics.scaleX = _world.graphics.scaleY = zoom;
			
			_world.__content.x = -x;
			_world.__content.y = -y;
			
			if (_world.engine !== null && _world.engine.debugging)
			{
				_world.engine.debug.graphics.x = _world.__content.x;
				_world.engine.debug.graphics.y = _world.__content.y;
				
				_world.engine.debug.wrapper.x = _world.graphics.x;
				_world.engine.debug.wrapper.y = _world.graphics.y;
				_world.engine.debug.wrapper.scaleX = _world.graphics.scaleX;
				_world.engine.debug.wrapper.scaleY = _world.graphics.scaleY;
				_world.engine.debug.wrapper.rotation = _world.graphics.rotation * 180 / Math.PI;
			}
		}
		
		
		/**
		 * A reference to the game Viewport service.
		 */
		public function get viewport():Viewport { return BaseGame.getInstance().viewport; }
		
		/**
		 * The position of the camera within the world along the x axis.
		 */
		public function get x():Number { return -_world.__content.x; }
		public function set x(value:Number):void{ _set(value, y, rotation, zoom); }
		
		/**
		 * The position of the camera within the world along the y axis.
		 */
		public function get y():Number { return -_world.__content.y; }
		public function set y(value:Number):void{ _set(x, value, rotation, zoom); }
		
		/**
		 * The position of the camera represented as a Vector2D instance.
		 */
		public function get position():Vector2D
		{
			_position.x = x;
			_position.y = y;
			
			return _position;
		}
		
		public function set position(value:Vector2D):void
		{
			moveTo(value.x, value.y);
		}
		
		/**
		 * The camera rotation.
		 */
		public function get rotation():Number { return -_world.graphics.rotation; }
		public function set rotation(value:Number):void { _set(x, y, value, zoom); }
		
		/**
		 * The camera zoom.
		 */
		public function get zoom():Number { return _world.graphics.scaleX; }
		public function set zoom(value:Number):void{ _set(x, y, rotation, value); }
		
		/**
		 * The camera offset along the x axis, added to the <code>x</code> value.
		 */
		public function get offsetX():Number { return _offsetX; }
		public function set offsetX(value:Number):void
		{
			_offsetX = value;
			_set(x, y, rotation, zoom);
		}
		
		/**
		 * The camera offset along the y axis, added to the <code>y</code> value.
		 */
		public function get offsetY():Number { return _offsetY; }
		public function set offsetY(value:Number):void
		{
			_offsetY = value;
			_set(x, y, rotation, zoom);
		}
		
		/**
		 * Whether or not the camera should snap to whole-pixels. Snapping to whole pixels may
		 * produce a slightly choppier appearance when moving the camera, but may supress rendering
		 * anomalies.
		 */
		public function get snap():Boolean { return _snap; }
		public function set snap(value:Boolean):void
		{
			_snap = value;
			
			if(_snap)
			{
				// Force the camera to apply snapping.
				_set(x, y, rotation, zoom);
			}
		}
		
	}
	
}
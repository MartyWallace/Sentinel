package sentinel.framework
{
	
	import starling.core.Starling;
	import starling.events.EnterFrameEvent;
	import sentinel.framework.graphics.Sprite;
	import sentinel.framework.client.Keyboard;
	import sentinel.framework.client.Mouse;
	import sentinel.framework.client.Viewport;
	
	
	public class Game extends Sprite implements IConstructs, IUpdates
	{
		
		private var _state:State;
		private var _viewport:Viewport;
		private var _keyboard:Keyboard;
		private var _mouse:Mouse;
		private var _lastId:int = 0;
		private var _ticks:uint = 0;
		
		
		public function Game()
		{
			_viewport = new Viewport(this);
			_mouse = new Mouse(this);
			_keyboard = new Keyboard(this);
			
			addEventListener(EnterFrameEvent.ENTER_FRAME, _update);
		}
		
		
		public function construct():void
		{
			//
		}
		
		
		public function loadState(state:State):void
		{
			if (_state !== null)
			{
				_state.deconstruct();
			}
			
			_state = state;
			addChild(_state.graphics);
		}
		
		
		private function _update(event:EnterFrameEvent):void
		{
			update();
			_ticks ++;
		}
		
		
		public function update():void
		{
			if (_state !== null)
			{
				_state.update();
			}
		}
		
		
		public function get starling():Starling { return Starling.current; }
		public function get state():State { return _state; }
		public function get keyboard():Keyboard{ return _keyboard; }
		public function get mouse():Mouse { return _mouse; }
		public function get ticks():uint { return _ticks; }
		public function get nextId():int { return ++_lastId; }
		
		
		public override function get viewport():Viewport{ return _viewport; }
		
	}
	
}
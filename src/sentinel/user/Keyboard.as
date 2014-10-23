package sentinel.user
{
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	import sentinel.base.Game;
	import sentinel.util.ObjectUtil;
	
	
	public class Keyboard
	{
		
		public static const NUM_0:uint = 48;
		public static const NUM_1:uint = 49;
		public static const NUM_2:uint = 50;
		public static const NUM_3:uint = 51;
		public static const NUM_4:uint = 52;
		public static const NUM_5:uint = 53;
		public static const NUM_6:uint = 54;
		public static const NUM_7:uint = 55;
		public static const NUM_8:uint = 56;
		public static const NUM_9:uint = 57;
		
		public static const F1:uint = 112;
		public static const F2:uint = 113;
		public static const F3:uint = 114;
		public static const F4:uint = 115;
		public static const F5:uint = 116;
		public static const F6:uint = 117;
		public static const F7:uint = 118;
		public static const F8:uint = 119;
		public static const F9:uint = 120;
		public static const F11:uint = 122;
		public static const F12:uint = 123;
		public static const F13:uint = 124;
		public static const F14:uint = 125;
		public static const F15:uint = 126;
		
		public static const A:uint = 65;
		public static const B:uint = 66;
		public static const C:uint = 67;
		public static const D:uint = 68;
		public static const E:uint = 69;
		public static const F:uint = 70;
		public static const G:uint = 71;
		public static const H:uint = 72;
		public static const I:uint = 73;
		public static const J:uint = 74;
		public static const K:uint = 75;
		public static const L:uint = 76;
		public static const M:uint = 77;
		public static const N:uint = 78;
		public static const O:uint = 79;
		public static const P:uint = 80;
		public static const Q:uint = 81;
		public static const R:uint = 82;
		public static const S:uint = 83;
		public static const T:uint = 84;
		public static const U:uint = 85;
		public static const V:uint = 86;
		public static const W:uint = 87;
		public static const X:uint = 88;
		public static const Y:uint = 89;
		public static const Z:uint = 90;
		
		public static const SEMICOLON:uint = 186;
		public static const PLUS:uint = 187;
		public static const DASH:uint = 189;
		public static const FORWARD_SLASH:uint = 191;
		public static const BACK_SLASH:uint = 220;
		public static const OPEN_BRACKET:uint = 219;
		public static const CLOSE_BRACKET:uint = 221;
		public static const APOSTROPHE:uint = 222;
		public static const COMMA:uint = 188;
		public static const PERIOD:uint = 190;
		public static const BACKSPACE:uint = 8;
		public static const TAB:uint = 9;
		public static const ENTER:uint = 13;
		public static const SHIFT:uint = 16;
		public static const CTRL:uint = 17;
		public static const CAPS_LOCK:uint = 20;
		public static const ESC:uint = 27;
		public static const PAGE_UP:uint = 33;
		public static const PAGE_DOWN:uint = 34;
		public static const END:uint = 35;
		public static const HOME:uint = 36;
		public static const INSERT:uint = 45;
		public static const DELETE:uint = 46;
		public static const SPACEBAR:uint = 32;
		public static const LEFT_ARROW:uint = 37;
		public static const RIGHT_ARROW:uint = 39;
		public static const UP_ARROW:uint = 38;
		public static const DOWN_ARROW:uint = 40;
		
		
		private var _game:Game;
		private var _keys:Object = {};
		
		
		public function Keyboard(game:Game)
		{
			_game = game;
			
			_game.starling.nativeStage.addEventListener(KeyboardEvent.KEY_DOWN, _keyboard);
			_game.starling.nativeStage.addEventListener(KeyboardEvent.KEY_UP, _keyboard);
		}
		
		
		private function _keyboard(event:KeyboardEvent):void
		{
			if(event.type === KeyboardEvent.KEY_DOWN) _keys[event.keyCode] = true;
			else delete _keys[event.keyCode];
		}
		
		
		public function getState():KeyboardState
		{
			return new KeyboardState(ObjectUtil.copy(_keys));
		}
		
	}
	
}
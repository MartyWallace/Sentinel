﻿package
{
	
	import sentinel.base.Thing;
	import sentinel.events.ThingEvent;
	import sentinel.user.Keyboard;
	import sentinel.user.KeyboardState;
	import starling.core.Starling;
	import sentinel.user.MouseState;
	import sentinel.base.Game;
	

	public class TestGame extends Game
	{
		
		private var _thing:Thing;
		

		public override function construct():void
		{
			_thing = new MyThing();
		}
		
		
		public override function update():void
		{
			trace(ticks);
			_thing.update();
		}
		
	}
	
}
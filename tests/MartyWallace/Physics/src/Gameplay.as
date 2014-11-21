package
{
	
	import beings.Platform;
	import sentinel.framework.client.Keyboard;
	import sentinel.framework.client.KeyboardState;
	import sentinel.framework.events.KeyboardEvent;
	import sentinel.gameplay.physics.Debug;
	import sentinel.gameplay.physics.EngineDef;
	import sentinel.gameplay.physics.Vector2D;
	import sentinel.gameplay.scene.Being;
	import sentinel.gameplay.scene.World;
	import sentinel.gameplay.states.GameplayState;
	
	
	public class Gameplay extends GameplayState
	{
		
		private var _platform:Platform;
		private var _cooldown:int = 0;
		
		
		public function Gameplay()
		{
			super(new World(new EngineDef(new Vector2D(0, 1400)), new Debug(game, 1, 0.5, 0, new <int>[Debug.SHAPE, Debug.CENTER_OF_MASS])), new HUD());
			
			world.add(Being.create('beings::Platform', { x: viewport.center.x, y: viewport.height - 60 } ));
			
			world.camera.x = viewport.center.x;
			world.camera.y = viewport.center.y;
			
			keyboard.addEventListener(KeyboardEvent.KEY_PRESSED, _togglePause);
			keyboard.addEventListener(KeyboardEvent.KEY_PRESSED, _quit);
		}
		
		
		public override function deconstruct():void
		{
			keyboard.removeEventListener(KeyboardEvent.KEY_PRESSED, _togglePause);
			keyboard.removeEventListener(KeyboardEvent.KEY_PRESSED, _quit);
			
			super.deconstruct();
		}
		
		
		private function _togglePause(event:KeyboardEvent):void
		{
			if (event.keyCode === Keyboard.P)
			{
				trace(world.json);
				world.frozen = !world.frozen;
			}
		}
		
		
		private function _quit(event:KeyboardEvent):void
		{
			if (event.keyCode === Keyboard.ESC)
			{
				game.loadState(new Menu());
			}
		}
		
		
		protected override function update():void
		{
			var kbd:KeyboardState = keyboard.getState();
			
			if (kbd.isDown(Keyboard.A)) world.camera.x -= 3;
			if (kbd.isDown(Keyboard.D)) world.camera.x += 3;
			if (kbd.isDown(Keyboard.W)) world.camera.y -= 3;
			if (kbd.isDown(Keyboard.S)) world.camera.y += 3;
			
			if (kbd.isDown(Keyboard.SPACEBAR)) world.camera.lookAt(world.getUnique('platform'));
			
			if (kbd.isDown(Keyboard.LEFT_ARROW)) world.camera.rotation -= 0.01;
			if (kbd.isDown(Keyboard.RIGHT_ARROW)) world.camera.rotation += 0.01;
			
			if (kbd.isDown(Keyboard.UP_ARROW)) world.camera.zoom += 0.01;
			if (kbd.isDown(Keyboard.DOWN_ARROW)) world.camera.zoom -= 0.01;
			
			super.update();
		}
		
	}
	
}
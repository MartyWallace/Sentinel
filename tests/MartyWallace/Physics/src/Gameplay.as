package
{
	
	import beings.Platform;
	import sentinel.framework.client.Keyboard;
	import sentinel.framework.client.KeyboardState;
	import sentinel.gameplay.events.WorldEvent;
	import sentinel.gameplay.physics.Debug;
	import sentinel.gameplay.physics.EngineDef;
	import sentinel.gameplay.physics.Vector2D;
	import sentinel.gameplay.scene.Boundary;
	import sentinel.gameplay.scene.World;
	import sentinel.testing.states.TestGameplay;
	
	
	public class Gameplay extends TestGameplay
	{
		
		private var _platform:Platform;
		private var _boundary:Boundary;
		private var _cooldown:int = 0;
		
		
		public function Gameplay()
		{
			super(
				new World(
					new EngineDef(new Vector2D(0, 1400)),
					new Debug(game, 1, 0.5, 0, new <int>[Debug.SHAPE, Debug.CENTER_OF_MASS])
				),
				new HUD()
			);
			
			if (storage.pull('world') !== null)
			{
				world.load(storage.pull('world'));
			}
			else
			{
				var platform:Platform = new Platform();
				platform.moveTo(viewport.center.x, viewport.height - 60);
				
				world.add(platform);
			}
			
			world.camera.x = viewport.center.x;
			world.camera.y = viewport.center.y;
			
			world.addEventListener(WorldEvent.FREEZE, _worldFreezeHandler);
		}
		
		
		private function _worldFreezeHandler(event:WorldEvent):void
		{
			// A good place to set up a pause menu.
			// ...
		}
		
		
		protected override function exit():void
		{
			game.loadState(new Menu());
		}
		
		
		protected override function get backgroundColor():uint { return 0x666666; }
		
	}
	
}
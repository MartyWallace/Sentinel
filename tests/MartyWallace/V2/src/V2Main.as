package {
	
	import sentinel.framework.Game;
	import sentinel.framework.GameSettings;
	import sentinel.framework.client.Keyboard;
	
	public class V2Main extends Game {
		
		protected override function construct():void {
			library.store('assets', new Assets());
			trace(library.getBundle('assets').getBitmapData('sprite.png'));
			
			loadState(new GameState());
		}
		
		protected override function update():void {
			if (keyboard.getState().isDown(Keyboard.A)) {
				trace(mouse.getState());
			}
		}
		
		public override function get settings():GameSettings {
			var settings:GameSettings = new GameSettings();
			settings.debug = true;
			
			return settings;
		}
		
	}
	
}
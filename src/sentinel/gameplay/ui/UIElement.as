package sentinel.gameplay.ui
{
	
	import sentinel.framework.graphics.IGraphics;
	import sentinel.framework.Thing;
	import sentinel.gameplay.scene.World;
	
	
	public class UIElement extends Thing
	{
		
		private var _graphics:IGraphics;
		
		
		public override function deconstruct():void
		{
			if (_graphics !== null) _graphics.deconstruct();
			
			super.deconstruct();
		}
		
		
		protected final override function added(ui:Thing):void
		{
			if (ui is UI)
			{
				_graphics = defineGraphics();
			}
			else
			{
				throw new Error("Instances of UIElement can only be added to UI.");
			}
		}
		
		
		protected final override function removed(ui:Thing):void
		{
			if (ui is UI)
			{
				if (_graphics !== null) _graphics.deconstruct();
			}
			else
			{
				throw new Error("Instances of UIElement can only be removed from UI.");
			}
		}
		
		
		protected function defineGraphics():IGraphics
		{
			return null;
		}
		
		
		public function get ui():UI { return parent as UI; }
		public function get world():World { return ui.world; }
		public function get graphics():IGraphics { return _graphics; }
		
	}
	
}
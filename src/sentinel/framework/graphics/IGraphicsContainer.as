package sentinel.framework.graphics 
{
	
	import starling.display.DisplayObject;
	
	
	public interface IGraphicsContainer
	{
		
		function sortChildrenByDepth():void;
		
		function addChild(child:DisplayObject):DisplayObject;
		function addChildAt(child:DisplayObject, index:int):DisplayObject;
		
		function removeChild(child:DisplayObject, dispose:Boolean = false):DisplayObject;
		function removeChildAt(index:int, dispose:Boolean = false):DisplayObject;
		function removeChildren(startIndex:int = 0, endIndex:int = -1, dispose:Boolean = false):void;
		
		function getChildAt(index:int):DisplayObject;
		function getChildByName(name:String):DisplayObject;
		function getChildIndex(child:DisplayObject):int;
		
		function get numChildren():int;
		
	}
	
}
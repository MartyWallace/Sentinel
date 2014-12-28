package sentinel.gameplay.world
{
	
	/**
	 * A contract for a Being who can be named and grouped for referencing.
	 * @author Marty Wallace.
	 */
	public interface IGroupable
	{
		
		/**
		 * The name of the group this Being is associated with.
		 */
		function get groupName():String;
		
		/**
		 * The name of this Being within its group. This must be unique per-group.
		 */
		function get nameInGroup():String;
		
	}
	
}
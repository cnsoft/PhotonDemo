package svelto.efw.entity 
{
	import svelto.efw.Context;
	
	public class EntityDestroyer
	{
		private var _context:Context;
		
		function EntityDestroyer(context:Context) 
		{
			_context = context;
		}
		
		public function Destroy(entity:IEntity):void
		{
			_context.removeEntity(entity);
		}
	}
}
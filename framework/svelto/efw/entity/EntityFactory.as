package svelto.efw.entity 
{
	import svelto.efw.component.IComponent;
	import svelto.efw.Context;
	import svelto.efw.sfi;
	
	public class EntityFactory
	{
		private var _context:Context;
		
		function EntityFactory(context:Context)
		{
			_context = context;
		}
		
		public function Build(...args):IEntity
		{
			return _context.addEntity.apply(_context, args);
		}
	}
}
package svelto.efw.plugins.destroyer 
{
	import svelto.efw.component.IComponent;
	import svelto.efw.engine.IEngine;
	import svelto.efw.entity.EntityComponent;
	import svelto.efw.entity.EntityDestroyer;
	import svelto.efw.entity.IEntity;
	
	public class DestroyerEngine implements IEngine
	{
		private var _destroyer:EntityDestroyer;
		
		function DestroyerEngine(destroyer:EntityDestroyer) 
		{
			_destroyer = destroyer;
		}
		
		public function accepts(obj:IComponent):Boolean
		{
			return (obj is IDestroyerComponent);
		}	
		
		public function add(c:EntityComponent):void
		{
			(c.component as IDestroyerComponent).onDeath.add(function():void { destroyBullet(c.entity); } );
		}
		
		public function remove(c:IComponent):void
		{
			(c as IDestroyerComponent).onDeath.removeAll();
		}
		
		private function destroyBullet(entity:IEntity):void
		{
			_destroyer.Destroy(entity);
		}
	}
}
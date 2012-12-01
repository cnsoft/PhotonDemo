package svelto.efw 
{
	import flash.utils.Dictionary;
	import svelto.efw.component.IComponent;
	import svelto.efw.component.IReleaseable;
	import svelto.efw.component.IStartable;
	import svelto.efw.engine.IEngine;
	import svelto.efw.entity.BuildEntity;
	import svelto.efw.entity.EntityComponent;
	import svelto.efw.entity.IEntity;
	import svelto.efw.sfi;
	import svelto.ticker.ITickable;
	import svelto.ticker.Ticker;
	
	public class Context 
	{
		private var _engines:Dictionary;
		private var _tickEngine:Ticker;
				
		function Context(tickEngine:Ticker) 
		{
			_engines = new Dictionary;
			_tickEngine = tickEngine;
		}
		
		public function addEngine(engine:IEngine):void 
		{ 
			_engines[engine] = engine;
			
			if (engine is ITickable)
				_tickEngine.add(engine as ITickable);
		}
		
		public function removeEngine(engine:IEngine):void 
		{ 
			if (engine is ITickable)
				_tickEngine.remove(engine as ITickable);
			
			delete _engines[engine];
		}
		
		public function addEntity(...args):IEntity 
		{ 
			var entity:IEntity = svelto.efw.entity.BuildEntity(args);
			
			for each (var component:IComponent in entity.sfi::components)
			{
				for each (var engine:IEngine in _engines)
					if (engine.accepts(component))
						engine.add(new EntityComponent(component, entity))
				
				if (component is IStartable)
					(component as IStartable).start();
					
				if (component is ITickable)
					_tickEngine.add(component as ITickable);
			} 
			
			return entity;
		}
		
		public function removeEntity(entity:IEntity):void 
		{ 
			entity.release();
			
			for each (var component:IComponent in entity.sfi::components)
			{
				for each (var engine:IEngine in _engines)
					if (engine.accepts(component))
						engine.remove(component);
				
				if (component is IReleaseable)
					(component as IReleaseable).release();
					
				if (component is ITickable)
					_tickEngine.remove(component as ITickable);
			}
		}
	}
}
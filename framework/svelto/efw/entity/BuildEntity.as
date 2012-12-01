package svelto.efw.entity 
{
	import svelto.efw.sfi;
	import svelto.efw.component.IComponent;

	public function BuildEntity(components:Array):IEntity
	{
		return Entity.sfi::create(components);
	}
}

import svelto.communication.IListener;
import svelto.efw.component.IComponentBroadcaster;
import svelto.utils.ObjectPool;

import svelto.efw.component.IComponent;
import svelto.efw.component.IReleaseable;
import svelto.efw.entity.IEntity;
import svelto.efw.sfi;
import svelto.dbc.*;

var _objectPool:ObjectPool = new ObjectPool(function():IEntity { return new Entity(); }, 10);

class Entity implements IEntity, IReleaseable
{
	private var _componentsCache:Array;
	
	//private var _injector:Injector; //maybe in future
		
	function Entity()
	{
	//	_injector = new Injector();
		_componentsCache = new Array;
	}
	
	sfi function get components():Array { return _componentsCache; }
	
	//can be vastly optimized, could follow canListen, canDispatch rules
	public function send(message:*):void
	{
		for each (var component:IComponent in _componentsCache)
			if (component is IListener)
				(component as IListener).listen(message);
	}
	
	public function release():void
	{
		_objectPool.checkIn(this);
	}
	
	static sfi function create(components:Array):IEntity
	{
		var entity:Entity = _objectPool.checkOut();	
		
		entity.reset();
		entity.addComponents(components);
		
		return entity;
	}
	
	private function reset():void
	{
		//_injector = new Injector();
		_componentsCache.splice(0, _componentsCache.length);
	}
	
	private function addComponents(components:Array):void
	{
		//for each (var sharedComponent:IComponent in components)
			//if (sharedComponent is IShareable)
			//	_injector.map((sharedComponent as IShareable).maps()).toValue(sharedComponent);
				
		for each (var componentAgain:IComponent in components)
		{
			if (componentAgain is IComponentBroadcaster)
				(componentAgain as IComponentBroadcaster).send.add(send);
			_componentsCache.push(componentAgain);
		}
	}
}
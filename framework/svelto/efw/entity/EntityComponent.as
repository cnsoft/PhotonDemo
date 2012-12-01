package svelto.efw.entity 
{
	import svelto.efw.component.IComponent;
	import svelto.efw.entity.IEntity;

	public class EntityComponent 
	{
		public var component:IComponent;
		public var entity:IEntity;
		
		function EntityComponent(component:IComponent, entity:IEntity) 
		{
			this.component = component;
			this.entity = entity;
		}
	}
}
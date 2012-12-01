package svelto.efw.plugins.collision 
{
	import flash.geom.Rectangle;
	import svelto.efw.component.IComponent;
	
	public interface ICollidableComponent extends IComponent
	{
		function get rect():Rectangle;
		function get layer():uint;
		
		function onCollision(layer:int):void;
	}
}
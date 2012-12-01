package svelto.efw.engine 
{
	import svelto.efw.component.IComponent;
	import svelto.efw.entity.EntityComponent;
	
	public interface IEngine 
	{
		function accepts(obj:IComponent):Boolean;
		
		function add(obj:EntityComponent):void;
		function remove(obj:IComponent):void;
	}
}
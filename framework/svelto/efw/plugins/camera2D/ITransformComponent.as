package svelto.efw.plugins.camera2D 
{
	import svelto.efw.component.IComponent;
	
	public interface ITransformComponent extends IComponent
	{
		function set x(x:Number):void;
		function set y(y:Number):void;
		
		function set rotation(rotation:Number):void;
		
		function get worldTransform():Transformation;
	}
}
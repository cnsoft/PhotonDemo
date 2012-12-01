package svelto.efw.plugins.camera2D 
{
	import svelto.efw.component.IComponent;
	import svelto.math.Vector2D;
	
	public class CameraTarget implements IComponent
	{
		private var _entityTransform:Transformation = new Transformation();
		
		internal var size:Vector2D;
		
		function CameraTarget(transform:Transformation, size:Vector2D = null) 
		{
			_entityTransform = transform;
			this.size = size;
		}
		
		public function get transform():Transformation { return _entityTransform; }
		
		public 		function get hsize():Vector2D { return size; }
	}
}
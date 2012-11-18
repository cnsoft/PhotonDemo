package  
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import svelto.efw.plugins.camera2D.Transformation;
	import svelto.efw.plugins.flash.IRenderableComponent;
	import svelto.efw.plugins.camera2D.ITransformComponent;
		
	[Embed(source = "../art/swf/background.swf", symbol="Background")]
	public class Map extends Sprite implements IRenderableComponent, ITransformComponent
	{
		private var _worldTransform:Transformation = new Transformation;
		
		public function get graphic():DisplayObject
		{
			return this;
		}
		
		public function get worldTransform():Transformation { return _worldTransform; }
	}
}
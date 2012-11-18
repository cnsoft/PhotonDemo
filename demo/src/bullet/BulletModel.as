package bullet 
{
	import svelto.efw.plugins.camera2D.Transformation;
	import svelto.math.Vector2D;
	
	public class BulletModel 
	{
		public var entityTransform:Transformation = new Transformation();
		public var speed:Number;
		public var direction:Vector2D = new Vector2D;
		public var id:int;
	}
}
package bullet 
{
	import svelto.efw.component.IComponent;
	import svelto.efw.plugins.camera2D.Transformation;
	import svelto.math.Vector2D;
	
	public class BulletModel
	{
		public var entityTransform:Transformation = new Transformation();
		public var speed:Number;
		public var direction:Vector2D;
		public var id:int;
		public var life:Number;
		
		public function set rotation(value:Number):void { _rotation = value; direction.fromRotation((value / 180.0) * (Math.PI)); }
		public function get rotation():Number { return _rotation; }
		
		function BulletModel()
		{
			direction = new Vector2D;
		}
		
		private var _rotation:Number;
	}
}
package svelto.efw.plugins.camera2D 
{
	import svelto.math.Vector2D;
	
	public class Transformation
	{
		public var pos:Vector2D;
		public var rotation:Number = 0;
		
		function Transformation(x:Number = 0, y:Number = 0, rotation:Number = 0): void
		{
			pos = new Vector2D(x, y);
			
			this.rotation = rotation;
		}
		
		public function copy(t: Transformation): void
		{
			pos.x = t.pos.x;
			pos.y = t.pos.y;
			rotation = t.rotation;
		}
		
		public function toString(): String
		{
			return "[" + pos.x + ", " + pos.y + ", " + rotation + "]";
		}
	}
}
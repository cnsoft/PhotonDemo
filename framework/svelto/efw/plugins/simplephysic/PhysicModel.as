package svelto.efw.plugins.simplephysic 
{
	import svelto.math.Vector2D;
	
	public class PhysicModel
	{
		public var position:Vector2D;
		public var mass:Number;
		
		function PhysicModel(direction:Vector2D) 
		{
			this.direction = new Vector2D(direction.x, direction.y);
//			startDirection = new Vector2D(direction.x, direction.y);
			
			velocity = new Vector2D();
			position = new Vector2D();
			
			force = new Vector2D();

			//rotation = 0.0;
			mass = 1.0;
			speed = 0.0;
		}
		
		internal var force:Vector2D;
//		internal var startDirection:Vector2D;
		
		internal var direction:Vector2D;
		internal var velocity:Vector2D;
		internal var speed:Number;
//		public var rotation:Number;		
	}
}

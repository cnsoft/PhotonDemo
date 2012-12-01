package character
{
	import flash.geom.Rectangle;
	import svelto.efw.component.IComponent;
	import svelto.efw.plugins.camera2D.Transformation;
	import svelto.efw.plugins.simplephysic.PhysicModel;
	import svelto.math.Vector2D;

	public class CharacterModel extends PhysicModel
	{
		public var entityTransform:Transformation = new Transformation();
		public var id:int;
		public var aim:Vector2D;
		public var rotation:Number;	
		public var energy:int;
		
		private var _rectangle:Rectangle = new Rectangle(0, 0, 40, 40);
				
		function CharacterModel()
		{
			super(Vector2D.RT);
			
			reset();
		}
		
		public function reset():void 
		{
			mass = 0.4;
			
			position.x = 200 + (Math.random() * 200);
			position.y = 200 + (Math.random() * 200);
			rotation = 0;
			
			energy = 10;
			
			entityTransform.pos = position;
			aim = new Vector2D(position.x, position.y);
		}
		
		public function get rect():Rectangle { _rectangle.x = position.x - 20; _rectangle.y = position.y - 20; return _rectangle; }
	}
}
package character
{
	import svelto.efw.component.IComponent;
	import svelto.efw.plugins.camera2D.Transformation;
	import svelto.efw.plugins.physic.PhysicModel;
	import svelto.math.Vector2D;

	public class CharacterModel extends PhysicModel implements IComponent
	{
		public var entityTransform:Transformation = new Transformation();
		public var id:int;
		public var aim:Vector2D;
		public var rotation:Number;	
		
		function CharacterModel()
		{
			super(Vector2D.DN);
			
			aim = new Vector2D();
			mass = 0.4;
			
			position.x = 200;
			position.y = 200;
			
			entityTransform.pos = position;
		}
	}
}
package svelto.efw.plugins.simplephysic 
{
	import svelto.math.Vector2D;
	
	public class PhysicComponent implements IPhysicComponent
	{
		private var _model:PhysicModel;
			
		public function PhysicComponent(model:PhysicModel)
		{
			_model = model;
		}
		
		public function get physicModel():PhysicModel
		{
			return _model;
		}
		
		public function applyLocalForce(force:Vector2D):void
		{	//transform force from local to world
			_model.force.plusEquals(Vector2D.transform(force, _model.direction));
		}
		
		public function applyWorldForce(force:Vector2D):void
		{	//transform force from local to world
			_model.force.plusEquals(force);
		}
	}
}
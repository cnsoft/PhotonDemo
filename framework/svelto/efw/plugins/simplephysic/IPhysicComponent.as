package svelto.efw.plugins.simplephysic 
{
	import svelto.efw.component.IComponent;
	import svelto.math.Vector2D;
	
	public interface IPhysicComponent extends IComponent
	{
		function applyLocalForce(localForce:Vector2D):void;
		function applyWorldForce(force:Vector2D):void;
		
		function get physicModel():PhysicModel;
	}
}

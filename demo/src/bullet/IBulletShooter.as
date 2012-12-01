package bullet 
{
	import svelto.communication.signal.ISignal;
	import svelto.efw.component.IComponent;
	
	public interface IBulletShooter extends IComponent
	{
		function get shoot():ISignal;
	}
}
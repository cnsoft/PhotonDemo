package bullet 
{
	import svelto.communication.signal.ISignal;
	
	public interface IBulletShooter
	{
		function get shoot():ISignal;
	}
}
package bullet 
{
	import svelto.communication.signal.Signal;
	import svelto.efw.plugins.destroyer.IDestroyerComponent;
	
	public interface IBulletComponent extends IDestroyerComponent
	{
		function get model():BulletModel;
	}
}
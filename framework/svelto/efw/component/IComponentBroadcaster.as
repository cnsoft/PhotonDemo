package svelto.efw.component 
{
	import svelto.communication.signal.ISignal;
	
	public interface IComponentBroadcaster 
	{
		function get send():ISignal;
	}
}
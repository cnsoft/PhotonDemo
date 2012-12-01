package svelto.efw.plugins.destroyer 
{
	import svelto.communication.signal.ISignal;
	
	public interface IDestroyerComponent 
	{
		function get onDeath():ISignal;
		
		function IAcceptDeathWithHonor():void;
	}
}
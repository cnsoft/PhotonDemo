package svelto.efw.entity 
{
	import flash.utils.Dictionary;
	import svelto.communication.IBroadcaster;
		
	public interface IEntity extends IBroadcaster
	{
		function release():void;
	}
}
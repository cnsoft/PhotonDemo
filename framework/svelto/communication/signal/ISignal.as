package svelto.communication.signal 
{
	public interface ISignal 
	{
		function add(func:Function):void;
		function remove(func:Function):void;
		function removeAll():void;
	}
}
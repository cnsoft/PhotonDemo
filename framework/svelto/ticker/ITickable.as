package svelto.ticker 
{
	public interface ITickable 
	{
		function tick(timeDelta:Number):void;
	}
}
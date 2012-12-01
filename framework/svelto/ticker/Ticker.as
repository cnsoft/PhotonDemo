package svelto.ticker
{
	import flash.display.Stage;
	
	import flash.events.Event;
	
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	public class Ticker
	{
		private var _enterFrameFunctions:Dictionary;
		private var _lastTime:Number;
		private var _update:Function;
		
		public function Ticker(context:Stage)
		{
			_enterFrameFunctions = new Dictionary(true);
			
			context.addEventListener(Event.FRAME_CONSTRUCTED, onEnterFrame);
			
			_lastTime = getTimer();
		}
		
		public function add(obj:ITickable):void
		{
			_enterFrameFunctions[obj] = true;
		}
		
		public function remove(obj:ITickable):void
		{
			delete _enterFrameFunctions[obj];
		}
		
		private function onEnterFrame(evt:Event):void
		{
			var thisTime:Number = getTimer();
			
			for (var tick:Object in _enterFrameFunctions)
				(tick as ITickable).tick((thisTime - _lastTime) * 0.001);
			
			_lastTime = thisTime;
		}
	}
}
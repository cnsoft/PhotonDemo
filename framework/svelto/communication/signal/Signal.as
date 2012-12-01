package svelto.communication.signal 
{
	import flash.utils.Dictionary;
	
	//obviously not complete
	
	public class Signal implements ISignal, ISignalDispatcher
	{
		private var _function:Function;
		
		public function add(func:Function):void
		{
			_function = func;
		}
		
		public function remove(func:Function):void
		{
			_function = null;
		}
		
		public function removeAll():void
		{
			_function = null;
		}
		
		public function dispatch(dependency:*):void
		{
			if (_function != null)
				_function(dependency);
		}
	}
}
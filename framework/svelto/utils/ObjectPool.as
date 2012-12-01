package svelto.utils
{
	import flash.utils.Dictionary;
	import svelto.dbc.*;

	public class ObjectPool
	{
		private var _create:Function;
		private var _length:int = 0;
		
		private var _list:Array = [];
		private var _checkedInObjects:Dictionary;
		private var _checkedOutObjects:Dictionary;
		private var _disposed:Boolean = false;
		
		/*
		 * @param create This is the Function which should return a new Object to populate the Object pool
		 * @param clean This Function will recieve the Object as a param and is used for cleaning the Object ready for reuse
		 * @param minSize The initial size of the pool on Pool construction
		 * @param maxSize The maximum possible size for the Pool
		 */
		
		public function ObjectPool(create:Function, size:int = 50)
		{
			this._create = create;
			_checkedInObjects = new Dictionary;
			_checkedOutObjects = new Dictionary;
			
			for (var i:int = 0; i < size; i++)
				add();
		}
		
		private function add():void
		{
			_list[_length++] = _create();
			_checkedInObjects[_list[_length - 1]] = true;
		}
		
		/*
		 * Checks out an Object from the pool
		 */
		public function checkOut():*
		{
			var item:Object;
			
			if (_length == 0)
				item = _create();
			else
			{
				item = _list[--_length];
				
				DesignByContract.Check::Assert(_checkedInObjects[item] != undefined);
				
				delete _checkedInObjects[item];
			}
			
			_checkedOutObjects[item] = true;
			
			return item;
		}
		
		/*
		 * Checks the Object back into the Pool
		 * @param item The Object you wish to check back into the Object Pool
		 */
		public function checkIn(item:*):void
		{
			DesignByContract.Check::Require(_checkedInObjects[item] == undefined);
			
			_checkedInObjects[item] = true;
			
			delete _checkedOutObjects[item];
			
			_list[_length++] = item;
		}
		
		public function recycle():void
		{
			for (var object:Object in _checkedOutObjects)
				checkIn(object);
		}
		
		/*
		 * Disposes the Pool ready for GC
		 */
		public function dispose():void
		{
			if (_disposed)
				return;
			
			_disposed = true;
			
			_create = null;
			_list = null;
		}
	}
}
package svelto.efw.plugins.keyboard 
{
	import flash.display.Stage;
	import flash.utils.Dictionary;
	import svelto.efw.plugins.keyboard.enums.KeySets;
	
	public class KeyboardManager 
	{
		private var _manager:KeySmithManager;
		private var _actions:Dictionary;
		
		function KeyboardManager(stage:Stage) 
		{
			_manager = new KeySmithManager();
			
			_manager.init(stage, KeySets.DUAL_ARROWS_SET);
			
			_actions = new Dictionary;
		}
		
		public function registerAction(key:String, func:Function, onRelease:Boolean = false):void
		{
			_actions[key] = {func:func, onRelease:onRelease};
		}
		
		public function update():void
		{
			for (var key:String in _actions)
			{
				if (_actions[key].onRelease == false)
				{
					if (_manager.isKeyDown(key))
						_actions[key].func();
				}
				else
				if (_manager.isKeyReleased(key))
					_actions[key].func();
			}
		}
	}
}
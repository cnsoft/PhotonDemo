package svelto.efw.plugins.keyboard 
{
	import flash.display.Stage;
	import org.as3commons.reflect.Metadata;
	import org.as3commons.reflect.Method;
	import org.as3commons.reflect.Type;
	import svelto.dbc.*;
	import svelto.efw.component.IComponent;
	import svelto.efw.engine.IEngine;
	import svelto.efw.entity.EntityComponent;
	import svelto.efw.plugins.keyboard.enums.KeyMetaData;
	import svelto.ticker.ITickable;
	
	public class KeyboardEngine implements IEngine, ITickable
	{
		private var _manager:KeyboardManager;
		
		function KeyboardEngine(stage:Stage) 
		{
			_manager = new KeyboardManager(stage);
		}
		
		public function accepts(obj:IComponent):Boolean
		{
			return (obj is IKeyboardComponent);
		}
		
		public function tick(timeDelta:Number):void
		{
			_manager.update();
		}
		
		public function add(e:EntityComponent):void
		{
			var c:IComponent = e.component;
			
			DesignByContract.Check::Require(c is IKeyboardComponent);
			
			var type:Type = Type.forInstance(c);
			
			var methods:Array = type.methods;
			
			for each (var method:Method in methods)
			{
				var metaDatas:Array = method.getMetadata(KeyMetaData.BindKey);
				for each (var metaData:Metadata in metaDatas)
				{
					DesignByContract.Check::Assert(metaData.arguments.length == 1, "BindKey metatag has wrong arguments");
							
					_manager.registerAction(metaData.arguments[0].value, c[method.name]);
				}
			}
		}
		
		public function remove(c:IComponent):void
		{
			
		}
	}
}

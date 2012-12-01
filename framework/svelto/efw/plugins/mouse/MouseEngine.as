package svelto.efw.plugins.mouse 
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import org.as3commons.reflect.Metadata;
	import org.as3commons.reflect.MetadataArgument;
	import org.as3commons.reflect.Method;
	import org.as3commons.reflect.Type;
	import svelto.dbc.*;
	import svelto.efw.component.IComponent;
	import svelto.efw.engine.IEngine;
	import svelto.efw.entity.EntityComponent;
	
	public class MouseEngine implements IEngine
	{
		private var _stage:DisplayObject;
		
		function MouseEngine(stage:DisplayObject) 
		{
			_stage = stage;
		}
		
		public function accepts(obj:IComponent):Boolean
		{
			return (obj is IMouseComponent);
		}	
		
		public function add(c:EntityComponent):void
		{
			DesignByContract.Check::Require(c.component is IMouseComponent);
			
			checkMetaData(c.component);
		}
		
		public function remove(c:IComponent):void
		{
			DesignByContract.Check::Require(c is IMouseComponent);
			
			checkMetaData(c, false);
		}
		
		private function checkMetaData(c:IComponent, add:Boolean = true):void
		{
			var type:Type = Type.forInstance(c);
			
			var methods:Array = type.methods;
			for each (var method:Method in methods)
			{
				if (method.hasMetadata(MetaEvent.MOUSE_EVENT))
				{
					var metaData:Array = method.getMetadata(MetaEvent.MOUSE_EVENT);
					var argument:String = ((metaData[0] as Metadata).arguments[0] as MetadataArgument).value;
					
					if (argument == MetaEvent.MOUSEMOVE)
					{
						add == true ?
							_stage.addEventListener(MouseEvent.MOUSE_MOVE, c[method.name], false, 0, true) :
							_stage.removeEventListener(MouseEvent.MOUSE_MOVE, c[method.name]);
						
					}
					
					if (argument == MetaEvent.CLICK)
					{
						add == true ?
							_stage.addEventListener(MouseEvent.CLICK, c[method.name], false, 0, true) : 
							_stage.removeEventListener(MouseEvent.CLICK, c[method.name]);
					}
				}
			}
		}
	}
}
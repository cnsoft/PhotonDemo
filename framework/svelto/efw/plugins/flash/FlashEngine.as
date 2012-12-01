package svelto.efw.plugins.flash 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.DisplayObject;

	import svelto.dbc.Check;
	import svelto.dbc.DesignByContract;
	
	import svelto.efw.engine.IEngine;
	import svelto.efw.component.IComponent;
	import svelto.efw.plugins.flash.IRenderableComponent;
	
	import svelto.efw.entity.EntityComponent;
	
	public class FlashEngine implements IEngine
	{
		private var _root: DisplayObjectContainer;
		
		function FlashEngine(root:DisplayObjectContainer) 
		{
			_root = root;
		}
		
		public function accepts(obj:IComponent):Boolean
		{
			return (obj is IRenderableComponent) && (obj is DisplayObject);
		}	
		
		public function add(e:EntityComponent):void
		{
			var c:IComponent = e.component;
			
			DesignByContract.Check::Require(c is IRenderableComponent);
						
			_root.addChild(c as DisplayObject);
		}
		
		public function remove(e:IComponent):void
		{
			DesignByContract.Check::Require(e is IRenderableComponent);
			
			_root.removeChild(e as DisplayObject);
		}
	}
}

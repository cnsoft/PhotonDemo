package svelto.efw.plugins.camera2D 
{
	import flash.geom.Point;
	import flash.geom.Transform;
	import flash.utils.Dictionary;
	import svelto.math.Vector2D;
	
	import svelto.dbc.*;
	import svelto.efw.component.IComponent;
	import svelto.efw.engine.IEngine;
	import svelto.efw.plugins.camera2D.Transformation;
	import svelto.ticker.ITickable;
	import svelto.efw.entity.EntityComponent;	
	
	public class CameraEngine implements IEngine, ITickable
	{
		private var _worldEntities:Dictionary;
		private var _targetEntities:Dictionary;
		private var _defaultSize:Vector2D;
		
		function CameraEngine(defaultSize:Vector2D) 
		{
			_worldEntities = new Dictionary(true);
			_targetEntities = new Dictionary(true);
			_defaultSize = defaultSize;
		}
		
		public function accepts(obj:IComponent):Boolean
		{
			return obj is ITransformComponent || obj is CameraTarget;
		}	
		
		public function add(obj:EntityComponent):void
		{
			var c:IComponent = obj.component;
			
			DesignByContract.Check::Require(c is ITransformComponent || c is CameraTarget); 
			
			if (c is CameraTarget)
			{
				if ((c as CameraTarget).hsize == null)
					(c as CameraTarget).size = _defaultSize;
				_targetEntities[c] = true;
			}
			
			if (c is ITransformComponent)
				_worldEntities[c] = true;
		}
		
		public function remove(obj:IComponent):void
		{
			DesignByContract.Check::Require(obj is ITransformComponent || obj is CameraTarget); 
			
			if (obj is CameraTarget)
				delete _targetEntities[obj];

			if (obj is ITransformComponent)
				delete _worldEntities[obj];
		}
		
		public function tick(timeDelta:Number):void
		{
			var obj:Object;
			var camera:CameraTarget = null;
			
			for (obj in _targetEntities)
			{
				camera = (obj as CameraTarget);
					
				break;
			}
			
			if (camera == null)
				return;
				
			var cameraTransform:Transformation = camera.transform;
			var size:Vector2D;
			
			size = camera.hsize;
						
			for (obj in _worldEntities)
			{
				var ct:ITransformComponent = obj as ITransformComponent;
				var worldTransform:Transformation = ct.worldTransform;
												
				var x:Number = worldTransform.pos.x - cameraTransform.pos.x;
				var y:Number = worldTransform.pos.y - cameraTransform.pos.y;
				
				ct.rotation = worldTransform.rotation - cameraTransform.rotation;
				var cos:Number =  Math.cos(-cameraTransform.rotation);
				var sin:Number =  Math.sin(-cameraTransform.rotation);
				ct.x = (x * cos - y * sin) + (size.x);
				ct.y = (x * sin + y * cos) + (size.y);
			}
		}
	}
}
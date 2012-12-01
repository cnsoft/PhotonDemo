package svelto.efw.plugins.collision 
{
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import svelto.efw.component.IComponent;
	import svelto.efw.engine.IEngine;
	import svelto.efw.plugins.mouse.IMouseComponent;
	import svelto.ticker.ITickable;
	import svelto.efw.entity.EntityComponent;
	import svelto.dbc.*;
	import com.junkbyte.console.Cc;
	
	public class CollisionEngine implements IEngine, ITickable
	{
		private var _colliders:Vector.<ICollidableComponent>;
		private var _numberOfItems:int;
		
		function CollisionEngine()
		{
			_colliders = new Vector.<ICollidableComponent>();
			_numberOfItems = 0;
		}
				
		public function accepts(obj:IComponent):Boolean
		{
			return (obj is ICollidableComponent);
		}	
		
		public function add(e:EntityComponent):void
		{
			DesignByContract.Check::Require(e.component is ICollidableComponent);
			
			_numberOfItems++;
				
			_colliders.push(e.component);
		}
		
		public function remove(c:IComponent):void
		{
			_numberOfItems--;
			
			_colliders.splice(_colliders.indexOf(c), 1);
		}
		
		public function tick(timeDelta:Number):void
		{
			var x : Number;
			var p : ICollidableComponent;
						
			for (var i:int = 0; i < _numberOfItems - 1; i++)
			{
				var colliderA:ICollidableComponent = _colliders[i];
				var rectA:Rectangle = colliderA.rect;
				var collisionLayerA:uint = colliderA.layer;
				
				for (var j:int = i + 1; j < _numberOfItems; j++)
				{
					var colliderB:ICollidableComponent = _colliders[j];
					var collisionLayerB:uint = colliderB.layer;
					
					if (collisionLayerA != collisionLayerB && rectA.intersects(colliderB.rect) == true)
					{
						colliderA.onCollision(colliderB.layer);
						colliderB.onCollision(colliderA.layer);
					}
				}
			}
		}
	}
}
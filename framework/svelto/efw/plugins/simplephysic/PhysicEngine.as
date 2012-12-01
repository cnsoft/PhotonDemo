package svelto.efw.plugins.simplephysic 
{
	import flash.utils.Dictionary;
	import svelto.dbc.*;
	import svelto.efw.component.IComponent;
	import svelto.efw.engine.IEngine;
	import svelto.math.Vector2D;
	import svelto.ticker.ITickable;
	import svelto.efw.entity.EntityComponent;	
	
	public class PhysicEngine implements ITickable, IEngine
	{
		private var _physicEntities:Dictionary;
		
		function PhysicEngine() 
		{
			_physicEntities = new Dictionary(true);
		}
		
		public function accepts(obj:IComponent):Boolean
		{
			return (obj is IPhysicComponent);
		}	
		
		public function add(e:EntityComponent):void
		{
			var c:IComponent = e.component;
			
			DesignByContract.Check::Require(c is IPhysicComponent); 
			
			_physicEntities[c] = true;
		}
		
		public function remove(c:IComponent):void
		{
			DesignByContract.Check::Require(c is IPhysicComponent); 
			
			delete _physicEntities[c];
		}
		
		public function tick(timeDelta:Number):void
		{
			for (var c:Object in _physicEntities)
			{
				var model:PhysicModel = c.physicModel;
				
				computePhysic(model, timeDelta);
			}
		}
		
		//F=-c*V ad esempio è un damping che possiamo usare per modellare, nel modo più semplice possibile, il "drag" dell'aria/acqua..
		//non ti sbagli dicendo che permette di modellare una limitazione, ad esempio, della velocità massima di caduta di un oggetto immerso in un fluido
		//-> quando Fgravità + Fdrag = m*g - c*V = 0 (ovvero quando sarà raggiunta V = m*g/c) la forza risultante è nulla
		//-> non c'è più accelerazione -> velocità resta costante.
		private function computePhysic(model:PhysicModel, timeDelta:Number):void
		{
			//all the computation are in the space of the world (screen space)
			var velocity:Vector2D = model.velocity;
			var acceleration:Vector2D = model.force.timesEqual(1.0 / model.mass);
			var deltaVelocity:Vector2D = acceleration.timesEqual(timeDelta);
			var newVelocity:Vector2D =  velocity.plus(deltaVelocity);
			var dragForce:Vector2D = velocity.timesEqual(drag);
			
			newVelocity.minusEquals(dragForce.timesEqual(timeDelta/model.mass));
					
			model.direction = newVelocity.normalize();
			
			//transform direction from world to local
//			model.rotation = -Vector2D.inverseTransform(newVelocity, model.startDirection).toAngleRad(); this is not the correct place for this
			model.velocity = newVelocity;
			
			model.position.plusEquals(newVelocity.times(timeDelta));

			model.force.zero();
		}
		
		protected function get drag():Number
		{
			return 0.5;
		}
	}
}
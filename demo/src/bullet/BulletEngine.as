package bullet 
{
	import flash.utils.Dictionary;
	import svelto.efw.component.IComponent;
	import svelto.efw.engine.IEngine;
	import svelto.efw.entity.EntityDestroyer;
	import svelto.efw.entity.EntityFactory;
	import svelto.ticker.ITickable;
	
	public class BulletEngine implements IEngine, ITickable
	{
		private var _factory:EntityFactory;
		private var _destroyer:EntityDestroyer;
		private var _bullets:Dictionary;
		private var _bulletEntities:Dictionary;
		
		function BulletEngine(factory:EntityFactory, destroyer:EntityDestroyer ) 
		{
			_factory = factory;
			_bullets = new Dictionary(true);
			_bulletEntities = new Dictionary();
			_destroyer = destroyer;
		}
		
		public function accepts(obj:IComponent):Boolean
		{
			return (obj is IBulletShooter) || (obj is BulletModel);
		}	
		
		public function add(c:IComponent):void
		{
			if (c is IBulletShooter)
			{
				var bulletShooter:IBulletShooter = c as IBulletShooter;
				
				bulletShooter.shoot.add(shoot);
			}
			else
				_bullets[c] = true;
		}
		
		public function remove(c:IComponent):void
		{
			if (c is IBulletShooter)
			{
				var bulletShooter:IBulletShooter = c as IBulletShooter;
			
				bulletShooter.shoot.remove(shoot);
			}
			else
				delete _bullets[c];
		}
		
		private function shoot(bullet:BulletModel):void
		{	//find a solution to pool BulletView
			_bulletEntities[bullet] = _factory.Build(new BulletView(bullet), bullet);
		}
		
		public function tick(timeDelta:Number):void
		{
			for (var obj:Object in _bullets)
			{
				var model:BulletModel = obj as BulletModel;
				
				if (model.life <= 0)
					_destroyer.Destroy(_bulletEntities[model]);
				else
				{
					model.entityTransform.pos.plusEquals(model.direction.times(model.speed * timeDelta));
				
					model.life -= timeDelta;
				}
			}
		}
	}
}
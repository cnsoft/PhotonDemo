package bullet 
{
	import svelto.efw.component.IComponent;
	import svelto.efw.engine.IEngine;
	import svelto.efw.entity.EntityFactory;
	
	public class BulletEngine implements IEngine
	{
		private var _factory:EntityFactory;
		
		function BulletEngine(factory:EntityFactory) 
		{
			_factory = factory;
		}
		
		public function accepts(obj:IComponent):Boolean
		{
			return (obj is IBulletShooter);
		}	
		
		public function add(c:IComponent):void
		{
			var bulletShooter:IBulletShooter = c as IBulletShooter;
			
			bulletShooter.shoot.add(shoot);
		}
		
		public function remove(c:IComponent):void
		{
			var bulletShooter:IBulletShooter = c as IBulletShooter;
			
			bulletShooter.shoot.remove(shoot);
		}
		
		private function shoot(bullet:BulletModel):void
		{
			_factory.Build(new BulletView(bullet), new BulletController(bullet));
		}
	}
}
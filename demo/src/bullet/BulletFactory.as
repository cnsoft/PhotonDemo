package bullet 
{
	import svelto.efw.entity.EntityFactory;
	import svelto.efw.entity.IEntity;
			
	public class BulletFactory
	{
		private var _factory:EntityFactory;
		
		function BulletFactory(entityFactory:EntityFactory) 
		{
			_factory = entityFactory;
		}
		
		public function Build(model:BulletModel):IEntity
		{
			return _factory.Build(new BulletView(model), new Bullet(model));
		}
	}
}
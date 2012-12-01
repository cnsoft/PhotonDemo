package character 
{
	import svelto.efw.entity.EntityFactory;
	import svelto.efw.entity.IEntity;
	import svelto.efw.plugins.camera2D.CameraTarget;
	
	public class CharacterFactory
	{
		private var _factory:EntityFactory;
		
		function CharacterFactory(entityFactory:EntityFactory) 
		{
			_factory = entityFactory;
		}
		
		public function BuildHostCharacter(model:CharacterModel):IEntity
		{
			return _factory.Build(		new CharacterView(model), 
										new CharacterFire(model),
										new CharacterPhysic(model),
										new Character(model),
										new CameraTarget(model.entityTransform));
		}
		
		public function BuildClientCharacter(model:CharacterModel):IEntity
		{
			return _factory.Build(	new CharacterView(model),
									new Character(model));
		}
	}
}
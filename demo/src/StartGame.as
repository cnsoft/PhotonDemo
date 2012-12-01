package  
{
	import bullet.BulletEngine;
	import bullet.BulletFactory;
	import character.CharacterEngine;
	import character.CharacterFactory;
	import flash.display.DisplayObjectContainer;
	import photon.ActorSpanwer;
	import photon.BulletSpawner;
	import svelto.efw.Context;
	import svelto.efw.entity.EntityDestroyer;
	import svelto.efw.entity.EntityFactory;
	import svelto.efw.plugins.camera2D.CameraEngine;
	import svelto.efw.plugins.collision.CollisionEngine;
	import svelto.efw.plugins.destroyer.DestroyerEngine;
	import svelto.efw.plugins.flash.FlashEngine;
	import svelto.efw.plugins.keyboard.KeyboardEngine;
	import svelto.efw.plugins.mouse.MouseEngine;
	import svelto.efw.plugins.simplephysic.PhysicEngine;
	import svelto.math.Vector2D;
	import svelto.ticker.Ticker;
	
	public class StartGame extends Context
	{
		private var _actorSpawner:ActorSpanwer;
		private var _bulletSpawner:BulletSpawner;
		
		function StartGame(layout:DisplayObjectContainer) 
		{
			super(new Ticker(layout.stage));
			
			var entityFactory:EntityFactory = new EntityFactory(this);
			var characterFactory:CharacterFactory = new CharacterFactory(entityFactory);
			var bulletFactory:BulletFactory = new BulletFactory(entityFactory);
			var entityDestroyer:EntityDestroyer = new EntityDestroyer(this);
			
			_actorSpawner = new ActorSpanwer(characterFactory, entityDestroyer);
			_bulletSpawner = new BulletSpawner(bulletFactory);
			
			addEngine(new FlashEngine(layout));
			addEngine(new CharacterEngine());
			addEngine(new CameraEngine(new Vector2D(layout.stage.stageWidth * 0.5, layout.stage.stageHeight * 0.5)));
			addEngine(new KeyboardEngine(layout.stage));
			addEngine(new BulletEngine(new BulletFactory(entityFactory)));
			addEngine(new MouseEngine(layout.stage));
			addEngine(new PhysicEngine());
			addEngine(new CollisionEngine());
			addEngine(new DestroyerEngine(entityDestroyer));
						
			addEntity(new Map());
		}
	}
}

package  
{
	import bullet.BulletEngine;
	import character.CharacterEngine;
	import flash.display.Stage;
	import flash.geom.Point;
	import svelto.efw.entity.EntityDestroyer;
	import svelto.efw.plugins.mouse.MouseEngine;
	import svelto.efw.plugins.physic.PhysicEngine;
	
	import photon.ActorSpanwer;
	
	import svelto.efw.component.IComponent;
	import svelto.efw.Context;
	import svelto.efw.entity.EntityFactory;
	import svelto.efw.plugins.camera2D.CameraEngine;
	import svelto.efw.plugins.flash.FlashEngine;
	import svelto.efw.plugins.keyboard.KeyboardEngine;
	
	import svelto.ticker.Ticker;
		
	public class StartGame extends Context
	{
		private var _actorSpawner:ActorSpanwer;
		
		function StartGame(stage:Stage) 
		{
			var entityFactory:EntityFactory = new EntityFactory(this);
			var entityDestroyer:EntityDestroyer = new EntityDestroyer(this);
			
			_actorSpawner = new ActorSpanwer(entityFactory, entityDestroyer, new GameInfo(stage));
			
			super(new Ticker(stage));
			
			addEngine(new FlashEngine(stage));
			addEngine(new CharacterEngine());
			addEngine(new CameraEngine());
			addEngine(new KeyboardEngine(stage));
			addEngine(new BulletEngine(entityFactory));
			addEngine(new MouseEngine(stage));
			addEngine(new PhysicEngine());
						
			addEntity(new Map());
		}
	}
}

package bullet 
{
	import flash.utils.Dictionary;
	import photon.ActorEvent;
	import photon.GameConstants;
	import photon.PhotonPeer;
	import svelto.dbc.*;
	import svelto.efw.component.IComponent;
	import svelto.efw.engine.IEngine;
	import svelto.efw.entity.EntityComponent;
	import svelto.ticker.ITickable;
	
	public class BulletEngine implements IEngine, ITickable
	{
		private var _factory:BulletFactory;
		private var _bullets:Dictionary;
		private var _dic:Dictionary;
		
		function BulletEngine(factory:BulletFactory) 
		{
			_factory = factory;
			_bullets = new Dictionary();
		}
		
		public function accepts(obj:IComponent):Boolean
		{
			return (obj is IBulletShooter) || (obj is IBulletComponent);
		}	
		
		public function add(e:EntityComponent):void
		{
			DesignByContract.Check::Require(e.component is IBulletShooter || e.component is IBulletComponent);
			
			var c:IComponent = e.component;
			
			if (c is IBulletShooter)
				(c as IBulletShooter).shoot.add(shoot);
			else
			{
				_bullets[c] = true;
			}
		}
		
		public function remove(c:IComponent):void
		{
			if (c is IBulletShooter)
				(c as IBulletShooter).shoot.remove(shoot);
			else
				delete _bullets[c];
		}
		
		private function shoot(model:BulletModel):void
		{	//find a solution to pool BulletView
			_factory.Build(model);
			model.id = PhotonPeer.getInstance().getActorNo();
			
			_dic = new Dictionary;
			
			_dic["x"] = model.entityTransform.pos.x;
			_dic["y"] = model.entityTransform.pos.y;
			_dic["r"] = model.rotation;
						
			PhotonPeer.getInstance().opRaiseEventWithCode(GameConstants.EV_FIRED, _dic, 0);
		}
		
		public function tick(timeDelta:Number):void
		{
			for (var obj:Object in _bullets)
			{
				var model:BulletModel = (obj as IBulletComponent).model;
				
				if (model.life <= 0)
					(obj as IBulletComponent).IAcceptDeathWithHonor();
				else
				{
					model.entityTransform.pos.plusEquals(model.direction.times(model.speed * timeDelta));
				
					model.life -= timeDelta;
				}
			}
		}
	}
}
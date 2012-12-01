package photon 
{
	import bullet.BulletFactory;
	import bullet.BulletModel;
	import flash.utils.Dictionary;
	import photon.PhotonPeer;
	
	public class BulletSpawner
	{
		private var _bulletEntities:Dictionary;
		private var _bulletFactory:BulletFactory;
		
		function BulletSpawner(entityFactor:BulletFactory)
		{
			_bulletEntities = new Dictionary;
			_bulletFactory = entityFactor;
			
			PhotonPeer.getInstance().addEventListener(ActorEvent.TYPE, onCustomEvent);
		}
		
		private function onCustomEvent(evt:ActorEvent):void
		{
			if (evt.getEventCode() != GameConstants.EV_FIRED)
				return;
				
			var model:BulletModel = new BulletModel;
			
			model.entityTransform.pos.setTo(evt.message["x"], evt.message["y"]);
			model.rotation = evt.message["r"];
			model.id = evt.getActorNo();
			model.speed = 550;
			model.life = 4;
			
			_bulletEntities[model] = _bulletFactory.Build(model);
		}
	}
}
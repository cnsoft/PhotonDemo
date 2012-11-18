package photon 
{
	import character.CharacterInput;
	import character.CharacterModel;
	import character.CharacterView;
	import de.exitgames.photon_as3.events.JoinEvent;
	import de.exitgames.photon_as3.events.LeaveEvent;
	import de.exitgames.photon_as3.loadBalancing.LoadBalancedPeer;
	import flash.utils.Dictionary;
	import photon.PhotonPeer;
	import svelto.efw.entity.EntityDestroyer;
	import svelto.efw.entity.EntityFactory;
	import svelto.efw.entity.IEntity;
	import svelto.efw.plugins.camera2D.CameraTarget;
	import svelto.math.Vector2D;
	
	public class ActorSpanwer
	{
		private var _entityFactory:EntityFactory;
		private var _entityDictionary:Dictionary;
		private var _entityDestroyer:EntityDestroyer;
		private var _gameInfo:GameInfo;
		
		function ActorSpanwer(entityFactor:EntityFactory, entityDestroyer:EntityDestroyer, gameInfo:GameInfo)
		{
			_entityDictionary = new Dictionary;
			_entityFactory = entityFactor;
			_entityDestroyer = entityDestroyer;
			
			_gameInfo = gameInfo;
			
			PhotonPeer.getInstance().addEventListener(JoinEvent.TYPE, onUserJoin);
			PhotonPeer.getInstance().addEventListener(LeaveEvent.TYPE, onUserLeft);
		}
		
		private function onUserJoin(evt:JoinEvent):void
		{
			var peer:LoadBalancedPeer = PhotonPeer.getInstance();
			
			if (evt.getActorNo() == peer.getActorNo())
			{
				var characterModel:CharacterModel = new CharacterModel();
				characterModel.id = peer.getActorNo();
				
				spawnActor(characterModel);
				
				updateUserList();
			}
			else
			{
				var characterServerModel:CharacterModel = new CharacterModel();
				characterServerModel.id = evt.getActorNo();
				
				_entityDictionary[characterServerModel.id] = spawnServerActor(characterServerModel);
			}
		}
		
		private function onUserLeft(evt:LeaveEvent):void
		{
			_entityDestroyer.Destroy(_entityDictionary[evt.getActorNo()]);
			
			delete _entityDictionary[evt.getActorNo()];
		}
		
		private function updateUserList():void
        {
			var peer:LoadBalancedPeer = PhotonPeer.getInstance();
            var l:Vector.<int> = peer.getActorNumbers();
            for (var i:int = 0; i < l.length; i++)
            {
				if (l[i] != peer.getActorNo())
				{
					var characterServerModel:CharacterModel = new CharacterModel();
					characterServerModel.id = l[i];
					
					_entityDictionary[characterServerModel.id] = spawnServerActor(characterServerModel);
				}
            }
        }
		
		private function spawnActor(characterModel:CharacterModel):IEntity
		{
			return _entityFactory.Build(new CharacterView(characterModel), 
										new CharacterInput(characterModel),
										new CameraTarget(characterModel.entityTransform, new Vector2D(_gameInfo.stage.stageWidth, _gameInfo.stage.stageHeight)),
										characterModel);
		}
		
		private function spawnServerActor(characterModel:CharacterModel):IEntity
		{
			return _entityFactory.Build(new CharacterView(characterModel),
										characterModel);
		}
	}
}
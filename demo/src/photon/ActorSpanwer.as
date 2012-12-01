package photon 
{
	import character.CharacterFactory;
	import character.CharacterModel;
	import de.exitgames.photon_as3.events.JoinEvent;
	import de.exitgames.photon_as3.events.LeaveEvent;
	import de.exitgames.photon_as3.loadBalancing.LoadBalancedPeer;
	import flash.utils.Dictionary;
	import photon.PhotonPeer;
	import svelto.efw.entity.EntityDestroyer;
	import svelto.efw.entity.EntityFactory;
	
	public class ActorSpanwer
	{
		private var _characterFactory:CharacterFactory;
		private var _charactersCreatedInThisWorld:Dictionary;
		private var _entityDestroyer:EntityDestroyer;
		
		function ActorSpanwer(entityFactor:CharacterFactory, entityDestroyer:EntityDestroyer)
		{
			_charactersCreatedInThisWorld = new Dictionary(true);
			_characterFactory = entityFactor;
			_entityDestroyer = entityDestroyer;
			
			PhotonPeer.getInstance().addEventListener(JoinEvent.TYPE, onUserJoin);
			PhotonPeer.getInstance().addEventListener(LeaveEvent.TYPE, onUserLeft);
		}
		
		private function onUserJoin(evt:JoinEvent):void
		{
			if (evt.getActorNo() == PhotonPeer.getInstance().getActorNo())
				IJustJoined();
			else
				aFriendJoined(evt.getActorNo());
		}
		
		private function onUserLeft(evt:LeaveEvent):void
		{
			if (_charactersCreatedInThisWorld[evt.getActorNo()] != undefined)
			{
				_entityDestroyer.Destroy(_charactersCreatedInThisWorld[evt.getActorNo()]);
			
				delete _charactersCreatedInThisWorld[evt.getActorNo()];
			}
		}
		
		private function IJustJoined():void 
		{
			var characterModel:CharacterModel = new CharacterModel();
			characterModel.id =  PhotonPeer.getInstance().getActorNo();
			
			_characterFactory.BuildHostCharacter(characterModel);
			
			addAlreadyJoinedCharacterAfterIJoined();
		}
		
		private function addAlreadyJoinedCharacterAfterIJoined():void
        {
			var peer:LoadBalancedPeer = PhotonPeer.getInstance();
            var l:Vector.<int> = peer.getActorNumbers();
            
			for (var i:int = 0; i < l.length; i++)
            {
				if (l[i] != peer.getActorNo())
				{
					var characterServerModel:CharacterModel = new CharacterModel();
					characterServerModel.id = l[i];
					
					_charactersCreatedInThisWorld[characterServerModel.id] = _characterFactory.BuildClientCharacter(characterServerModel);
				}
            }
        }
		
		private function aFriendJoined(friendID:int):void 
		{
			var characterServerModel:CharacterModel = new CharacterModel();
			characterServerModel.id = friendID;
			
			_charactersCreatedInThisWorld[characterServerModel.id] = _characterFactory.BuildClientCharacter(characterServerModel);
		}
	}
}
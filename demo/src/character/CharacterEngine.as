package character 
{
	import de.exitgames.photon_as3.util.DictionaryUtils;
	import flash.utils.Dictionary;
	import photon.ActorEvent;
	import photon.GameConstants;
	import photon.PhotonPeer;
	import svelto.efw.component.IComponent;
	import svelto.efw.engine.IEngine;
	import svelto.efw.plugins.camera2D.CameraTarget;
	import svelto.ticker.ITickable;
	
	public class CharacterEngine implements IEngine, ITickable
	{
		private var _timeCounter:Number;
		private var _dic:Dictionary;
		
		private var _clientAvatars:Dictionary;
		private var _cameraTarget:CameraTarget;
		private var _hostAvatar:CharacterModel;
		
		function CharacterEngine() 
		{
			_dic = new Dictionary;
			_timeCounter = 0;
			_clientAvatars = new Dictionary(true);
			
			PhotonPeer.getInstance().addEventListener(ActorEvent.TYPE, onCustomEvent);
		}
		
		public function accepts(obj:IComponent):Boolean
		{
			return (obj is CharacterModel) 
				|| (obj is CameraTarget);
		}	
		
		public function add(c:IComponent):void
		{
			if (c is CharacterModel)
			{
				if ((c as CharacterModel).id == PhotonPeer.getInstance().getActorNo())
					_hostAvatar = c as CharacterModel;
				else
					_clientAvatars[c] = true;
			}
			else
				_cameraTarget = c as CameraTarget;
		}
		
		public function remove(c:IComponent):void
		{
			if (c is CharacterModel)
			{
				if ((c as CharacterModel).id == PhotonPeer.getInstance().getActorNo())
					_hostAvatar = null;
				else
					delete _clientAvatars[c];
			}
			else
			if (_cameraTarget == c)
				_cameraTarget = null;
		}
		
		[MinFrequency(100)]
		public function tick(timeDelta:Number):void
		{
			if (_hostAvatar == null)
				return;
				
			_timeCounter += timeDelta;
			
			var model:CharacterModel = _hostAvatar;
				
			model.rotation = model.aim.plus(_cameraTarget.transform.pos).minusEquals(_cameraTarget.hsize).minusEquals(model.position).toAngleDeg();
				
			if (_timeCounter > 0.1)
			{
				_dic["x"] = model.entityTransform.pos.x;
				_dic["y"] = model.entityTransform.pos.y;
				_dic["r"] = model.rotation;
						
				PhotonPeer.getInstance().opRaiseEventWithCode(GameConstants.EV_SENDPOS, _dic, 0);
						
				_timeCounter = 0.1;
			}
		}
		
		private function onCustomEvent(evt:ActorEvent):void
		{
			for (var obj:Object in _clientAvatars)
			{
				var model:CharacterModel = obj as CharacterModel;
				
				if (evt.getActorNo() == model.id)
				{
					model.entityTransform.pos.setTo(evt.message["x"], evt.message["y"]);
					model.rotation = evt.message["r"];
				}
			}
		}
	}
}
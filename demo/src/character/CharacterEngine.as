package character 
{
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import photon.ActorEvent;
	import photon.GameConstants;
	import photon.PhotonPeer;
	import svelto.dbc.*;
	import svelto.efw.component.IComponent;
	import svelto.efw.engine.IEngine;
	import svelto.efw.entity.EntityComponent;
	import svelto.efw.plugins.camera2D.CameraTarget;
	import svelto.math.Vector2D;
	import svelto.ticker.ITickable;
	
	public class CharacterEngine implements IEngine, ITickable
	{
		private var _timeCounter:Number;
		private var _dic:Dictionary;
		
		private var _clientAvatars:Dictionary;
		private var _cameraTarget:CameraTarget;
		private var _hostAvatar:CharacterModel;
		
		private var _walls:Rectangle;
		
		function CharacterEngine() 
		{
			_dic = new Dictionary;
			_timeCounter = 0;
			_clientAvatars = new Dictionary(true);
			
			PhotonPeer.getInstance().addEventListener(ActorEvent.TYPE, onCustomEvent);
		}
		
		public function accepts(obj:IComponent):Boolean
		{
			return (obj is Character) 
				|| (obj is CameraTarget);
		}	
		
		public function add(e:EntityComponent):void
		{
			DesignByContract.Check::Require(e.component is Character || e.component is CameraTarget);
			
			var c:IComponent = e.component;
			
			if (c is Character)
			{
				var model:CharacterModel = (c as Character).model as CharacterModel;
				
				if (model.id == PhotonPeer.getInstance().getActorNo())
					_hostAvatar = model;
				else
					_clientAvatars[model] = true;
			}
			else
				_cameraTarget = c as CameraTarget;
		}
		
		public function remove(c:IComponent):void
		{
			DesignByContract.Check::Require(c is Character || c is CameraTarget);
			
			if (c is Character)
			{
				var model:CharacterModel = (c as Character).model;
				
				if (model.id == PhotonPeer.getInstance().getActorNo())
					_hostAvatar = null;
				else
					delete _clientAvatars[model];
			}
			else
			if (_cameraTarget == c)
				_cameraTarget = null;
		}
		
		[MinFrequency(100)] //the metatag is meaningless right now
		public function tick(timeDelta:Number):void
		{
			if (_hostAvatar == null)
				return;
				
			_timeCounter += timeDelta;
			
			var model:CharacterModel = _hostAvatar;
			
			if (model.energy > 0)
			{
				model.rotation = model.aim.plus(_cameraTarget.transform.pos).minusEquals(_cameraTarget.hsize).minusEquals(model.position).toAngleDeg();
				
				CheckHostCharacterPosition(model);
				
				if (_timeCounter > 0.04)
				{
					BroadcastMyPosition(model);
					
					_timeCounter = 0;
				}
			}
			else
				BroadcastDeath(model);
		}
		
		private function onCustomEvent(evt:ActorEvent):void
		{
			if (evt.getEventCode() == GameConstants.EV_SENDPOS)
				UpdateClientPosition(evt);
			else
			if (evt.getEventCode() == GameConstants.EV_DEAD)
				UpdateClientDeath(evt);
		}
		
		private function BroadcastMyPosition(model:CharacterModel):void 
		{
			_dic["x"] = model.entityTransform.pos.x;
			_dic["y"] = model.entityTransform.pos.y;
			_dic["r"] = model.rotation;
					
			PhotonPeer.getInstance().opRaiseEventWithCode(GameConstants.EV_SENDPOS, _dic, 0);
		}
		
		private function BroadcastDeath(model:CharacterModel):void 
		{
			model.reset();
			
			PhotonPeer.getInstance().opRaiseEventWithCode(GameConstants.EV_DEAD, _dic, 0);
		}
		
		private function UpdateClientPosition(evt:ActorEvent):void 
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
		
		private function UpdateClientDeath(evt:ActorEvent):void 
		{
			for (var obj:Object in _clientAvatars)
			{
				var model:CharacterModel = obj as CharacterModel;
				
				if (evt.getActorNo() == model.id)
					model.reset();
			}
		}
		
		private function CheckHostCharacterPosition(model:CharacterModel):void 
		{
			var pos:Vector2D = model.position;
			
			if (pos.y < 100)
				pos.y = 100;
			else
			if (pos.y > 1050)
				pos.y = 1050;
				
			if (pos.x < 50)
				pos.x = 50;
			else
			if (pos.x > 1950)
				pos.x = 1950;
		}
	}
}
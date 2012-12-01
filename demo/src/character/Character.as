package character 
{
	import flash.geom.Rectangle;
	import svelto.communication.signal.ISignal;
	import svelto.communication.signal.Signal;
	import svelto.efw.component.IComponentBroadcaster;
	import svelto.efw.plugins.collision.ICollidableComponent;
	import com.junkbyte.console.Cc;
	
	public class Character implements ICollidableComponent, IComponentBroadcaster
	{
		private var _model:CharacterModel;
		private var _hit:Signal;
		private var _hitMessage:HitMessage;
				
		function Character(characterModel:CharacterModel) 
		{
			_hit = new Signal();
			_model = characterModel;
			_hitMessage = new HitMessage;
		}
		
		public function get model():CharacterModel 		{ return _model; }
		
		public function get rect():Rectangle 			{ return _model.rect; }
		public function get layer():uint 				{ return 1; }
		
		public function onCollision(layer:int):void 	
		{ 
			_model.energy--; 
			_hit.dispatch(_hitMessage); 
			Cc.log("Character :" + _model.id + " hit!");
		}
		
		public function get send():ISignal 				{ return _hit; }
	}
}
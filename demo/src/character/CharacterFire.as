package character 
{
	import bullet.BulletModel;
	import bullet.IBulletShooter;
	import flash.events.MouseEvent;
	import svelto.efw.plugins.mouse.IMouseComponent;
	import svelto.efw.plugins.mouse.MetaEvent;
	import svelto.communication.signal.ISignal;
	import svelto.communication.signal.Signal;
	import svelto.math.Vector2D;
	
	public class CharacterFire implements IBulletShooter, IMouseComponent
	{
		private var _shoot:Signal;
		private var _characterModel:CharacterModel;
		private var _direction:Vector2D = new Vector2D();
		
		function CharacterFire(characterModel:CharacterModel) 
		{
			_shoot = new Signal();
			_characterModel = characterModel;
		}
		
		public function get shoot():ISignal { return _shoot; }
		
		[MetaEvent.MOUSE_EVENT(MetaEvent.CLICK)]
		public function fire(evt:MouseEvent):void
		{
			var bulletModel:BulletModel = new BulletModel; //find a solution to pool this
			
			_direction.fromRotation(_characterModel.rotation * (Math.PI / 180));
			var position:Vector2D = _characterModel.entityTransform.pos.plus(_direction.timesEqual(50.0));
			
			bulletModel.entityTransform.pos = position;
			bulletModel.rotation = _characterModel.rotation;
			bulletModel.speed = 550;
			bulletModel.life = 4;
			
			_shoot.dispatch(bulletModel);
		}
		
		[MetaEvent.MOUSE_EVENT(MetaEvent.MOUSEMOVE)]
		public function aim(evt:MouseEvent):void
		{
			_characterModel.aim.setTo(evt.stageX, evt.stageY);
		}
	}
}
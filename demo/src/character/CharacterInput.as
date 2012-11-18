package character 
{
	import bullet.BulletModel;
	import bullet.IBulletShooter;
	import flash.events.MouseEvent;
	import svelto.communication.signal.ISignal;
	import svelto.communication.signal.Signal;
	import svelto.efw.plugins.keyboard.enums.KeyMetaData;
	import svelto.efw.plugins.keyboard.enums.Keys;
	import svelto.efw.plugins.keyboard.IKeyboardComponent;
	import svelto.efw.plugins.mouse.IMouseComponent;
	import svelto.efw.plugins.physic.PhysicComponent;
	import svelto.math.Vector2D;
		
	public class CharacterInput extends PhysicComponent implements IKeyboardComponent, IBulletShooter, IMouseComponent
	{
		private var _characterModel:CharacterModel;
		private var _shoot:Signal;
		
		function CharacterInput(characterModel:CharacterModel) 
		{
			super(characterModel);
			_shoot = new Signal();
			_characterModel = characterModel;
		}
		
		public function get shoot():ISignal { return _shoot; }
		
		[KeyMetaData.BindKey(Keys.UP)]
		[KeyMetaData.BindKey(Keys.UP_2)]
		public function up():void
		{
			applyWorldForce(Vector2D.UP.times(200));
		}
	
		[KeyMetaData.BindKey(Keys.DOWN)]
		[KeyMetaData.BindKey(Keys.DOWN_2)]
		public function down():void
		{
			applyWorldForce(Vector2D.DN.times(200));
		}
		
		[KeyMetaData.BindKey(Keys.LEFT)]
		[KeyMetaData.BindKey(Keys.LEFT_2)]
		public function left():void
		{
			applyWorldForce(Vector2D.LT.times(200));
		}
		
		[KeyMetaData.BindKey(Keys.RIGHT)]
		[KeyMetaData.BindKey(Keys.RIGHT_2)]
		public function right():void
		{
			applyWorldForce(Vector2D.RT.times(200));
		}
		
		[MetaEvent.CLICK]
		public function fire(evt:MouseEvent):void
		{
			var bulletModel:BulletModel = new BulletModel;
			
			bulletModel.entityTransform.pos.copy(_characterModel.entityTransform.pos);
			
			_shoot.dispatch(bulletModel);
		}
		
		[MetaEvent.MOUSEMOVE]
		public function aim(evt:MouseEvent):void
		{
			_characterModel.aim.setTo(evt.stageX, evt.stageY);
		}
	}
}
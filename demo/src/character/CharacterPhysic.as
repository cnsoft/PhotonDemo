package character 
{
	import svelto.efw.plugins.keyboard.enums.KeyMetaData;
	import svelto.efw.plugins.keyboard.enums.Keys;
	import svelto.efw.plugins.keyboard.IKeyboardComponent;
	import svelto.efw.plugins.simplephysic.PhysicComponent;
	import svelto.math.Vector2D;
			
	public class CharacterPhysic extends PhysicComponent implements IKeyboardComponent
	{
		function CharacterPhysic(characterModel:CharacterModel) 
		{
			super(characterModel);
		}
		
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
	}
}
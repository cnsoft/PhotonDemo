package character
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import svelto.efw.plugins.camera2D.ITransformComponent;
	import svelto.efw.plugins.camera2D.Transformation;
	import svelto.efw.plugins.flash.IRenderableComponent;
	import svelto.communication.IListener;
				
	[Embed(source = "../../art/swf/character.swf", symbol="Character")]
	public class CharacterView extends Sprite implements IRenderableComponent, ITransformComponent, IListener
	{
		private var _characterModel:CharacterModel;
		private var _hitState:Boolean;
		private var _redMultiplier:Number;
		
		function CharacterView(transformation:CharacterModel)
		{
			_characterModel = transformation;
			addEventListener(Event.EXIT_FRAME, onExitFrame, false, 0, true);
			this.transform.colorTransform = new ColorTransform();
			_hitState = false;
			_redMultiplier = 1;
		}
		
		public function get worldTransform():Transformation { return _characterModel.entityTransform; }
		
		public function listen(message:*):void
		{
			if (message is HitMessage)
			{
				_hitState = true;
				_redMultiplier = 1;
			}
		}
		
		private function onExitFrame(evt:Event):void
		{
			this.rotation = _characterModel.rotation;
			
			if (_hitState == true)
			{
				var ct:ColorTransform  = this.transform.colorTransform;
				
				ct.greenMultiplier = 1 - _redMultiplier;
				ct.blueMultiplier = 1 - _redMultiplier;
				
				_redMultiplier -= 0.01;
				
				this.transform.colorTransform = ct;
				
				if (_redMultiplier <= 0)
				{
					_redMultiplier = 1;
					_hitState = false;
				}
			}
		}
	}
}
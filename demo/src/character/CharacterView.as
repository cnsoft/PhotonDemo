package character
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import svelto.efw.plugins.camera2D.ITransformComponent;
	import svelto.efw.plugins.camera2D.Transformation;
	import svelto.efw.plugins.flash.IRenderableComponent;
	import svelto.math.Vector2D;
			
	[Embed(source = "../../art/swf/character.swf", symbol="Character")]
	public class CharacterView extends Sprite implements IRenderableComponent, ITransformComponent
	{
		private var _characterModel:CharacterModel;
		
		function CharacterView(transformation:CharacterModel)
		{
			_characterModel = transformation;
			addEventListener(Event.EXIT_FRAME, onEnterFrame, false, 0, true);
		}
		
		public function get worldTransform():Transformation { return _characterModel.entityTransform; }
		
		private function onEnterFrame(evt:Event):void
		{
			this.rotation = _characterModel.rotation;
		}
	}
}
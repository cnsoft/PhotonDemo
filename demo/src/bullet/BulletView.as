package bullet 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import svelto.efw.plugins.flash.IRenderableComponent;
	import svelto.efw.plugins.camera2D.ITransformComponent;
	import svelto.efw.plugins.camera2D.Transformation;
	
	[Embed(source = "../../art/swf/character.swf", symbol="Fireball")]
	public class BulletView extends Sprite implements IRenderableComponent, ITransformComponent
	{
		private var _model:BulletModel;
		
		function BulletView(transformation:BulletModel)
		{
			_model = transformation;
			
			x = _model.entityTransform.pos.x - (this.width / 2);
			y = _model.entityTransform.pos.y - (this.height / 2);
		}
		
		public function get worldTransform():Transformation { return _model.entityTransform; }
	}
}
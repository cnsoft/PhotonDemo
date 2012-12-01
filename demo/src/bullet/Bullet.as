package bullet 
{
	import flash.geom.Rectangle;
	import svelto.communication.signal.ISignal;
	import svelto.communication.signal.Signal;
	import svelto.efw.plugins.collision.ICollidableComponent;
	
	public class Bullet implements ICollidableComponent, IBulletComponent
	{
		private var _model:BulletModel;
		private var _killMe:Signal;
		
		private var _rectangle:Rectangle = new Rectangle(-10, -10, 20, 20);
		
		//mainly we have two different communicato model, injected command and mediation through engines
		function Bullet(model:BulletModel) 
		{
			_killMe = new Signal();
			_model = model;
		}
		
		public function get rect():Rectangle { _rectangle.x = _model.entityTransform.pos.x-10; _rectangle.y = _model.entityTransform.pos.y-10; return _rectangle; }
		public function get layer():uint { return 0; }
		public function onCollision(layer:int):void 	{ IAcceptDeathWithHonor(); }
		
		public function get model():BulletModel { return _model; }
		
		public function get onDeath():ISignal { return _killMe; }
		public function IAcceptDeathWithHonor():void { _killMe.dispatch(null); }
	}
}
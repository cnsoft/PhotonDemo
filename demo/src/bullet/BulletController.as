package bullet 
{
	import svelto.ticker.ITickable;
	import svelto.efw.component.IComponent;
	
	public class BulletController implements ITickable, IComponent
	{
		private var _model:BulletModel;
		private var _timeCounter:Number;
		
		function BulletController(transformation:BulletModel)
		{
			_model = transformation;
		}
		
		public function tick(timeDelta:Number):void
		{
			_timeCounter += timeDelta;
			
			if (_timeCounter > 0.1)
				_timeCounter = 0.1;
		}
	}
}
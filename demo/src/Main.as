package 
{
	import com.junkbyte.console.Cc;
	import com.junkbyte.console.KeyBind;
	import flash.geom.Rectangle;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.ui.Keyboard;
	
	import photon.ConnectToServer;
	
	[SWF(frameRate="60")]
	public class Main extends Sprite 
	{
		private var connect:ConnectToServer;
		
		public function Main():void 
		{
			if (stage) 
				init();
			else 
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			Cc.startOnStage(this, "");
			Cc.bindKey(new KeyBind(Keyboard.TAB), function():void { Cc.visible = !Cc.visible; } );
			
			// entry point
			var layout:Sprite = new Sprite;
			addChild(layout);
			new StartGame(layout);
						
			connect = new ConnectToServer();
			connect.connect();
		}
	}
}
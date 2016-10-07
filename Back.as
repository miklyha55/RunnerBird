package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class Back extends MovieClip {
		
		private var bgLayer1:BgLayer;
		private var bgLayer2:BgLayer;
		
		private var _speed:Number = 5;
		
		
		public function Back() {
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			bgLayer1 = new BgLayer(2);
			bgLayer1.parallaxDepth = 0.02;
			this.addChild(bgLayer1);
			
			bgLayer2 = new BgLayer(1);
			bgLayer2.parallaxDepth = 0.5;
			this.addChild(bgLayer2);
			
			// Start animating the background.
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(event:Event):void
		{
				bgLayer1.x -= Math.ceil(_speed * bgLayer1.parallaxDepth);
				if (bgLayer1.x > 0) bgLayer1.x = -stage.stageWidth;
				if (bgLayer1.x < -stage.stageWidth ) bgLayer1.x = 0;
				

				bgLayer2.x -= Math.ceil(_speed * bgLayer2.parallaxDepth);
				if (bgLayer2.x > 0) bgLayer2.x = -stage.stageWidth;
				if (bgLayer2.x < -stage.stageWidth ) bgLayer2.x = 0;
		}
		
		public function get speed():Number { return _speed; }
		public function set speed(value:Number):void { _speed = value; }

	}
	
}

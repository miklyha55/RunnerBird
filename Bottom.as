package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.Sprite;
	
	
	public class Bottom extends MovieClip {
		
		private var stateSprite:int;
		private var image1:Sprite;
		private var image2:Sprite;
		private var parallaxDepth:Number;
		private var _speed:Number = 5;
		
		public function Bottom(_stateSprite:int) {
				super();
			
			this.stateSprite = _stateSprite;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			if(stateSprite == 1) {
				image1 = new Image3();
				image2 = new Image3();
			} else {
				image1 = new Image4();
				image2 = new Image4();
			}
			
			
			if(stateSprite == 1) {
				image1.x = 0;
				image1.y = 0;
				image2.x = image2.width;
				image2.y = 0;
			} else {
				image1.x = 0;
				image1.y = 0;
				image2.x = image2.width;
				image2.y = 0;
			}
			
			
			
			this.addChild(image1);
			this.addChild(image2);
		}

	}
	
}

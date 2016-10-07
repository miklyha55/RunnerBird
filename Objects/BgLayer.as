package  {

	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.display.BlendMode;
	
	public class BgLayer extends Sprite {
		
		private var _layer:int;
		private var image1:Sprite;
		private var image2:Sprite;
		
		private var _parallaxDepth:Number;

		public function BgLayer(_layer:int) {
			
			super();
			
			this._layer = _layer;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			if(_layer == 1) {
				image1 = new Image1();
				image2 = new Image1();
			} else {
				image1 = new Image2();
				image2 = new Image2();
			}
			
			image1.x = 0;
			if(_layer == 1) {
				image1.y = stage.stageHeight - image1.height;
			} else {
				image1.y = 80;
			}
			
			image2.x = image2.width;
			image2.y = image1.y;
			
			this.addChild(image1);
			this.addChild(image2);
			
		}
		
		public function get parallaxDepth():Number { return _parallaxDepth; }
		public function set parallaxDepth(value:Number):void { _parallaxDepth = value; }

	}
	
}

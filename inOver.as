package  {
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import inGame;
	import flash.display.Shape;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.net.URLRequest;

	
	public class inOver extends Sprite {
		
		private var btnReplay: Btn_replay;
		private var ingame:Object;
		public static var overscore:OverScore = new OverScore();
		private var back:Back;
		private var bonus:Bonus;
		
		
		
		private var rectangle: Shape = new Shape;
		
		public function inOver(_ingame:Object) {
			ingame = _ingame;
			trace(ingame);
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		private function onAddedToStage(event: Event): void {
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			initScreens();
			
		}
		private function initScreens(): void {
			
			btnReplay = new Btn_replay();
			this.addChild(btnReplay);
			
			back = new Back();
			this.addChildAt(back,0);
			
			this.addChild(overscore);
			
			overscore.x = stage.stageWidth / 2;
			overscore.y = stage.stageHeight / 5;
			
			btnReplay.x = stage.stageWidth / 2;
			btnReplay.y = stage.stageHeight / 1.3;
			
			btnReplay.addEventListener(MouseEvent.MOUSE_DOWN, onReplayClick);
			
			
			this.addChildAt(rectangle, 1);
			rectangle.graphics.beginFill(0xFFFFFF);
			rectangle.graphics.drawRect(0, overscore.y - 40, stage.stageWidth, overscore.height+ 40);
			rectangle.graphics.endFill();
			
			bonus = new Bonus();
			this.addChild(bonus);
			
			bonus.x = stage.stageWidth/1.6;
			bonus.y = overscore.height - bonus.height/2;
			bonus.visible = false;
			
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
		}
		
		private function onReplayClick(e: MouseEvent): void {
			Game.state = GameConstants.GAME;
			ingame.onRestartGame();
			
		}
		
		private function onEnterFrame(e: Event): void {
			if(ingame.heroState == GameConstants.DEAD && ingame.score == ingame.best && bonus.visible == false) bonus.visible = true;
			if(ingame.heroState == GameConstants.DEAD && ingame.score != ingame.best && bonus.visible == true) bonus.visible = false;
		}

	}
	
}

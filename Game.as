package {

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.StageScaleMode;
	import flash.display.Stage;

	public class Game extends Sprite {
		
		
		public static  var state:int;
		public static var paused:Boolean = false;
		
		private var ingame:inGame;
		private var inmenu:inMenu;
		private var inover:inOver;
		
		public function Game() {
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		private function onAddedToStage(event: Event): void {
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			stage.scaleMode = StageScaleMode.EXACT_FIT;
			initScreens();
			
		}
		
		private function initScreens(): void {
			state = GameConstants.MENU;	
			
			ingame = new inGame();
			this.addChild(ingame);
			ingame.visible = false;
	
			
			inmenu = new inMenu();
			this.addChild(inmenu);
			inmenu.visible = true;
			
			inover = new inOver(ingame);
			this.addChild(inover);
			inover.visible = false;
			
			this.addEventListener(Event.ENTER_FRAME, onStateGame);
		}
		
		private function onStateGame(e:Event):void {
			switch(state) {
				
				case GameConstants.MENU:
					if(inmenu.visible != true) inmenu.visible = true;
					if(ingame.visible != false) ingame.visible = false;
					if(inover.visible != false) inover.visible = false;
				break;
				
				case GameConstants.GAME:
					if(inmenu.visible != false) inmenu.visible = false;
					if(ingame.visible != true) ingame.visible = true;
					if(inover.visible != false) inover.visible = false;
				break;
				
				case GameConstants.OVER:
					if(inmenu.visible != false) inmenu.visible = false;
					if(ingame.visible != false) ingame.visible = false;
					if(inover.visible != true) inover.visible = true;
				break;
			}
		}
	}

}
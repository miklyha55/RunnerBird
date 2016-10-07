package  {
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class BorderUp extends Sprite {

		public function BorderUp() {
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		private function onAddedToStage(event: Event): void {
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			initScreens();
			
		}
		private function initScreens(): void {
		
		}

	}
	
}
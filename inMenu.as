package {

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.DataEvent;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.net.URLRequest;
	import flash.media.Sound;
	import flash.media.SoundChannel;

	public class inMenu extends Sprite {

		private var btnPlay: Btn_play;
		private var btnContin: Btn_contin;
		private var title: Title;
		private var back: Back;
		
		var myUrlMainSound:File = File.applicationDirectory.resolvePath("main.mp3");
		var mainSound:Sound;
		var soundChMain:SoundChannel;

		public function inMenu() {
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		private function onAddedToStage(event: Event): void {
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			initScreens();

		}
		private function initScreens(): void {
			
			if(myUrlMainSound.exists)
			{
				mainSound = new Sound();
				mainSound.load(new URLRequest(myUrlMainSound.url));
			}
			soundChMain = mainSound.play();
			soundChMain.addEventListener(Event.SOUND_COMPLETE, onSoundChannelSoundComplete);

			btnPlay = new Btn_play();
			//btnContin = new Btn_contin();
			this.addChild(btnPlay);
			//this.addChild(btnContin);

			title = new Title();
			this.addChildAt(title, 0);


			back = new Back();
			this.addChildAt(back, 0);

			title.x = stage.stageWidth / 2 - title.width / 2;
			title.y = 90;

			//btnContin.x = stage.stageWidth / 3;
			btnPlay.x = stage.stageWidth / 2;

			//btnContin.y = stage.stageHeight / 1.3;
			btnPlay.y = stage.stageHeight / 1.3;

			btnPlay.addEventListener(MouseEvent.MOUSE_DOWN, onPlayClick);
			//btnContin.addEventListener(MouseEvent.MOUSE_DOWN, onContinClick);

			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);

		}

		function onSoundChannelSoundComplete(e:Event)
		{
			soundChMain = mainSound.play();
			e.currentTarget.removeEventListener(Event.SOUND_COMPLETE, onSoundChannelSoundComplete);
			RestartMainSound();
		}
		function RestartMainSound()
		{
			soundChMain.addEventListener(Event.SOUND_COMPLETE, onSoundChannelSoundComplete);
		}
		
		private function onPlayClick(e: MouseEvent): void {
			Game.state = GameConstants.GAME;
		}

		private function onContinClick(e: MouseEvent): void {

		}
		private function onEnterFrame(e: Event): void {
			var currentDateBorder: Date = new Date;
			title.y = (90 + Math.cos(currentDateBorder.time * 0.002) * 10);
		}

	}

}
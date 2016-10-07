package  {
	import flash.display.Sprite;
	import net.hires.debug.Stats;
	
	public class RunnerBird extends Sprite {
		private var stats: Stats;
		private var game:Game;
		
		public function RunnerBird()  {
			
			game = new Game();
			this.addChild(game);
			
			stats = new Stats();
			game.addChild(stats);
			
		}

	}
	
}

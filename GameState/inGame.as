package {

	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.Shape;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import cv.Orion;
	import cv.orion.filters.*;
	import cv.orion.output.*;
	import flash.geom.Rectangle;
	import flash.events.DataEvent;
	import flash.geom.Point;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.net.URLRequest;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.SharedObject;
	
	import so.cuo.platform.chartboost.CBLocation;
	import so.cuo.platform.chartboost.Chartboost;
	import so.cuo.platform.chartboost.ChartboostEvent;


	public class inGame extends Sprite {

		private var hero: Hero;
		public var heroState: int;

		private var bottom: Bottom;
		private var bottomUp: Bottom;

		private var block: Block;
		private var block2: Block;
		private var blockLoop;
		private var blockPosY: int;

		public var back: Back;

		private var rocket: Rocket;
		private var rocketLoop: int;

		private var enemy: Enemy;
		private var enemyLoop: int;
		private var vspEnemy = 0;

		private var scoreMain: ScoreMain;

		private var vspStone = 0;
		private var stone: Stone;
		private var stoneLoop;

		private var copterLoop;

		private var borderrun: BorderRun;
		private var borderrun2: BorderRun;
		private var borderLoop: int;

		private var hintRocket: HintRocket;

		private var blockStar: StarBlock;
		private var blockStar2: StarBlock;
		private var blockStarLoop: int;

		private var btnStart: Btn_start;

		private var hsp = 0;
		private var vsp = 0;
		private var r;

		var pte: Orion;
		var ptePlane: Orion;
		var pteBee: Orion;

		private var tree: Tree;
		private var tree2: Tree;

		private var jump: Boolean = false;

		private var gravState: int;
		private var gameState: int;

		private var vBord: int;
		private var vBlock: int;
		private var vStone: int;
		private var vEnem: int;
		private var vRock: int;
		private var vCop: int;
		private var vStar: int;

		private var secondTimer: Timer = new Timer(500, 1);
		private var childTimer: Timer = new Timer(2000, 1);
		private var rectangle: Shape = new Shape;
		public var score: int = 0;
		public var best: int = 0;
		private var dist: int = 0;
		
		private var shakeRange:int = 3;
		
		var myUrlJumpSound:File = File.applicationDirectory.resolvePath("jump.mp3");
		var jumpSound:Sound;
		
		var myUrlHitSound:File = File.applicationDirectory.resolvePath("hit.mp3");
		var hitSound:Sound;
		
		var myUrlCoinSound:File = File.applicationDirectory.resolvePath("coin.mp3");
		var coinSound:Sound;
		
		var myUrlChangeSound:File = File.applicationDirectory.resolvePath("change.mp3");
		var changeSound:Sound;
		
		var myUrlChildSound:File = File.applicationDirectory.resolvePath("child.mp3");
		var childSound:Sound;
		
		var saveScore:SharedObject = SharedObject.getLocal("test");
		
		var chartboost:Chartboost;
		var appid:String="5528f3840d602565e9747682";
		var sign:String="8fe138e0e48d0073c137ae792ca2c1f6ceaaeaed";


		public function inGame() {
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		private function onAddedToStage(event: Event): void {
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			initScreens();

		}
		public function onTick(event: TimerEvent): void {
			rectangle.visible = true;
		}

		public function onTimerComplete(event: TimerEvent): void {
			rectangle.visible = false;
		}
		
		public function onTickChild(event: TimerEvent): void {
			childSound.play();
		}

		//встряхивание экрана
		private function Shake(target: Sprite): void {
			var randomActionX: int = Math.random() * 2;
			if (randomActionX == 0) {
				target.x += shakeRange;
			} else if (randomActionX == 1) {
				target.x -= shakeRange;
			}

			var randomActionY: int = Math.random() * 2;
			if (randomActionY == 0) {
				target.y += shakeRange;
			} else if (randomActionY == 1) {
				target.y -= shakeRange;
			}
		}


		private function initScreens(): void {
			
			if(myUrlChildSound.exists)
			{
				childSound = new Sound();
				childSound.load(new URLRequest(myUrlChildSound.url));
			}
			
			
			chartboost= Chartboost.getInstance();
			if (chartboost.supportDevice)
			{
				chartboost.setInterstitialKeys(this.appid, this.sign);
			}
			
			if(myUrlChangeSound.exists)
			{
				changeSound = new Sound();
				changeSound.load(new URLRequest(myUrlChangeSound.url));
			}
			
			
			if(myUrlJumpSound.exists)
			{
				jumpSound = new Sound();
				jumpSound.load(new URLRequest(myUrlJumpSound.url));
			}
			
			if(myUrlHitSound.exists)
			{
				hitSound = new Sound();
				hitSound.load(new URLRequest(myUrlHitSound.url));
			}
			
			if(myUrlCoinSound.exists)
			{
				coinSound = new Sound();
				coinSound.load(new URLRequest(myUrlCoinSound.url));
			}

			secondTimer.addEventListener(TimerEvent.TIMER, onTick);
			secondTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			
			childTimer.addEventListener(TimerEvent.TIMER, onTickChild);

			addChildAt(rectangle, 0);

			hero = new Hero();
			this.addChildAt(hero, 1);

			bottom = new Bottom(1);
			this.addChildAt(bottom, 0);

			bottomUp = new Bottom(2);
			this.addChildAt(bottomUp, 0);

			btnStart = new Btn_start();
			this.addChildAt(btnStart, 0);

			block = new Block();
			this.addChildAt(block, 0);

			block2 = new Block();
			this.addChildAt(block2, 0);

			rocket = new Rocket();
			this.addChildAt(rocket, 0);

			stone = new Stone();
			this.addChildAt(stone, 0);

			borderrun = new BorderRun();
			this.addChildAt(borderrun, 0);

			borderrun2 = new BorderRun();
			this.addChildAt(borderrun2, 0);

			enemy = new Enemy();
			this.addChildAt(enemy, 0);

			hintRocket = new HintRocket();
			this.addChildAt(hintRocket, 0);

			blockStar = new StarBlock();
			this.addChildAt(blockStar, 0);

			blockStar2 = new StarBlock();
			this.addChildAt(blockStar2, 0);

			scoreMain = new ScoreMain();
			addChild(scoreMain);

			tree = new Tree();
			this.addChildAt(tree, 0);

			tree2 = new Tree();
			this.addChildAt(tree2, 0);

			back = new Back()
			this.addChildAt(back, 0);


			onRestartGame();

			stone.visible = false;
			rocket.visible = false;
			block.visible = false;
			block2.visible = false;
			borderrun.visible = false;
			borderrun2.visible = false;
			blockStar.visible = false;
			blockStar2.visible = false;
			scoreMain.visible = false;
			tree.visible = false;
			tree2.visible = false;


		}

		public function onRestartGame(): void {
			
			chartboost.cacheInterstitial();
			
			if(saveScore.data.savedScore == null)
			{
				best = 0;
			}else{
				best = saveScore.data.savedScore;
			}

			if (hero.scaleY != 1) hero.scaleY = 1;

			dist = 0;

			vStone = 1;
			vBlock = 5;
			vBord = 4;
			vEnem = 2;
			vRock = 1;
			vCop = 7;
			vStar = 4;
			score = 0;

			blockLoop = vBlock;
			borderLoop = vBord;
			blockStarLoop = vStar;
			enemyLoop = vEnem;
			rocketLoop = vRock;
			copterLoop = vCop;
			stoneLoop = vStone;


			r = -20 + (1 - (-20)) * Math.random();
			hsp = 0;
			vsp = -7;
			vspStone = 0;
			vspEnemy = 0;
			hero.rotation = 1;
			heroState = GameConstants.JUMP;
			gravState = GameConstants.NORM_GRAV;
			gameState = GameConstants.MAX_SPEED;

			hero.x = stage.stageWidth / 2;
			hero.y = stage.stageHeight / 1.8;

			bottom.x = 0;
			bottom.y = stage.stageHeight - bottom.height;

			bottomUp.x = 0;
			bottomUp.y = bottomUp.height;
			bottomUp.scaleY = -1;

			btnStart.x = stage.stageWidth / 2;
			btnStart.y = stage.stageHeight / 2.8;
			btnStart.addEventListener(MouseEvent.MOUSE_DOWN, onStartClick);


			block.x = stage.stageWidth + 5;
			block.y = bottom.y - block.height + 5;
			block.visible = true;

			tree.x = stage.stageWidth + 5;
			tree.y = bottom.y - tree.height + 5;
			tree.visible = true;

			tree2.x = stage.stageWidth + stage.stageWidth / 1.4;
			tree2.y = bottom.y - tree2.height + 5;
			tree2.visible = true;

			block2.x = stage.stageWidth + stage.stageWidth / 2;
			block2.y = bottom.y - block2.height + 5;
			block2.visible = true;

			rocket.x = stage.stageWidth + stage.stageWidth;
			rocket.y = (bottomUp.y + 50) + Math.random() * 300;
			rocket.visible = true;

			hintRocket.x = stage.stageWidth - 150;
			hintRocket.y = rocket.y;
			hintRocket.visible = true;

			stone.x = stage.stageWidth + 60;
			stone.y = bottomUp.y + Math.random() * 400;
			stone.visible = true;

			borderrun.x = stage.stageWidth;
			borderrun.y = bottom.y - borderrun.height + 5;
			borderrun.visible = true;

			borderrun2.x = stage.stageWidth + stage.stageWidth / 2;
			borderrun2.y = bottom.y - borderrun2.height + 5;
			borderrun2.visible = true;

			enemy.x = stage.stageWidth + 30;
			enemy.y = stage.stageHeight / 2 - enemy.height / 2;
			enemy.visible = true;

			blockStar.x = stage.stageWidth;
			blockStar.y = (bottomUp.y + 50) + Math.random() * 150;
			blockStar.visible = true;

			blockStar2.x = stage.stageWidth + stage.stageWidth / 2;
			blockStar2.y = (bottomUp.y + 50) + Math.random() * 150;
			blockStar2.visible = true;

			scoreMain.x = stage.stageWidth / 2;
			scoreMain.y = 10;
			scoreMain.visible = true;
			onUpdateScore();

			rectangle.graphics.beginFill(0xFFFFFF);
			rectangle.graphics.drawRect((stage.stageWidth - hero.width * 2) / 2, 0, hero.width * 2, bottom.y);
			rectangle.graphics.endFill();
			rectangle.visible = false;

			if (!secondTimer.running) {
				rectangle.visible = true;
				secondTimer.start();
			}
		}

		private function onUpdateScore(): void {
			scoreMain.score.text = "" + score;
			scoreMain.dist.text = "" + dist;
			inOver.overscore.score.text = "Score: " + score;
			if(saveScore.data.savedScore == null)
			{
				inOver.overscore.best.text = "Best: " + best;
			}else{
				inOver.overscore.best.text = "Best: " + saveScore.data.savedScore;
			}
			
			inOver.overscore.dist.text = "Distance: " + dist;
		}

		private function onStartClick(e: MouseEvent): void {

			vsp = -7;
/*
			if (!secondTimer.running) {
				rectangle.visible = true;
				secondTimer.start();
			}*/

			this.addEventListener(Event.ENTER_FRAME, onUpdate);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onClickDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, onClickUp);
			hero.visible = true;
			btnStart.visible = false;

			block.visible = true;
			block2.visible = true;
			stone.visible = true;
			rocket.visible = true;
			borderrun.visible = true;
			borderrun2.visible = true;
			enemy.visible = true;
			hintRocket.visible = true;
			blockStar.visible = true;
			blockStar2.visible = true;
			scoreMain.visible = true;
			tree.visible = true;
			tree2.visible = true;

			pte = new Orion(Partic, new SteadyOutput(10));
			pte.x = hero.x - hero.width / 2;
			pte.y = hero.y + hero.height / 2;
			pte.canvas = new Rectangle(0, 0, 200, 200);
			pte.settings.alpha = .8;
			pte.settings.lifeSpan = 400;
			pte.settings.velocityXMin = -20;
			pte.settings.velocityXMax = -18;
			pte.settings.scaleMin = 0.2;
			pte.settings.scaleMax = 0.5;
			addChild(pte);
			
			ptePlane = new Orion(Partic, new SteadyOutput(10));
			ptePlane.x = rocket.x + rocket.width;
			ptePlane.y = rocket.y + rocket.height / 2;
			ptePlane.canvas = new Rectangle(0, 0, 200, 200);
			ptePlane.settings.alpha = .8;
			ptePlane.settings.lifeSpan = 400;
			ptePlane.settings.velocityXMin = 20;
			ptePlane.settings.velocityXMax = 18;
			ptePlane.settings.scaleMin = 0.2;
			ptePlane.settings.scaleMax = 0.5;
			addChild(ptePlane);
			
			pteBee = new Orion(Partic, new SteadyOutput(10));
			pteBee.x = stone.x + stone.width;
			pteBee.y = stone.y + stone.height / 2;
			pteBee.canvas = new Rectangle(0, 0, 200, 200);
			pteBee.settings.alpha = .8;
			pteBee.settings.lifeSpan = 400;
			pteBee.settings.velocityXMin = 20;
			pteBee.settings.velocityXMax = 18;
			pteBee.settings.scaleMin = 0.2;
			pteBee.settings.scaleMax = 0.5;
			addChild(pteBee);

		}

		private function onClickDown(e: MouseEvent): void {
			jump = true;
			if (heroState == GameConstants.CHANGE_GRAV) {
				jumpSound.play();
				if (gravState == GameConstants.NEG_GRAV) {
					gravState = GameConstants.NORM_GRAV;
				} else {
					gravState = GameConstants.NEG_GRAV;
				}
			}
			if(heroState == GameConstants.JETPACK) jumpSound.play();
		}

		private function onClickUp(e: MouseEvent): void {
			jump = false;
		}

		private function onUpdate(e: Event): void {

			if (!Game.paused) {

				if (heroState != GameConstants.DEAD) dist++;
				onUpdateScore();

				bottom.x -= Math.ceil(GameConstants.SPEED + 2);
				if (bottom.x > 0) bottom.x = -stage.stageWidth;
				if (bottom.x < -stage.stageWidth) bottom.x = -2;


				bottomUp.x -= Math.ceil(GameConstants.SPEED * 0.2);
				if (bottomUp.x > 0) bottomUp.x = -stage.stageWidth;
				if (bottomUp.x < -stage.stageWidth) bottomUp.x = -2;

				ptePlane.x = rocket.x + rocket.width;
				ptePlane.y = rocket.y + rocket.height / 2;
				
				pteBee.x = stone.x + stone.width;
				pteBee.y = stone.y + stone.height / 2;

				pte.x = hero.x - hero.width / 1.4;
				pte.y = hero.y;

				tree.x -= GameConstants.SPEED - 2;
				tree2.x -= GameConstants.SPEED - 2;
				if (tree.x < -tree.width) tree.x = stage.stageWidth + 5;
				if (tree2.x < -tree2.width) tree2.x = stage.stageWidth + 5;
				
				//состояния героя
				switch (heroState) {
					case GameConstants.JUMP:

						if (hero.currentFrameLabel != "jump") {
							changeSound.play();
							rectangle.visible = true;
							secondTimer.start();
							hero.gotoAndPlay("jump");
						}
						vsp += GameConstants.GRAVITY;

						if (hero.hitTestObject(bottom)) {
							hero.rotation = 0;
							hero.y = bottom.y - hero.height / 2 + 4;
							vsp = 0;

							if (jump) {
								jumpSound.play();
								vsp = -GameConstants.JUMP_SPEED;
								hero.rotation = -30;
								jump = false;
							}

						}
						hero.y += vsp;

						break;

					case GameConstants.FLAPPY:

						if (hero.currentFrameLabel != "flappy") {
							changeSound.play();
							rectangle.visible = true;
							secondTimer.start();
							hero.gotoAndPlay("flappy");
						}
						//hsp = GameConstants.SPEED;
						vsp += GameConstants.GRAVITY;

						if (hero.hitTestObject(bottomUp)) {
							vsp = GameConstants.JUMP_SPEED / 2;
						}
						if (hero.hitTestObject(bottom)) {
							vsp = -GameConstants.JUMP_SPEED / 1.2;
						}

						if (jump) {
							jumpSound.play();
							hero.rotation = -30;
							vsp = -GameConstants.JUMP_SPEED / 1.6;
							jump = false;
						} else {
							hero.rotation = 0;
						}

						hero.y += vsp;

						break;

					case GameConstants.JETPACK:

						if (hero.currentFrameLabel != "jet") {
							changeSound.play();
							rectangle.visible = true;
							secondTimer.start();
							hero.gotoAndPlay("jet");
						}
						vsp += GameConstants.GRAVITY - 0.4;

						if (hero.hitTestObject(bottomUp)) {
							hero.rotation = 0;
							vsp = GameConstants.JUMP_SPEED / 2;
						}

						if (hero.hitTestObject(bottom)) {
							hero.rotation = 0;
							vsp = -GameConstants.JUMP_SPEED / 1.8;
						}

						if (jump) {
							hero.rotation += 1;
							vsp += -GameConstants.JET_SPEED;
						} else {
							if (hero.rotation > -15) hero.rotation -= 1;
						}

						hero.y += vsp;
						break;

					case GameConstants.CHANGE_GRAV:

						if (hero.currentFrameLabel != "grav") {
							changeSound.play();
							rectangle.visible = true;
							secondTimer.start();
							hero.gotoAndPlay("grav");
						}
						//hsp = GameConstants.SPEED;

						switch (gravState) {
							case GameConstants.NORM_GRAV:
								if (hero.rotation != 0) hero.rotation = 0;
								hero.scaleY = 1
								vsp += GameConstants.GRAVITY;
								break;

							case GameConstants.NEG_GRAV:
								if (hero.rotation != 0) hero.rotation = 0;
								hero.scaleY = -1;
								vsp -= GameConstants.GRAVITY;
								break;
						}

						if (hero.hitTestObject(bottomUp)) {
							vsp = GameConstants.JUMP_SPEED / 3;
						}

						if (hero.hitTestObject(bottom)) {
							vsp = -GameConstants.JUMP_SPEED / 3;
						}

						hero.y += vsp;
						break;

					case GameConstants.DEAD:
						
						if(chartboost.isInterstitialReady()){
							chartboost.showInterstitial();
						}
						
						hsp = r;
						vsp += GameConstants.GRAVITY + 1;
						if (vsp < 0) {
							Shake(this);
						} else {
							this.x = 0;
							this.y = 0;
						}
						hero.rotation += 40;
						hero.x += hsp;
						hero.y += vsp;
						rocketLoop = 0;

						if (hero.y > stage.width) {
							Game.state = GameConstants.OVER;
						}
						break;

					case GameConstants.VICTORY:

						break;
				}
				//состояние игровой сессии
				switch (gameState) {
					case GameConstants.MAX_SPEED:

						var currentDateBorder: Date = new Date;
						borderrun.y = ((bottom.y + 18) - borderrun.height) + 12 + (Math.cos(currentDateBorder.time * 0.002) * 30);
						borderrun2.y = ((bottom.y + 18) - borderrun2.height) + 12 + (Math.cos(currentDateBorder.time * 0.002) * 30);

						borderrun.x -= GameConstants.SPEED + 2;
						borderrun2.x -= GameConstants.SPEED + 2;
						if (borderrun.x < -90) {
							if (heroState != GameConstants.DEAD) {score++; coinSound.play();}
							onUpdateScore();

							borderLoop--;
							borderrun.x = stage.stageWidth;
							borderrun.y = bottom.y - borderrun.height + 5;
							if (borderLoop < 0) {
								if (heroState != GameConstants.DEAD) {
									gameState = GameConstants.ROCKETS;
									heroState = GameConstants.CHANGE_GRAV;
									hintRocket.gotoAndPlay(2);
									vsp = -15;
								}

								borderrun2.x = stage.stageWidth + stage.stageWidth / 2;
								borderrun2.y = bottom.y - borderrun2.height + 5;
							}
						}
						if (borderrun2.x < -90) {
							if (heroState != GameConstants.DEAD) {score++; coinSound.play();}
							onUpdateScore();

							borderLoop--;
							borderrun2.x = stage.stageWidth;
							borderrun2.y = bottom.y - borderrun2.height + 5;
							if (borderLoop < 0) {
								if (heroState != GameConstants.DEAD) {
									gameState = GameConstants.ROCKETS;
									heroState = GameConstants.CHANGE_GRAV;
									hintRocket.gotoAndPlay(2);
									vsp = -15;
								}

								borderrun.x = stage.stageWidth + stage.stageWidth / 2;
								borderrun.y = bottom.y - borderrun.height + 5;
							}
						}
						break;
					case GameConstants.BLOKS:

						if (hero.scaleY != 1) hero.scaleY = 1;
						block.x -= GameConstants.SPEED + 1;
						block2.x -= GameConstants.SPEED + 1;
						if (block.x < -100) {
							if (heroState != GameConstants.DEAD) {score++; coinSound.play();}
							onUpdateScore();

							blockLoop--;
							block.x = stage.stageWidth + 5;
							//block.gotoAndStop();

							blockPosY = Math.random() * 3;
							//trace(blockPosY);
							block.gotoAndStop(1 + blockPosY);
							if (blockPosY == 1) {
								block.y = bottomUp.y - 25;
							} else if (blockPosY == 2) {
								block.y = bottom.y - block.height + 5;
							} else {
								block.gotoAndStop(2);
								block.y = stage.stageHeight / 2 - block.height / 2;

							}

							if (blockLoop < 0) {
								if (heroState != GameConstants.DEAD) {
									if (hero.rotation != 0) hero.rotation = 0;
									gameState = GameConstants.ENEMYS;
									heroState = GameConstants.JUMP;
								}
								block2.x = stage.stageWidth + stage.stageWidth / 2;

								blockPosY = Math.random() * 3;
								//trace(blockPosY);
								block2.gotoAndStop(1 + blockPosY);
								if (blockPosY == 1) {
									block2.y = bottomUp.y - 25;
								} else if (blockPosY == 2) {
									block2.y = bottom.y - block2.height + 5;
								} else {
									block2.gotoAndStop(2);
									block2.y = stage.stageHeight / 2 - block2.height / 2;
								}
							}
						}
						if (block2.x < -100) {
							if (heroState != GameConstants.DEAD) {score++; coinSound.play();}
							onUpdateScore();

							blockLoop--;
							block2.x = stage.stageWidth + 5;

							blockPosY = Math.random() * 3;
							//trace(blockPosY);
							block2.gotoAndStop(1 + blockPosY);
							if (blockPosY == 1) {
								block2.y = bottomUp.y - 25;
							} else if (blockPosY == 2) {
								block2.y = bottom.y - block2.height + 5;
							} else {
								block2.gotoAndStop(2);
								block2.y = stage.stageHeight / 2 - block2.height / 2;
							}

							if (blockLoop < 0) {
								if (heroState != GameConstants.DEAD) {
									if (hero.rotation != 0) hero.rotation = 0;
									gameState = GameConstants.ENEMYS;
									heroState = GameConstants.JUMP;
								}
								block.x = stage.stageWidth + stage.stageWidth / 2;

								blockPosY = Math.random() * 3;
								//trace(blockPosY);
								block.gotoAndStop(1 + blockPosY);
								if (blockPosY == 1) {
									block.y = bottomUp.y - 25;
								} else if (blockPosY == 2) {
									block.y = bottom.y - block.height + 5;
								} else {
									block.gotoAndStop(2);
									block.y = stage.stageHeight / 2 - block.height / 2;
								}
							}
						}

						break;
					case GameConstants.ROCKETS:

						rocket.x -= GameConstants.SPEED + 15;
						if (rocket.x < -300) {
							if (heroState != GameConstants.DEAD) {score++; coinSound.play();}
							onUpdateScore();

							rocketLoop--;
							if (rocketLoop >= 0) {
								hintRocket.visible = true;
								hintRocket.gotoAndPlay(2);
							}
							rocket.x = stage.stageWidth + stage.stageWidth;
							rocket.y = (bottomUp.y + 50) + Math.random() * 300;
							hintRocket.y = rocket.y;

							if (rocketLoop < 0) {
								if (heroState != GameConstants.DEAD) {
									if (hero.y > stage.stageHeight / 2) vsp = -15;
									gameState = GameConstants.BLOKS;
									heroState = GameConstants.FLAPPY;

								}
								rocket.x = stage.stageWidth + stage.stageWidth;
								rocket.y = bottomUp.y + Math.random() * 300;
								hintRocket.y = rocket.y;
							}
						}
						break;
					case GameConstants.STONES:
						stone.x -= GameConstants.SPEED + 1;
						vspStone += GameConstants.GRAVITY;

						if (stone.hitTestObject(bottom)) {
							vspStone = -GameConstants.JUMP_SPEED - 12;
						}
						stone.y += vspStone;
						if (stone.x < -100) {
							if (heroState != GameConstants.DEAD) {score++; coinSound.play();}
							onUpdateScore();

							stoneLoop--;
							stone.x = stage.stageWidth + 60;

							if (stoneLoop < 1) {
								if (heroState != GameConstants.DEAD) {
									gameState = GameConstants.MARIO;
									heroState = GameConstants.FLAPPY;
								}
								stone.x = stage.stageWidth + 60;
								stone.y = bottomUp.y + Math.random() * 400;
							}
						}

						break;
					case GameConstants.ENEMYS:
						enemy.x -= GameConstants.SPEED + 0.4;
						vspEnemy += GameConstants.GRAVITY;

						if (enemy.hitTestObject(bottom)) {
							vspEnemy = -16;
						}
						enemy.y += vspEnemy;

						if (enemy.x < -100) {
							if (heroState != GameConstants.DEAD) {score++; coinSound.play();}
							onUpdateScore();

							enemyLoop--;
							enemy.x = stage.stageWidth + 30;
							if (enemyLoop < 1) {
								if (heroState != GameConstants.DEAD) {
									hero.y = hero.y - 25;
									gameState = GameConstants.COPTERS;
									heroState = GameConstants.JETPACK;
									vsp = -15;

								}
								enemy.y = stage.stageHeight / 2 - enemy.height / 2;
							}
						}
						break;
					case GameConstants.COPTERS:

						block.x -= GameConstants.SPEED + 1;
						block2.x -= GameConstants.SPEED + 1;
						if (block.x < -100) {
							if (heroState != GameConstants.DEAD) {score++; coinSound.play();}
							onUpdateScore();

							copterLoop--;
							block.x = stage.stageWidth + 5;
							//block.gotoAndStop();

							blockPosY = Math.random() * 3;
							//trace(blockPosY);
							block.gotoAndStop(1 + blockPosY);
							if (blockPosY == 1) {
								block.y = bottomUp.y - 25;
							} else if (blockPosY == 2) {
								block.y = bottom.y - block.height + 5;
							} else {
								block.gotoAndStop(2);
								block.y = stage.stageHeight / 2 - block.height / 2;

							}

							if (copterLoop < 0) {
								if (heroState != GameConstants.DEAD) {
									gameState = GameConstants.STONES;
									heroState = GameConstants.CHANGE_GRAV;
								}
								block2.x = stage.stageWidth + stage.stageWidth / 2;

								blockPosY = Math.random() * 3;
								//trace(blockPosY);
								block2.gotoAndStop(1 + blockPosY);
								if (blockPosY == 1) {
									block2.y = bottomUp.y - 25;
								} else if (blockPosY == 2) {
									block2.y = bottom.y - block2.height + 5;
								} else {
									block2.gotoAndStop(2);
									block2.y = stage.stageHeight / 2 - block2.height / 2;
								}
							}
						}
						if (block2.x < -100) {
							if (heroState != GameConstants.DEAD) {score++; coinSound.play();}
							onUpdateScore();

							copterLoop--;
							block2.x = stage.stageWidth + 5;

							blockPosY = Math.random() * 3;
							//trace(blockPosY);
							block2.gotoAndStop(1 + blockPosY);
							if (blockPosY == 1) {
								block2.y = bottomUp.y - 25;
							} else if (blockPosY == 2) {
								block2.y = bottom.y - block2.height + 5;
							} else {
								block2.gotoAndStop(2);
								block2.y = stage.stageHeight / 2 - block2.height / 2;
							}

							if (copterLoop < 0) {
								if (heroState != GameConstants.DEAD) {
									gameState = GameConstants.STONES;
									heroState = GameConstants.CHANGE_GRAV;
								}
								block.x = stage.stageWidth + stage.stageWidth / 2;

								blockPosY = Math.random() * 3;
								//trace(blockPosY);
								block.gotoAndStop(1 + blockPosY);
								if (blockPosY == 1) {
									block.y = bottomUp.y - 25;
								} else if (blockPosY == 2) {
									block.y = bottom.y - block.height + 5;
								} else {
									block.gotoAndStop(2);
									block.y = stage.stageHeight / 2 - block.height / 2;
								}
							}
						}
						break;

					case GameConstants.MARIO:
						
						enemy.x -= GameConstants.SPEED + 0.4;
						vspEnemy += GameConstants.GRAVITY;

						if (enemy.hitTestObject(bottom)) {
							vspEnemy = -13;
						}
						enemy.y += vspEnemy;

						if (enemy.x < -100) {
							enemy.x = stage.stageWidth + 30;
						}
						
						if (hero.scaleY != 1) hero.scaleY = 1;
						blockStar.x -= GameConstants.SPEED;
						blockStar2.x -= GameConstants.SPEED;

						if (hero.collUp.hitTestObject(blockStar) && blockStar.visible == true && heroState != GameConstants.DEAD) {
							coinSound.play();
							blockStar.visible = false;
							vsp = GameConstants.JUMP_SPEED / 3;
							score++;
							onUpdateScore();
						}
						if (hero.collUp.hitTestObject(blockStar2) && blockStar2.visible == true && heroState != GameConstants.DEAD) {
							coinSound.play();
							blockStar2.visible = false;
							vsp = GameConstants.JUMP_SPEED / 3;
							score++;
							onUpdateScore();
						}

						if (blockStar.x < -50) {

							if (blockStar.visible == false) blockStar.visible = true;
							blockStarLoop--;
							blockStar.x = stage.stageWidth;
							blockStar.y = (bottomUp.y + 50) + Math.random() * 150;
							if (blockStarLoop < 1) {
								if (heroState != GameConstants.DEAD) {

									if (blockStar2.visible == false) blockStar2.visible = true;
									vStone++;
									vBlock++;
									vBord++;
									vEnem++;
									vRock++;
									vCop++;
									vStar++;

									blockLoop = vBlock;
									borderLoop = vBord;
									blockStarLoop = vStar;
									enemyLoop = vEnem;
									rocketLoop = vRock;
									copterLoop = vCop;
									stoneLoop = vStone;

									if (hero.rotation != 0) hero.rotation = 0;

									hintRocket.visible = true;
									//if(hero.scaleY != 1)hero.scaleY = 1;
									blockStar2.x = stage.stageWidth + stage.width / 2;
									blockStar2.y = (bottomUp.y + 50) + Math.random() * 150;
									
									enemy.x = stage.stageWidth + 30;
									enemy.y = stage.stageHeight / 2 - enemy.height / 2;

									gameState = GameConstants.MAX_SPEED;
									heroState = GameConstants.JUMP;
								}
							}
						}
						if (blockStar2.x < -50) {

							if (blockStar2.visible == false) blockStar2.visible = true;
							blockStarLoop--;
							blockStar2.x = stage.stageWidth;
							blockStar2.y = (bottomUp.y + 50) + Math.random() * 150;
							if (blockStarLoop < 1) {
								if (heroState != GameConstants.DEAD) {

									if (blockStar.visible == false) blockStar.visible = true;
									vStone++;
									vBlock++;
									vBord++;
									vEnem++;
									vRock++;
									vCop++;
									vStar++;

									blockLoop = vBlock;
									borderLoop = vBord;
									blockStarLoop = vStar;
									enemyLoop = vEnem;
									rocketLoop = vRock;
									copterLoop = vCop;
									stoneLoop = vStone;

									if (hero.rotation != 0) hero.rotation = 0;

									hintRocket.visible = true;
									blockStar.x = stage.stageWidth + stage.width / 2;
									blockStar.y = (bottomUp.y + 50) + Math.random() * 150;
									
									enemy.x = stage.stageWidth + 30;
									enemy.y = stage.stageHeight / 2 - enemy.height / 2;

									gameState = GameConstants.MAX_SPEED;
									heroState = GameConstants.JUMP;
								}
							}
						}
						break;
				}
				//столкновения с героем
				if (hero.coll.hitTestObject(blockStar2) && blockStar2.visible == true || hero.coll.hitTestObject(blockStar) && blockStar.visible == true || hero.coll.hitTestObject(enemy.coll) || hero.coll.hitTestObject(borderrun2) || hero.coll.hitTestObject(borderrun) || hero.coll.hitTestObject(block2) || hero.coll.hitTestObject(block) || hero.coll.hitTestObject(rocket) || hero.coll.hitTestObject(stone)) {
					if (heroState != GameConstants.DEAD) {
						if (score > best) {
							best = score;
							saveScore.data.savedScore = best;
							childTimer.start();
						}
						onUpdateScore();
						vsp = -20;
						hitSound.play();
					}
					heroState = GameConstants.DEAD;
					

				}
			}
		}
	}

}
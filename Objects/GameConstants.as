package  {
	
	public class GameConstants {
		//состояние мэна
		
		//обычный прыжок
		public static const JUMP:int = 1;
		//управление как во флаппи берд
		public static const FLAPPY:int = 2;
		//джетпак управление как в вертолетике
		public static const JETPACK:int = 3;
		//смена гравитации при нажатии на экран
		public static const CHANGE_GRAV:int = 4;
		//победа
		public static const DEAD:int = 5;
		//поражение
		public static const VICTORY:int = 6;
		
		//тип блоков
		
		//квадрат
		public static const BLOCK_1:int = 1;
		//прямоугольник горизонтальный
		public static const BLOCK_2:int = 2;
		//прямоугольник вертикальный
		public static const BLOCK_3:int = 3;
		//ромб
		public static const BLOCK_4:int = 4;
		//круг
		public static const BLOCK_5:int = 5;
		//треугольник
		public static const BLOCK_6:int = 6;
		
		//тип врагов
		
		//влево вправо
		public static const ENEMY_1:int = 1;
		//вверх вниз
		public static const ENEMY_2:int = 2;
		//следит за тобой
		public static const ENEMY_3:int = 3;
		//подлетае влево вправо
		public static const ENEMY_4:int = 4;
		//прыгает на месте
		public static const ENEMY_5:int = 5;
		
		//гравитация
		public static const GRAVITY:int = 1.2;
		
		//скорость
		public static const SPEED:int = 8;
		
		//скорость прыжка
		public static const JUMP_SPEED:int = 20;
		
		//скорость джета
		public static const JET_SPEED:int = 2;
		
		
		//состояние игры
		public static const MENU:int = 1;
		public static const GAME:int = 2;
		public static const OVER:int = 3;
		
		//состояние гравитации
		public static const NORM_GRAV:int = 1;
		public static const NEG_GRAV:int = 2;
		
		//режим блоков
		public static const BORDER_MOVE:int = 1;
		public static const BORDER_STOP:int = 2;
		
		//режим игровой сессии
		public static const BLOKS:int = 1;
		public static const ROCKETS:int = 2;
		public static const STONES:int = 3;
		public static const MAX_SPEED:int = 4;
		public static const ENEMYS:int = 5;
		public static const COPTERS:int = 6;
		public static const MARIO:int = 7;
		

	}
	
}

package
{
	import org.flixel.*;

	//Invader State
	public class PlayState extends FlxState
	{
		private var player:PlayerShip;
		private var playerBullets:FlxGroup;
		private var enemyBullets:FlxGroup;

		private var smallShips:FlxGroup;

		override public function create():void
		{
			// create bullets
			playerBullets = new FlxGroup();
			add(playerBullets);
			enemyBullets = new FlxGroup();
			add(enemyBullets);

			var i:int;
			for (i = 0; i <= 50; i++)
			{
				var b:Bullet = new Bullet();
				b.kill();
				playerBullets.add(b);
				b = new Bullet();
				b.kill();
				enemyBullets.add(b);
			}
			player = new PlayerShip(320, FlxG.height - 50, playerBullets);
			add(player);

			smallShips = new FlxGroup();
			add(smallShips);
			var offset:int = 60;
			for (var n:int; n <= 5; n++)
			{
				for (i = 0; i <= 10; i++)
				{
					smallShips.add(new SmallEnemy(i*50 + offset, n * 20 + offset, enemyBullets));
				}
			}
		}
	}
}

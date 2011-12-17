package
{
	import org.flixel.*;
	public class SpaceState extends FlxState
	{
		private var player:SpacePlayer

		private var playerBullets:FlxGroup;
		private var enemyBullets:FlxGroup;

		override public function create():void
		{
			FlxG.log("hello");
			// create bullets
			playerBullets = new FlxGroup();
			add(playerBullets);
			enemyBullets = new FlxGroup();
			add(enemyBullets);

			FlxG.log("bullets");
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

			FlxG.log("player");

			//player = new SpacePlayer((FlxG.width - player.width) / 2, (FlxG.height - player.height) /2);
			player = new SpacePlayer(30,30);
			player.x = (FlxG.width - player.width ) /2
			player.y = (FlxG.height + player.height ) /2
			add(player);
			FlxG.log("bye");

		}
	}
}

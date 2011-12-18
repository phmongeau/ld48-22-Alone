package
{
	import org.flixel.*;
	public class SpaceState extends FlxState
	{
		[Embed (source="/data/planet.png")] private var ImgPlanet:Class;

		private var player:SpacePlayer

		private var playerBullets:FlxGroup;
		private var enemyBullets:FlxGroup;
		private var flock:FlxGroup;
		private var stars:FlxGroup;

		private var planet:FlxSprite;

		override public function create():void
		{
			//stars
			stars = makeStars(300, 1);
			add(stars);

			planet = new FlxSprite(7000, 7000);
			planet.loadGraphic(ImgPlanet);
			add(planet);

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


			//player = new SpacePlayer((FlxG.width - player.width) / 2, (FlxG.height - player.height) /2);
			player = new SpacePlayer(0,0);
			player.x = (FlxG.width - player.width ) /2
			player.y = (FlxG.height + player.height ) /2
			add(player);

			flock = new FlxGroup();
			add(flock);

			//flock.add(player);

			var test:FlockShip = new FlockShip(100,100,player);
			test.flock = flock;
			//test.velocity.x = 100;
			//test.velocity.y = 50;
			flock.add(test);

			for (i = 0; i <= 50; ++i)
			{
				//var f:FlockShip = new FlockShip(Math.random() * 200 - 100, Math.random() * 200 - 100, test);
				var f:FlockShip = new FlockShip(Math.random() * 640, Math.random() * 480, test);
				f.target = flock.getRandom() as FlxSprite;
				f.flock = flock;
				flock.add(f);
			}
			//var offset:int = 60;
			//for (var n:int; n <= 5; n++)
			//{
				//for (i = 0; i <= 10; i++)
				//{
					////smallShips.add(new SmallEnemy(i*50 + offset, n * 20 + offset, enemyBullets));
					//var f:FlockShip = new FlockShip(i * 50 + offset, n * 20 + offset, test);
					//f.target = flock.getRandom() as FlxSprite;
					//f.flock = flock;
					//flock.add(f);
				//}
			//}


			FlxG.camera.follow(player);

			FlxG.watch(player, "x", "playerX");
			FlxG.watch(player, "y", "playerY");

		}

		override public function update():void
		{
			if(player.overlaps(planet))
			{
				FlxG.fade(0xffffffff, 1, onWin);
			}
			
			if(dist(player, flock.getRandom() as FlxSprite) > 640 * 4)
			{
				FlxG.fade(0xffffffff, 1, onLost);
			}

			//Stars
			for each(var s:FlxSprite in stars.members)
			{
				if(s.x < player.x - FlxG.width/2) s.x = player.x + FlxG.width/2;
				if(s.x > player.x + FlxG.width/2) s.x = player.x - FlxG.width/2;
				if(s.y < player.y - FlxG.height/2) s.y = player.y + FlxG.height/2;
				if(s.y > player.y + FlxG.height/2) s.y = player.y - FlxG.height/2;
			}

			super.update();
		}

		private function makeStars(n:int, s:Number, color:uint=0xffffffff):FlxGroup
		{
			var group:FlxGroup = new FlxGroup();
			//group.scrollFactor = new FlxPoint(s,s);

			var i:int;
			for (i = 0; i <= n; ++i)
			{
				//var sp:FlxSprite = new FlxSprite(Math.random() * s * 1000, Math.random() * s * 1000)
				var sp:FlxSprite = new FlxSprite(Math.random() * FlxG.width, Math.random() * FlxG.height)
				sp.makeGraphic(1, 1, color);
				sp.scrollFactor = new FlxPoint(s,s);
				group.add(sp);
			}
			return group;
		}
		
		private function onWin():void
		{
			FlxG.switchState(new MenuState());
		}
		private function onLost():void
		{
			FlxG.switchState(new AloneState("You got lost\n you are now alone."));
		}

		private function dist(s1:FlxSprite, s2:FlxSprite):Number
		{
			var deltaX:Number = Math.abs(s1.x - s2.x);
			var deltaY:Number = Math.abs(s1.y - s2.y);

			return Math.sqrt(deltaX * deltaX + deltaY * deltaY);
		}
	}
}

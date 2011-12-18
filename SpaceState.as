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

		public var killCount:uint;

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


			FlxG.camera.follow(player);

			FlxG.watch(player, "x", "playerX");
			FlxG.watch(player, "y", "playerY");
			FlxG.watch(this, "killCount", "killCount");

		}

		override public function update():void
		{
			FlxG.worldBounds = new FlxRect(player.x - FlxG.width/2, player.y - FlxG.height/2, FlxG.width, FlxG.height);
			FlxG.overlap(flock, player.bullets, onKill);
			if(player.overlaps(planet))
			{
				FlxG.fade(0xffffffff, 1, onWin);
			}
			
			if(dist(player, flock.getFirstAlive() as FlxSprite) > 640 * 2)
			{
				FlxG.fade(0xffffffff, 1, onLost);
			}

			if(killCount > 40)
			{
				FlxG.switchState(new AloneState("And now you are alone\n maybe you shouldn't have kille them all"));
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

		private function onKill(a:FlxSprite, b:FlxSprite):void
		{
			a.kill();
			b.kill();
			killCount++;
		}
		
		private function onWin():void
		{
			FlxG.switchState(new WinState());
		}
		private function onLost():void
		{
			FlxG.switchState(new AloneState("You got lost\n you are now alone."));
		}

		private function dist(s1:FlxSprite, s2:FlxSprite):Number
		{
			FlxG.log(s2.x);
			if(!s1.x || !s2.x ) return 20000;
			var deltaX:Number = Math.abs(s1.x - s2.x);
			var deltaY:Number = Math.abs(s1.y - s2.y);

			return Math.sqrt(deltaX * deltaX + deltaY * deltaY);
		}
	}
}

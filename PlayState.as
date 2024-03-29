package
{
	import org.flixel.*;

	//Invader State
	public class PlayState extends FlxState
	{
		[Embed (source="/data/explosion.mp3")] private var SndExplosion:Class;

		private var player:PlayerShip;
		private var playerBullets:FlxGroup;
		private var enemyBullets:FlxGroup;

		private var smallShips:FlxGroup;
		
		public var killCount:int = 0;

		private var msgBox:FlxText;

		private var emitter:FlxEmitter;

		private var chainReaction:Boolean = false;

		override public function create():void
		{
			FlxG.worldBounds = new FlxRect(0,0, FlxG.width, FlxG.height);
			FlxG.flash(0x00ffffff, 1);

			//emitter
			emitter = new FlxEmitter();
			var i:int;
			for (i = 0; i < 10; i++)
			{
				var particle:FlxParticle = new FlxParticle();
				particle.makeGraphic(4, 4, 0xFFFFFFFF);
				particle.kill();
				emitter.add(particle);
			}
			add(emitter);

			// create bullets
			playerBullets = new FlxGroup();
			add(playerBullets);
			enemyBullets = new FlxGroup();
			add(enemyBullets);

			for (i = 0; i <= 50; i++)
			{
				var b:Bullet = new Bullet();
				b.kill();
				playerBullets.add(b);
				b = new Bullet();
				b.kill();
				enemyBullets.add(b);
			}
			player = new PlayerShip(320, FlxG.height - 70, playerBullets);
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

			FlxG.watch(this, "killCount", "killCount");


			msgBox = new FlxText(0, FlxG.height - 30, FlxG.width);
			msgBox.alignment = "center";
			msgBox.text = "Incoming Message [press X]"
			msgBox.visible = false;
			msgBox.size = 8;
			add(msgBox);
		}

		override public function update():void
		{
			super.update();

			FlxG.overlap(playerBullets, smallShips, onSmallOverlap)
			if(chainReaction)
				FlxG.overlap(emitter, smallShips, onSmallOverlap)

			if(killCount >= 10)
			{
				if(!msgBox.visible)
				{
					FlxG.flash(0xffffffff, 0.8);
					msgBox.visible = true;
				}

				if(FlxG.keys.X)
				{
					FlxG.switchState(new MessageState);
				}
			}


			if(killCount >= 66)
			{
				FlxG.switchState(new AloneState("You are now alone\n maybe you shouldn't have killed them all"));
			}

			if (FlxG.debug)
			{
				if(FlxG.keys.justPressed('Z'))
				{
					FlxG.switchState(new SpaceState())
				}
			}

			//Popcorn
			if(FlxG.keys.justPressed("C")) chainReaction = !chainReaction;
		}

		private function onSmallOverlap(b:FlxSprite, e:FlxSprite):void
		{
			b.kill();
			e.kill();
			killCount++;
			FlxG.play(SndExplosion);
			emitter.kill();
			emitter.at(e);
			emitter.start();
		}
	}
}

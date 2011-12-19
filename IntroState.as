package
{

	import org.flixel.*;
	
	public class IntroState extends  FlxState
	{
		[Embed (source="/data/earth_top.png")] private var ImgEarth:Class;
		[Embed (source="/data/ship.png")] private var ImgShip:Class;
		[Embed (source="/data/smoke.png")] private var ImgSmoke:Class;
		[Embed (source="/data/launch.mp3")] private var SndLaunch:Class;
		
		private var timer:Number;
		private var earth:FlxSprite;
		private var ship:FlxSprite;
		private var emitter:FlxEmitter;

		override public function create():void
		{
			earth = new FlxSprite(0, FlxG.height);
			earth.loadGraphic(ImgEarth);
			earth.velocity.y = -30;
			add(earth);

			ship = new FlxSprite((FlxG.width - 20)/2, FlxG.height - 40);
			ship.loadGraphic(ImgShip);
			ship.visible = false;
			add(ship);
			
			emitter = new FlxEmitter();
			emitter.makeParticles(ImgSmoke, 100, 16, false, 0);
			emitter.setYSpeed(60,60);
			emitter.setXSpeed(20,-20);
			add(emitter);

			timer = 0;
		}

		override public function update():void
		{
			timer += FlxG.elapsed;
			FlxG.log(timer);
			if(FlxG.keys.justPressed('X'))
			{
				FlxG.switchState(new PlayState);
			}

			if(timer > 2)
			{
				earth.velocity.y = 0;
				if(!ship.visible)
				{
					ship.visible = true;
					ship.acceleration.y = -500;
					emitter.start(false, 0, 0.05);
					FlxG.play(SndLaunch);
				}
				emitter.at(ship);
			}

			if (ship.y < -200)
			{
				FlxG.fade(0xffffffff, 0.5, function():void
				{
					FlxG.switchState(new PlayState());
				});
			}

			super.update();
		}
	}
	
}

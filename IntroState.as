package
{

	import org.flixel.*;
	
	public class IntroState extends  FlxState
	{
		[Embed (source="/data/earth_top.png")] private var ImgEarth:Class;
		
		private var timer:Number;
		private var earth:FlxSprite;
		override public function create():void
		{
			earth = new FlxSprite(0, FlxG.height);
			earth.loadGraphic(ImgEarth);
			earth.velocity.y = -30;
			add(earth);
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
			}
			super.update();
		}
	}
	
}

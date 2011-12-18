package
{
	import org.flixel.*;

	public class WinState extends FlxState
	{
		private var msg:String;
		public function WinState(msg:String = "Looks like you Won")
		{
			this.msg = msg;
		}
		override public function create():void
		{
			var t:FlxText;
			t = new FlxText(0,FlxG.height/2-10,FlxG.width,msg);
			t.size = 16;
			t.alignment = "center";
			add(t);
			t = new FlxText(FlxG.width/2-50,FlxG.height-20,100,"click to replay");
			t.alignment = "center";
			add(t);
			
			FlxG.mouse.show();
		}

		override public function update():void
		{
			super.update();

			if(FlxG.mouse.justPressed())
			{
				FlxG.mouse.hide();
				FlxG.switchState(new IntroState());
			}
			else if(FlxG.keys.justPressed("SPACE"))
			{
				FlxG.switchState(new IntroState());
			}
		}
	}
}

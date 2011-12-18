package
{
	import org.flixel.*

	public class Bullet extends FlxSprite
	{
		public function Bullet( X:Number = 0, Y:Number = 0):void
		{
			super(X,Y);
			makeGraphic(2, 8, 0xffffffff);
		}

		override public function update():void
		{
			super.update();
			if(y < 0 || y > FlxG.height)
				kill();
		}
	}
}


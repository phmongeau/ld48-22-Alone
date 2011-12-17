package
{
	import org.flixel.*

	public class SmallEnemy extends FlxSprite
	{
		[Embed (source="/data/small_enemy.png")] private var ImgShip:Class;

		private var bullets:FlxGroup;
		public function SmallEnemy(X:Number, Y:Number, Bullets:FlxGroup):void
		{
			super(X,Y);
			loadGraphic(ImgShip);

			bullets = Bullets;
		}

		override public function update():void
		{
			super.update();
			 //code...
		}
	}
}


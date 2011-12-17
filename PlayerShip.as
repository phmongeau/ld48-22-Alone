package
{
	import org.flixel.*

	public class PlayerShip extends FlxSprite
	{
		[Embed (source="/data/ship.png")] private var ImgShip:Class;

		private	var lateralSpeed:Number = 600;
		private var bullets:FlxGroup;
		public function PlayerShip( X:Number, Y:Number):void
		{
			super(X,Y);
			loadGraphic(ImgShip);
			maxVelocity.x = 800;

			bullets = new FlxGroup();
			FlxG.state.add(bullets);

			for (var i:int = 0; i < 1; i++) {
				var b:Bullet = new Bullet(0,0);
				b.kill();
				bullets.add(b);
			}
		}

		override public function update():void
		{
			// Controlls:
			// Movement
			if(FlxG.keys.LEFT)
			{
				velocity.x -= lateralSpeed * FlxG.elapsed;
			}
			else if(FlxG.keys.RIGHT)
			{
				velocity.x += lateralSpeed * FlxG.elapsed;
			}
			else
			{
				velocity.x *= 0.77;
			}

			//Shoot
			if(FlxG.keys.justPressed('SPACE'))
			{
				shoot()
			}

			super.update();
		}

		private function shoot():void
		{
			var b:FlxSprite = bullets.getFirstAvailable() as FlxSprite;
			if(b == null)
			{
				b = new Bullet(0,0);
				bullets.add(b);
			}
			b.reset(x + width / 2, y);
			b.velocity.y = -500;
		}
	}
}


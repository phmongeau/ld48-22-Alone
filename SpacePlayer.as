package
{
	import org.flixel.*;	

	public class SpacePlayer extends FlxSprite
	{
		[Embed (source="/data/ship.png")] private var ImgShip:Class;

		private var speed:Number;
		private var maxSpeed:Number;
		private var radAngle:Number;

		public function SpacePlayer(X:Number, Y:Number)
		{
			super(X,Y);
			loadGraphic(ImgShip);

			speed = 0;
			maxSpeed = 200;
			maxAngular = 200;
			angularDrag = 150;

		}

		override public function update():void
		{
			if(FlxG.keys.LEFT) angularVelocity -= 10;
			if(FlxG.keys.RIGHT) angularVelocity += 10;
			if(FlxG.keys.UP) speed += 5;
			if(FlxG.keys.DOWN) speed -= 5;


			if(speed > maxSpeed) speed = maxSpeed;
			else if(speed < (-1 * maxSpeed)) speed = -1 * maxSpeed;

			radAngle = (angle - 90) * (Math.PI / 180);

			velocity.x = speed * Math.cos(radAngle);
			velocity.y = speed * Math.sin(radAngle);

			super.update()
		}
	}
}

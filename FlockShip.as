
package
{
	import org.flixel.*;	

	public class FlockShip extends FlxSprite
	{
		[Embed (source="/data/small_enemy.png")] private var ImgShip:Class;

		private var speed:Number;
		private var maxSpeed:Number;
		private var radAngle:Number;
		public var target:FlxSprite;
		private var speedModifier:Number;
		private var flock:FlxGroup;

		public function FlockShip(X:Number, Y:Number, Target:FlxSprite = null)
		{
			super(X,Y);
			loadGraphic(ImgShip);

			target = Target;

			speed = 0;
			speedModifier = (Math.random() + 1) * 1.5;
			maxSpeed = 90;
			maxAngular = 200;
			angularDrag = 150;

		}

		override public function update():void
		{
			//AI goes here
			var pos:FlxPoint = new FlxPoint(x,y);
			var tpos:FlxPoint = new FlxPoint(target.x, target.y);
			var targetAngle:Number = FlxU.getAngle(pos, tpos);

			if(targetAngle + 90 > angle) angularVelocity += 10;
			if(targetAngle + 90 < angle) angularVelocity -= 10;

			if(dist() > 50) speed = dist() * Math.random() * speedModifier;
			else if(speed > 10) speed -= 1;
	
			//---------------------------------------

			if(speed > maxSpeed) speed = maxSpeed;
			else if(speed < (-1 * maxSpeed)) speed = -1 * maxSpeed;

			radAngle = (angle + 180) * (Math.PI / 180);

			velocity.x = speed * Math.cos(radAngle);
			velocity.y = speed * Math.sin(radAngle);

			super.update()
		}

		private function dist():Number
		{
			var deltaX:Number = Math.abs(target.x - x);
			var deltaY:Number = Math.abs(target.y - y);

			return Math.sqrt(deltaX * deltaX + deltaY * deltaY);
		}
	}
}

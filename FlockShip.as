
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
		public var flock:FlxGroup;

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

			maxVelocity = new FlxPoint(100,100);

		}

		override public function update():void
		{
			//AI goes here
			var v1:FlxPoint = calculateV1();
			var v2:FlxPoint = calculateV2();
			var v3:FlxPoint = calculateV3();
			//var v4:FlxPoint = new FlxPoint(Math.random() * 10, Math.random() * 10);
			var v4:FlxPoint = new FlxPoint(10,10);
			
			velocity.x += (v1.x + v2.x + v3.x + v4.x * 0.1) * 0.1;
			velocity.y += (v1.y + v2.y + v3.y + v4.x * 0.1) * 0.1;

			angle = FlxU.getAngle(new FlxPoint(x,y), velocity);

			super.update()
		}

		private function dist(tx:Number, ty:Number):Number
		{
			var deltaX:Number = Math.abs(tx - x);
			var deltaY:Number = Math.abs(ty - y);

			return Math.sqrt(deltaX * deltaX + deltaY * deltaY);
		}

		private function calculateV1():FlxPoint
		{
			// Average position
			var average:FlxPoint = new FlxPoint();
			var count:uint;
			for each(var s:FlxSprite in flock.members)
			{
				if(s != this && dist(s.x, s.y) < 100)
				{
					average.x += s.x;
					average.y += s.y;
					++count;
				}
			}
			average.x /= count;
			average.y /= count;

			average.x = (average.x - x) / 100;
			average.y = (average.y - y) / 100;
			return average;
		}
		private function calculateV2():FlxPoint
		{
			// Repulsion
			var repulsion:FlxPoint = new FlxPoint();
			for each(var s:FlxSprite in flock.members)
			{
				if(s != this && dist(s.x, s.y) < 20)
				{
					repulsion.x -= s.x - x;
					repulsion.y -= s.y - y;
				}
			}
			return repulsion
		}
		private function calculateV3():FlxPoint
		{
			//Average velocity
			var vel:FlxPoint = new FlxPoint();
			var count:uint;
			for each(var s:FlxSprite in flock.members)
			{
				if(s != this && dist(s.x, s.y) < 100)
				{
					vel.x += s.velocity.x;
					vel.y += s.velocity.y;
					++count;
				}
			}

			vel.x /= count;
			vel.y /= count;

			vel.x /= 8;
			vel.y /= 8;

			return vel;

		}
	}
}

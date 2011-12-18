package
{
	import org.flixel.*;	

	public class SpacePlayer extends FlxSprite
	{
		[Embed (source="/data/ship.png")] private var ImgShip:Class;

		private var speed:Number;
		private var maxSpeed:Number;
		private var radAngle:Number;

		public var bullets:FlxGroup;

		public function SpacePlayer(X:Number, Y:Number)
		{
			super(X,Y);
			loadGraphic(ImgShip);

			speed = 0;
			maxSpeed = 200;
			maxAngular = 200;
			angularDrag = 150;

			bullets = createBullets(50);
			FlxG.state.add(bullets);

		}

		override public function update():void
		{
			if(FlxG.keys.LEFT) angularVelocity -= 10;
			if(FlxG.keys.RIGHT) angularVelocity += 10;
			if(FlxG.keys.UP) speed += 5;
			if(FlxG.keys.DOWN) speed -= 5;

			if(FlxG.keys.justPressed('SPACE')) fire();


			if(speed > maxSpeed) speed = maxSpeed;
			else if(speed < (-1 * maxSpeed)) speed = -1 * maxSpeed;

			radAngle = (angle - 90) * (Math.PI / 180);

			velocity.x = speed * Math.cos(radAngle);
			velocity.y = speed * Math.sin(radAngle);

			//Bullets

			for each (var s:FlxSprite in bullets.members)
			{
				var pos:FlxPoint = s.getScreenXY();
				if(pos.x < 0 || pos.x > FlxG.width || pos.y < 0 || pos.y > FlxG.height)
				{
					s.kill();
				}
			}

			super.update()
		}

		private function fire():void
		{
			var bullet:FlxSprite = bullets.getFirstDead() as FlxSprite;
			bullet.reset(x,y);
			if (velocity.x > 0)
				bullet.velocity.x = velocity.x * 2;
			else 
				bullet.velocity.x = velocity.x * 2;
			if (velocity.y > 0)
				bullet.velocity.y = velocity.y * 2;
			else
				bullet.velocity.y = velocity.y * 2;

			bullet.angle = angle - 90;
		}

		private function createBullets(n:int):FlxGroup
		{
			var group:FlxGroup = new FlxGroup();
			var i:int;
			for(i = 0; i<= n; ++i)
			{
				var b:FlxSprite = new FlxSprite();
				b.makeGraphic(8,2, 0xffffffff);
				b.kill();
				group.add(b);
			}
			return group;
		}
	}
}

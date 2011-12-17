package
{
	import org.flixel.*;

	//Invader State
	public class PlayState extends FlxState
	{
		private var player:PlayerShip;
		override public function create():void
		{
			player = new PlayerShip(320, FlxG.height - 50);
			add(player);
		}
	}
}

package
{
	import org.flixel.*;
	[SWF(width="640", height="480", backgroundColor="#000000")]
	[Frame(factoryClass="Preloader")]

	public class Alone extends FlxGame
	{
		public function Alone()
		{
			super(640,480,MenuState,1);
			//FlxG.debug = true;
		}
	}
}

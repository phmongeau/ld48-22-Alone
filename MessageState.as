package 
{
	import org.flixel.*;

	public class MessageState extends FlxState
	{

		private var msg:FlxText;
		private var messages:Array;
		private var i:int;

		private var instr:FlxText;
		override public function create():void
		{
			messages = new Array;
			messages.push("Please stop all hostillity!");
			messages.push("We know it's a shock to realize\n you are not alone,...");
			messages.push("But it's not a reason to kill us!");
			messages.push("Silly humans!");
			msg = new FlxText(0, FlxG.height/2, FlxG.width);
			msg.alignment = "center";
			msg.size = 16;
			msg.text = messages[i]
			add(msg);

			instr = new FlxText(0, FlxG.height - 30, FlxG.width);
			instr.alignment = "center";
			instr.text = "press X"
			add(instr);
		}

		override public function update():void
		{
			super.update();
			msg.text = messages[i];

			if(FlxG.keys.justPressed('X'))
			{
				i++;
				FlxG.flash(0xffffffff, 0.5);
			}

			if(i >= messages.length)
			{
				FlxG.switchState(new MenuState());
			}
		}
	}
}

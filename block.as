package{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	public class block extends MovieClip{
	var timer:Timer = new Timer(4000);
	var speed:Number = new Number;
		public function block(s:Number){
			speed = s;
			addEventListener(Event.ENTER_FRAME,myFunction);
		}
		function myFunction(event:Event) {
			this.y += speed;
		}

	}
}
		
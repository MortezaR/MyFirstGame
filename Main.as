package{
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.geom.ColorTransform;
	import flash.events.MouseEvent;
	import fl.controls.List; 
	import fl.data.DataProvider;
	import CollisionList;
	import guy;
	import block;
	public class Main extends MovieClip{
		var display1:TextField = new TextField();
		var score:int = 0;
		var s_multi:Number = 0;
		var b_size:Number = 0;
		var highscore:Array = [];
		var win1:Boolean = false;
		var movinR:Boolean = false;
		var movinL:Boolean = false;
		var movinR2:Boolean = false;
		var movinL2:Boolean = false;
		var guy1:guy = new guy;
		var guy2:guy = new guy;
		var block1:block;
		var block_array:Array = [];
		var block_num:int = 0;
		var timer:Timer = new Timer(200);
		var col:CollisionList;
		var col2:CollisionList;
		var col3:CollisionList;
		var col4:CollisionList;
		var col5:CollisionList;
		var col6:CollisionList;

		public function Main(){
			stop();
			btn_one.addEventListener(MouseEvent.CLICK, this.m_oneplay);
			btn_two.addEventListener(MouseEvent.CLICK, this.m_twoplay);
			addChild(display1);			
		}
		public function m_oneplay(event:MouseEvent):void
		{
			gotoAndStop(2);
			oneplay();
			win1=false;
		}
		public function m_twoplay(event:MouseEvent):void
		{
			gotoAndStop(2);
			twoplay();
			win1=false;
		}
		public function m_highscores(event:MouseEvent):void
		{
			gotoAndStop(3);
			var aList:List = new List();
			var temp:Array = []; 
			for(var i:int =0; i < highscore.length; i++){
				temp.push({label:highscore[i], data:"yolo"});
			}
			hs_list.setStyle("fontFamily", "Arial");
			hs_list.setStyle("fontSize", 30)
			hs_list.dataProvider = new DataProvider(temp);
		}
		public function oneplay(){
			stage.addChild(guy1);
			guy1.x = 320;
			guy1.y = 960; 
			addEventListener(Event.ENTER_FRAME,e_oneplay);
			timer.addEventListener(TimerEvent.TIMER, one_onTimer);
			timer.start();
			stage.addEventListener(KeyboardEvent.KEY_DOWN, reportKeyDown);
			btn_left.addEventListener(MouseEvent.MOUSE_DOWN, this.m_left);
			btn_right.addEventListener(MouseEvent.MOUSE_DOWN, this.m_right);
			btn_left.addEventListener(MouseEvent.MOUSE_UP, this.m_leftU);
			btn_right.addEventListener(MouseEvent.MOUSE_UP, this.m_rightU);
			stage.addEventListener(KeyboardEvent.KEY_UP, reportKeyUp);
			col = new CollisionList(guy1);
			col3 = new CollisionList(guy1,wallLeft);
			col5 = new CollisionList(guy1,wallRight);
			
		}
		public function twoplay(){
			stage.addChild(guy1);
			stage.addChild(guy2);
			guy1.x = 100;
			guy1.y = 960;
			guy2.x = 300;
			guy2.y = 960;
			var myColorTransform = new ColorTransform();
			myColorTransform.color = 0x000000;
			guy2.transform.colorTransform = myColorTransform; 
			addEventListener(Event.ENTER_FRAME,e_twoplay);
			timer.addEventListener(TimerEvent.TIMER, two_onTimer);
			timer.start();
			stage.addEventListener(KeyboardEvent.KEY_DOWN, reportKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, reportKeyUp);
			col = new CollisionList(guy1);
			col2 = new CollisionList(guy2);
			col3 = new CollisionList(guy1,wallLeft);
			col4 = new CollisionList(guy2,wallLeft);
			col5 = new CollisionList(guy1,wallRight);
			col6 = new CollisionList(guy2,wallRight);
		}
		//Moving characters around functions
		function m_left(event:MouseEvent):void{
			movinL = true;
		}
		function m_right(event:MouseEvent):void{
			movinR = true;
		}
		function m_leftU(event:MouseEvent):void{
			movinL = false;
		}
		function m_rightU(event:MouseEvent):void{
			movinR = false;
		}
		function reportKeyDown(event:KeyboardEvent):void 
		{ 
			if(event.charCode == 97){
				//a
				movinL = true;
			}
			if(event.charCode == 100){
				//d
				movinR = true;
			}
			if(event.charCode == 106){
				//j
				movinL2 = true;
			}
			if(event.charCode == 108){
				//l
				movinR2 = true;
			}
		} 
		function reportKeyUp(event:KeyboardEvent):void 
		{ 
			if(event.charCode == 97){
				//a
				movinL = false;
			}
			if(event.charCode == 100){
				//d
				movinR = false;
			}
			if(event.charCode == 106){
				//j
				movinL2 = false;
			}
			if(event.charCode == 108){
				//l
				movinR2 = false;
			}
		} 
		function two_onTimer(e:TimerEvent):void {
			if(win1 != true){
				block1 = new block(15);
				stage.addChild(block1);
				block1.x = randomRange(0,20) * 32;
				col.addItem(block1);
				col2.addItem(block1);
				block_array.push(block1);
				block_num ++;
				if(block_num > 20){
				col.removeItem(block_array[block_num-21])
				col2.removeItem(block_array[block_num-21])
				stage.removeChild(block_array[block_num-21]);
				}
			}			
		}
		function one_onTimer(e:TimerEvent):void {
			if(win1 != true){
				block1 = new block(15 + s_multi);
				stage.addChild(block1);
				block1.height += b_size / 2;
				block1.width += b_size;
				b_size += .1;
				score += 100 + 100 * s_multi;
				display1.text = "Score: " + String(score);
				s_multi += .01;
				timer.delay == 200 - 10*s_multi;
				block1.x = randomRange(0,20) * 32;
				col.addItem(block1);
				block_array.push(block1);
				block_num ++;
				if(block_num > 35){
				col.removeItem(block_array[block_num-36])
				stage.removeChild(block_array[block_num-36]);
				}
			}			
		}
		function clearBlocks(){
			/*for(var i:int =0; i< block_array.length; i++){
				root.stage.removeChild(block_array[i]);
			}*/
			block_num = 0;
			stage.removeChild(guy2);
			stage.removeChild(guy1);
			removeEventListener(Event.ENTER_FRAME,e_twoplay);
			timer.removeEventListener(TimerEvent.TIMER, two_onTimer);
			timer.stop();
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, reportKeyDown);
			stage.removeEventListener(KeyboardEvent.KEY_UP, reportKeyUp);
			movinR = false;
			movinL = false;
			movinR2 = false;
			movinL2 = false;
			block_array = [];
			score = 0;
			s_multi = 0;
			b_size = 0;
			timer.delay = 200;
			display1.text = "";
			
		}
		function clearBlocks1(){
			/*for(var i:int =0; i< block_array.length; i++){
				root.stage.removeChild(block_array[i]);
			}*/
			block_num = 0;
			stage.removeChild(guy1);
			removeEventListener(Event.ENTER_FRAME,e_oneplay);
			timer.removeEventListener(TimerEvent.TIMER, one_onTimer);
			timer.stop();
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, reportKeyDown);
			stage.removeEventListener(KeyboardEvent.KEY_UP, reportKeyUp);
			movinR = false;
			movinL = false;
			block_array = [];
			addScore(score);
			score = 0;
			s_multi = 0;
			b_size = 0;
			display1.text = "";
			
		}
		function addScore(SCORE:int){
			highscore.push(SCORE)
			highscore.sort(16);
		}
		function randomRange(minNum:Number, maxNum:Number):Number {
   			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}
		function e_twoplay(event:Event) {
			if(win1 != true){
				if(col3.checkCollisions()[0] != null){
					guy1.x += 20;
				}
				if(col4.checkCollisions()[0] != null){
					guy2.x += 20;
				}
				if(col5.checkCollisions()[0] != null){
					guy1.x -= 20;
				}
				if(col6.checkCollisions()[0] != null){
					guy2.x -= 20;
				}
				//col.checkCollisions()
				if(movinR ==true && movinL ==false)
					guy1.x += 20;
				if(movinR ==false && movinL ==true)
					guy1.x -= 20;
				if(movinR2 ==true && movinL2 ==false)
					guy2.x += 20;
				if(movinR2 ==false && movinL2 ==true)
					guy2.x -= 20;
				if(col.checkCollisions()[0] != null){
					gotoAndStop(1);
					btn_one.addEventListener(MouseEvent.CLICK, this.m_oneplay);
					btn_two.addEventListener(MouseEvent.CLICK, this.m_twoplay);
					clearBlocks();
					win1 = true;
				}
				else if(col2.checkCollisions()[0] != null){
					gotoAndStop(1);
					btn_one.addEventListener(MouseEvent.CLICK, this.m_oneplay);
					btn_two.addEventListener(MouseEvent.CLICK, this.m_twoplay);
					clearBlocks();
					win1 = true;
				}
			}
		}
		function e_oneplay(event:Event) {
			if(win1 != true){
				if(col3.checkCollisions()[0] != null){
					guy1.x += 20;
				}
				if(col5.checkCollisions()[0] != null){
					guy1.x -= 20;
				}
				//col.checkCollisions()
				if(movinR ==true && movinL ==false)
					guy1.x += 20;
				if(movinR ==false && movinL ==true)
					guy1.x -= 20;
				if(col.checkCollisions()[0] != null){
					gotoAndStop(1);
					btn_one.addEventListener(MouseEvent.CLICK, this.m_oneplay);
					btn_two.addEventListener(MouseEvent.CLICK, this.m_twoplay);
					btn_three.addEventListener(MouseEvent.CLICK, this.m_highscores);
					clearBlocks1();
					win1 = true;
				}
			}
		}
	}
}
		
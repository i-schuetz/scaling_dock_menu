package  {
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	public class Test extends MovieClip {
		var bar:MovieClip;
		//var items:Dictionary = new Dictionary();
		//var items_initx:Dictionary = new Dictionary();
		//var init_positions:Vector = new Vector();
		var range_rad:int;
		var offset;
		var init_width;
		
		var items:Vector.<Object> = new Vector.<Object>();
		
		public function Test() {
			//trace(test.numChildren);
			
			
			var rect:Shape = new Shape(); 
			var color:int = 0x000000;
			rect.graphics.lineStyle(1, color);
            rect.graphics.drawRect(10, 10, 100, 100);
			addChild(rect);
			
			
			//bar = new MovieClip();
			//
			//var rad = 100;
			//var item:MovieClip;
			//var s:Shape;
			//s = createShape(rad);
			//item = new MovieClip();
			//item.addChild(s);
				//
			//var back = createBackground(rad * 2, rad * 2);
			//bar.addChild(back);
			//
			//bar.addChild(item);
			//
			//addChild(bar);
			//bar.x = rad;
			
			//offset = 10;
			//var rad = 20;
			//init_width = rad * 2;
			//var height = init_width;
			//var count = 10;
			//range_rad = (init_width + offset) * 3;
			//
			//var back = createBackground(((offset + init_width) * count) - offset, height);
			//back.alpha = 0;
			//bar.addChild(back);
			//
			//var item:MovieClip;
			//var item:Shape;
			//trace("width: " + ((offset + init_width) * count));
			//var shape:DisplayObject;
			//
			//for (var i = 0; i < count; i++) {
				//shape = createShape(rad);
				//item = createShape(rad);
				//item = new MovieClip();
				//item.addChild(shape);
				//
				//bar.addChild(item);
				//item.x = i * (init_width + offset);
				//items[item.x] = item;
				//items.push( { x:item.x, item:item, xtmp:item.x } );
				//item.addEventListener(MouseEvent.ROLL_OVER, onItemOver);
				//item.addEventListener(MouseEvent.ROLL_OUT, onItemOut);
				//items_initx[item] = item.x;
			//}
			//bar.x = init_width;
			//bar.y = init_width;
			//bar.addEventListener(MouseEvent.ROLL_OVER, onBarOver);
			//bar.addEventListener(MouseEvent.ROLL_OUT, onBarOut);
			//addChild(bar);
		}
		
		public function createBackground(width:int, height:int):Shape {
			var back:Shape = new Shape(); 
            back.graphics.beginFill(0x00ff00 , 1);
            back.graphics.drawRect(0, 0, width, height);
			return back;
		}
		
		public function createShape(width:int):Shape {
			var circle:Shape = new Shape(); 
			var color:int = 0xffffff * Math.random();
            circle.graphics.beginFill(color , 1);
            circle.graphics.drawCircle(0, width, width);
			return circle;
		}
		//
		//public function onBarOver(event:MouseEvent) {
			//trace("bar onover x" + event.localX + "y" + event.localY);
			//bar.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		//}
		//
		//public function onItemOver(event:MouseEvent) {
			//trace("onItemOver");
		//}
//
		//public function onItemOut(event:MouseEvent) {
			//trace("onItemOut");
		//}
		//
		//public function onBarOut(event:MouseEvent) {
			//trace("bar onRollOut");
			//bar.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			//var item;
			//for each (var o in items) {
				//o.item.x = o.x;
				//item = o.item;
				//item.scaleX = 1;
				//item.scaleY = 1;
			//}
		//}
		//
		//public function onMouseMove(event:MouseEvent) {
			//trace("bar onmove x" + event.localX + "y" + event.localY);
			//var mouse_x = event.localX;
			//var range_min = mouse_x - range_rad;
			//var range_max = mouse_x + range_rad;
			//var diff;
			//var percent;
			//var more_x = 0;
			//var x;
			//var item;
			//var o;
			//for (var i = 0; i < items.length; i++) {
				//o = items[i];
				//o.xtmp = o.x;
			//}
			//for (var i = 0; i < items.length; i++) {
				//o = items[i];
			//}
			//for each (var o in items) {
				//x = o.x;
				//
				//if (x > range_min && x < range_max) {
					//diff = Math.abs(mouse_x - x);
					//percent = 1 - (diff / range_rad);
					//var scaleVal = 1 + percent;
					//item = o.item;
					//item.scaleX = scaleVal;
					//item.scaleY = scaleVal;
					//more_x = (item.width - init_width) / 2;
					//for (var k = i + 1; k < items.length; k++) {
						//items[k].xtmp += more_x;
						//items[k].item.x = items[k].xtmp; 
					//}
					//for (var k = i - 1; k > -1; k--) {
						//items[k].xtmp -= more_x;
						//items[k].item.x = items[k].xtmp; 
					//}
				//}
			//}
		//}
	}
	
}

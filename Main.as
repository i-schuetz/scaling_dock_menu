package  {
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.filters.BitmapFilterQuality; 
	import flash.filters.GlowFilter; 
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	public class Main extends MovieClip {
		var bar:MovieClip;
		var range_rad:int;
		var offset;
		var init_width;
		var start_bar_x:int;
		var scaleIcon:MovieClip;
		
		var items:Vector.<Object> = new Vector.<Object>();
		var glow:GlowFilter;
		
		var classes:Array = ["Soldiers", "Ring", "Light", "Kaefer", "Horse", "Helm", "Fire", "Doctor", "Diamond", "Daemon", "Dado", "Cup", "Clown", "Church", "Chain", "Carrot", "Butterfly",
			"Bridge", "Bomb", "Boat", "Bell", "Bank", "Banana", "Apple", "Angel", "Angle", "Alien"];
		
		var draggingItem:Sprite;
		var hoveredItem:Sprite;
		var realItemOverlay:Shape;
		
		var scalingIcon:Sprite;
		var scalingType:String;
		
		public function Main() {
			scaleIcon = new ScaleIcon();
			scaleIcon.addEventListener(MouseEvent.ROLL_OVER, onScaleIconOver);
			scaleIcon.addEventListener(MouseEvent.ROLL_OUT, onScaleIconOut);
			scaleIcon.addEventListener(MouseEvent.CLICK, onScaleClick);
			scaleIcon.buttonMode = true;
			scaleIcon.name = "scale";
			
			realItemOverlay = createRect(60, 70);
			realItemOverlay.alpha = 0;
			//realItemOverlay.addEventListener(MouseEvent.ROLL_OUT, onRealItemOverlayOut);
			
			//scaleIcon.visible = false;
			
			//shuffle
			var arr2:Array = [];
			while (classes.length > 0) {
				arr2.push(classes.splice(Math.round(Math.random() * (classes.length - 1)), 1)[0]);
			}
			classes = arr2;
			
			bar = new MovieClip();
			offset = 10;
			var rad:Number = 27.5;
			init_width = rad * 2;
			var height = 55;
			//var count = 10;
			//var count = classes.length;
			var count = 14;
			range_rad = (init_width + offset) * 3;
			
			var back = createBackground(((offset + init_width) * count) - offset, height);
			//back.alpha = 0;
			bar.addChild(back);
			
			//var item:MovieClip;
			var item:Sprite;
			//var item:Shape;
			//trace("width: " + ((offset + init_width) * count));
			var shape:MovieClip;
			var clazz;
			var instance;
			var overlay:Shape;
			var init_offset = rad;
			
			for (var i = 0; i < count; i++) {
				//shape = createCircle(rad);
				clazz = Class(getDefinitionByName(classes[i]));
				shape = new clazz();
				shape.name = "img";
				//item = createCircle(rad);
				//item = new MovieClip();
				item = new Sprite();
				item.addChild(shape);
				var overlay:Shape = createRect(55, 55);
				overlay.x = -27;
				overlay.alpha = 0;
				item.addChild(overlay);
				
				bar.addChild(item);
				item.x = i * (init_width + offset) + init_offset;
				//items[item.x] = item;
				items.push( { x:item.x, item:item, xtmp:item.x } );
				item.addEventListener(MouseEvent.MOUSE_OVER, onItemOver);
				item.addEventListener(MouseEvent.MOUSE_OUT, onItemOut);
				item.addEventListener(MouseEvent.CLICK, onDockItemClick);
				item.buttonMode = true;
				//items_initx[item] = item.x;
			}
			//bar.x = init_width;
			start_bar_x = bar.x;
			//bar.y = init_width;
			//bar.mouseChildren = false;
			bar.addEventListener(MouseEvent.ROLL_OVER, onBarOver);
			bar.addEventListener(MouseEvent.ROLL_OUT, onBarOut);
			addChild(bar);
			
			glow = new GlowFilter(); 
			glow.color = 0xffffff; glow.strength = 3;
			//glow.alpha = 1; 
			glow.blurX = 15; 
			glow.blurY = 15; 
			//glow.quality = BitmapFilterQuality.MEDIUM;
			
			//place_area.addEventListener(MouseEvent.ROLL_OVER, onPlaceAreaOver);
			//place_area.addEventListener(MouseEvent.ROLL_OUT, onPlaceAreaOut);
			
			addEventListener(MouseEvent.CLICK, onStageClick);
			addEventListener(MouseEvent.MOUSE_UP, onStageUp);
		}
		
		function onStageClick(e:MouseEvent) {
			if (scalingIcon) {
				trace("removing the square");
				scalingIcon.removeChild(scalingIcon.getChildByName("square"));
				scalingIcon = null;
			}
		}
		
				
		function onStageUp(e:MouseEvent) {
			if (hasEventListener(MouseEvent.MOUSE_MOVE)) {
				removeEventListener(MouseEvent.MOUSE_MOVE, onScalingMove);
				
			}
		}
		/////////////////////////////////////////////////////////////scale seccion////////////////////////////////////
		
		function onScaleClick(e:MouseEvent) {
			e.stopImmediatePropagation();
			var scaleIcon:Sprite = e.currentTarget as Sprite;
			var container:Sprite = scaleIcon.parent as Sprite;
			container.removeChild(scaleIcon);
			var scaleSquare = createScaleSquare();
			scaleSquare.x = -27;
			container.addChild(scaleSquare);
			scalingIcon = container;
			
		}
		
		function createScaleSquare(width:Number = 55, height:Number = 55):Sprite {
			var scaleContainer:Sprite = new Sprite();
			var rect:Shape = new Shape(); 
			var color:int = 0x000000;
			rect.graphics.lineStyle(1, color);
            rect.graphics.drawRect(0, 0, width, height);
			scaleContainer.addChild(rect);
			
			//add scale points
			var pointWidth = 10;
			scaleContainer.addChild(createScalePoint("ul", - (pointWidth / 2), - (pointWidth / 2)));
			scaleContainer.addChild(createScalePoint("u", (width / 2) - (pointWidth / 2), - (pointWidth / 2)));
			scaleContainer.addChild(createScalePoint("ur", width - (pointWidth / 2), - (pointWidth / 2)));
			scaleContainer.addChild(createScalePoint("r", width - (pointWidth / 2), (height / 2) - (pointWidth / 2)));
			scaleContainer.addChild(createScalePoint("dr", width - (pointWidth / 2), height - (pointWidth / 2)));
			scaleContainer.addChild(createScalePoint("d", (width / 2) - (pointWidth / 2), height - (pointWidth / 2)));
			scaleContainer.addChild(createScalePoint("dl", - (pointWidth / 2),  height - (pointWidth / 2)));
			scaleContainer.addChild(createScalePoint("l", - (pointWidth / 2), (height / 2) - (pointWidth / 2)));
			
			//var point = createScalePoint("r");
			//point.x = width - (point.width / 2);
			//point.y = (height / 2) - (point.height / 2);
			//scaleContainer.addChild(point);
			
			scaleContainer.name = "square";
			
			return scaleContainer;
		}
		
		function createScalePoint(type:String, x, y):Sprite {
			var shape = createRect(10, 10, 0x000000);
			var sprite:Sprite = new Sprite();
			sprite.addChild(shape);
			sprite.addEventListener(MouseEvent.ROLL_OVER, onScalePointOver);
			sprite.addEventListener(MouseEvent.ROLL_OUT, onScalePointOut);
			sprite.addEventListener(MouseEvent.MOUSE_DOWN, onScalePointMouseDown);
			//sprite.addEventListener(MouseEvent.MOUSE_UP, onScalePointMouseUp);
			sprite.name = type;
			sprite.x = x;
			sprite.y = y;
		
			return sprite;
		}
		
		function onScalePointOver(event:MouseEvent) {
			//change cursor
			trace("onScalePointOver");
		}
		
		function onScalePointOut(event:MouseEvent) {
			//restore cursor
			trace("onScalePointOut");
		}
		
		
		var lastx;
		var lasty;
		
		function onScalePointMouseDown(event:MouseEvent) {
			event.stopImmediatePropagation();
			//start scale
			lastx = event.stageX;
			lasty = event.stageY;
			scalingType = event.currentTarget.name;
			trace("the name:" + scalingType);
			addEventListener(MouseEvent.MOUSE_MOVE, onScalingMove);
		}
		
		//function onScalePointMouseUp(event:MouseEvent) {
			//stop scale
			//removeEventListener(MouseEvent.MOUSE_MOVE, onScalingMove);
		//}
		
		
		function onScalingMove(event:MouseEvent) {
			//TODO ineficcient? maybe add different listener for each type
			
			switch(scalingType) {
				case "r":
				trace("--------------------------------------------");
					var newx = event.stageX;
					var diff = newx - lastx;
					trace("the diff:" + diff);
					//scalingIcon.width += diff;
					var square = scalingIcon.getChildByName("square");
					trace("old width of square:" + square.width);
					trace("height before incr width:" + square.height);
					scalingIcon.getChildByName("item").width += diff;

					var newSquare = createScaleSquare(square.width - 10 + diff, square.height - 10);
					trace("the new width is:" + newSquare.width);
					
					newSquare.x += -27;
					scalingIcon.removeChild(square);
					scalingIcon.addChild(newSquare);
					//scalingIcon.scaleX = 1.1;
					lastx = newx;
					trace("--------------------------------------------");
				break;
				case "d":
					var newy = event.stageY;
					var diff = newy - lasty;
					var square = scalingIcon.getChildByName("square");
					scalingIcon.getChildByName("item").height += diff;
					var newSquare = createScaleSquare(square.width - 10, square.height - 10 + diff);
					
					newSquare.x += -27;
					scalingIcon.removeChild(square);
					scalingIcon.addChild(newSquare);
					//scalingIcon.scaleX = 1.1;
					lasty = newy;
				break;
			}
		}
		
		/////////////////////////////////////////////////////////////scale seccion end////////////////////////////////////
		
		//public function onPlaceAreaOver(event:MouseEvent) {
			//if (draggingItem) {
				//place_area.buttonMode = true;
			//}
		//}
		//
		//public function onPlaceAreaOut(event:MouseEvent) {
			//place_area.buttonMode = false;
		//}
		
		public function createBackground(width:int, height:int):Shape {
			var back:Shape = new Shape(); 
            back.graphics.beginFill(0x333333 , 1);
            back.graphics.drawRect(0, 0, width, height);
			return back;
		}
		
		public function createCircle(width:int):Shape {
			var circle:Shape = new Shape(); 
			var color:int = 0xffffff * Math.random();
            circle.graphics.beginFill(color , 1);
            circle.graphics.drawCircle(0, width, width);
			return circle;
		}
		
		public function createRect(width:int, height:int, color:int=-1):Shape {
			var rect:Shape = new Shape(); 
			if (color == -1) {
				color = 0xffffff * Math.random();
			}
            rect.graphics.beginFill(color , 1);
            rect.graphics.drawRect(0, 0, width, height);
			return rect;
		}
		
		public function onBarOver(event:MouseEvent) {
			bar.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		public function onItemOver(event:MouseEvent) {
			if (!draggingItem) {
				var item:Sprite = event.target as Sprite;
				item.filters = [glow];
			}
		}
		
		public function onItemOut(event:MouseEvent) {
			if (!draggingItem) {
				var item:Sprite = event.target as Sprite;
				item.filters = [];
			}
		}
		
		public function onScaleIconOver(event:MouseEvent) {
			var target:Sprite = event.target as Sprite;
			target.filters = [glow];
		}
		
		public function onScaleIconOut(event:MouseEvent) {
			var target:Sprite = event.target as Sprite;
			target.filters = [];
		}
		
		public function onDroppedItemOver(event:MouseEvent) {
			if (!draggingItem && !scalingIcon) {
				//var item:Sprite = event.target as Sprite;
				//var container:Sprite = item.parent as Sprite;
				var container:Sprite = event.currentTarget as Sprite;
				var item = container.getChildByName("item");
				item.filters = [glow];
				container.addChild(scaleIcon);
				//scaleIcon.x = item.x - (scaleIcon.width / 2);
				scaleIcon.y = -35;
				scaleIcon.x = -25;
				realItemOverlay.x = - 30;
				realItemOverlay.y = - 10;
				container.addChild(realItemOverlay);
				trace("added the overlay");
				//realItemOverlay.addEventListener(MouseEvent.ROLL_OUT, onRealItemOverlayOut);
				//container.addEventListener(MouseEvent.ROLL_OUT, onRealItemOverlayOut);
				container.addEventListener(MouseEvent.CLICK, onClickDroppedItem);
			}
		}
		
		public function onDroppedItemOut(event:MouseEvent) {
			trace("out !");
			if (!draggingItem) {
				trace("2");
				var container:Sprite = event.currentTarget as Sprite;
				var item:Sprite = container.getChildByName("item") as Sprite;
				//trace("the item:" + item);
				//var container:Sprite = item.parent as Sprite;
				item.filters = [];
				if (container.contains(scaleIcon)) { //scaleIcon can not have been added right after the item was placed (no onRealItemOver before)
					container.removeChild(scaleIcon);
				}
			}
		}
		
		public function onClickDroppedItem(event:MouseEvent) {
			trace("onClickDroppedItem");
			var container:Sprite = event.currentTarget as Sprite;
			var item:Sprite = container.getChildByName("item") as Sprite;
			//var item:Sprite = event.target as Sprite;
			item.filters = [];
			//draggingItem = item;
			//addChild(item);
			//item.startDrag();
			draggingItem = container;
			
			var scaleIcon = container.getChildByName("scale");
			if (scaleIcon) { //the scale icon could have been already removed by clicking on it
				container.removeChild(container.getChildByName("scale"));
			}
			addChild(container);
			container.startDrag();
			container.removeEventListener(MouseEvent.CLICK, onClickDroppedItem);
			draggingItem.addEventListener(MouseEvent.CLICK, onClickDraggingItem);
		}
		
		public function onDockItemClick(event:MouseEvent) {
			if (draggingItem == null) {
				//trace()
				var item:Sprite = (event.currentTarget as Sprite).getChildByName("img") as Sprite;
				item.filters = [];
				//duplicate
				var clazz:Class = Class(getDefinitionByName(getQualifiedClassName(item)));
				draggingItem = new clazz();
				draggingItem.name = "item";
				
				//"clone" also the overlay
				var overlay:Sprite = new Sprite();
				var rect = createRect(55, 55);
				overlay.addChild(rect);
				rect.alpha = 0;
				draggingItem.addChild(overlay);
				overlay.x = -27;
				
				
				//add a container for the buttons and image
				var container:Sprite = new Sprite();
				var rect = createRect(55, 55); //all images are 55 x 55
				rect.alpha = 0;
				container.addChild(rect);
				
				//container.x = draggingItem.x - 27;
				container.y = draggingItem.y;
				
				//draggingItem.x = 27;
				draggingItem.y = 0;
				container.addChild(draggingItem);
				
				addChild(container);
				
				//container.removeEventListener(MouseEvent.CLICK, onClickRealItem);
				container.addEventListener(MouseEvent.ROLL_OVER, onDroppedItemOver);
				container.addEventListener(MouseEvent.ROLL_OUT, onDroppedItemOut);	
					
				container.buttonMode = true;
				addChild(container);
				
				
				container.x = event.stageX;
				container.y = event.stageY - (draggingItem.height / 2);
				//addChild(draggingItem);
				container.startDrag();
				onBarOut(null);
				draggingItem.addEventListener(MouseEvent.CLICK, onClickDraggingItem);
				//place_area.addEventListener(MouseEvent.MOUSE_MOVE, onPlaceAreaDraggingMove);
				//addEventListener(Event.ENTER_FRAME, checkCollision);
			}
		}
		
		function checkCollision(event:Event):void {
			if (draggingItem) {
				if (draggingItem.hitTestObject(place_area)) {
					draggingItem.filters = [glow];
				}
				//else {
					//draggingItem.filters = [];
				//}
			}
		}
			
		public function onPlaceAreaDraggingMove(event:MouseEvent) {
			trace("move!");
		}
		
		public function onClickDraggingItem(event:MouseEvent) {
			if (draggingItem) { //dragging state
				var container:Sprite = event.currentTarget as Sprite;
				var item:Sprite = container.getChildByName("item") as Sprite;
				if (place_area.hitTestPoint(event.stageX, event.stageY, true)) {
					//removeEventListener(Event.ENTER_FRAME, checkCollision);
					//draggingItem.filters = [];
					draggingItem.stopDrag();
					
					//hack
					for (var i:int = 0; i < draggingItem.numChildren; i++) {
						draggingItem.getChildAt(i).x += 27;
					}
					draggingItem.x -= 27;
					
					//dontn add roll out here, roll out has to be of the area including buttons (overlay)
					//draggingItem.addEventListener(MouseEvent.ROLL_OUT, onDroppedItemOut);
					draggingItem = null;
					
				}
			} 
			//else { //already dropped
				//var item:Sprite = event.target as Sprite;
				//item.filters = [];
				//draggingItem = item;
				//addChild(item);
				//item.startDrag();
			//}
		}
		
		public function onBarOut(event:MouseEvent) {
			bar.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			var item;
			for each (var o in items) {
				o.item.x = o.x;
				item = o.item;
				item.scaleX = 1;
				item.scaleY = 1;
			}
		}
		
		public function onMouseMove(event:MouseEvent) {
			//trace("bar onmove x" + event.localX + "y" + event.localY); //coords relative to circle, not bar!
			var mouse_x = event.stageX - start_bar_x;
			//trace(mouse_x);
			var range_min = mouse_x - range_rad;
			var range_max = mouse_x + range_rad;
			var diff;
			var percent;
			var more_x = 0;
			var x;
			var item;
			var o;
			for (var i = 0; i < items.length; i++) {
				o = items[i];
				o.xtmp = o.x;
			}
			for (var i = 0; i < items.length; i++) {
				o = items[i];
				x = o.x;
				
				if (x > range_min && x < range_max) {
					diff = Math.abs(mouse_x - x);
					percent = 1 - (diff / range_rad);
					var scaleVal = 1 + percent;
					item = o.item;
					item.scaleX = scaleVal;
					item.scaleY = scaleVal;
					more_x = (item.width - init_width) / 2;
					for (var k = i + 1; k < items.length; k++) {
						items[k].xtmp += more_x;
						items[k].item.x = items[k].xtmp; 
					}
					for (var k = i - 1; k > -1; k--) {
						items[k].xtmp -= more_x;
						items[k].item.x = items[k].xtmp; 
					}
				} 
				else {
					o.item.scaleX = 1;
					o.item.scaleY = 1;
				}
			}
		}
	}
	
}

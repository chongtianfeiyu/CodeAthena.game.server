package CodeAthena.ui.skin.athena
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.DisplayObject;

	public class Button extends Sprite
	{
		public const STATE_NORMAL:int=0; 
		public const STATE_PRESS:int=1; 

		private var spriteNormal:Sprite;
		private var spritePress:Sprite;

		public function Button()
		{
			super();
			spriteNormal=new Sprite();
			spritePress=new Sprite();
			addChild(spriteNormal);
			addChild(spritePress);

			setState(STATE_NORMAL);
			addButtonListener();
		}
		
		public function setSkin(normal:DisplayObject, press:DisplayObject):void
		{
			spriteNormal.addChild(new Sprite().addChild( normal) );
			spritePress.addChild(new Sprite().addChild( press));
		}

		public function addButtonListener():void
		{
			addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			addEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}

		public function removeButtionListener():void
		{
			addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			addEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}

		public function setState(state:int):void
		{
			spriteNormal.visible=false;
			spritePress.visible=false;
			switch (state)
			{
				case STATE_NORMAL:
					spriteNormal.visible=true;
					break;
				case STATE_PRESS:
					spritePress.visible=true;
					break;
			}
		}

		public function mouseDown(e:Event):void
		{
			setState(STATE_PRESS);
		}

		public function mouseUp(e:Event):void
		{
			setState(STATE_NORMAL);
		}

	}
}

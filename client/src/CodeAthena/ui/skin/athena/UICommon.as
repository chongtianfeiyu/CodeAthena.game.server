package CodeAthena.ui.skin.athena
{
	import CodeAthena.ui.Button;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	import CodeAthena.sound.SoundManager;
	


	public class UICommon extends EventDispatcher
	{
		private static var instance:UICommon;
		

		
		private var loginButton:Button;

		public function UICommon()
		{
			if (instance != null)
			{
				throw new Error("UIComman是单例， 请使用UICommon.getInstance()获取");
			}
		}
		
		public static function getInstance():UICommon
		{
			if (instance == null)
			{
				instance = new UICommon();
			}
			return instance;
		}
		[Embed(source="../../../../assets/skin/athena/loginScene/butLogin.png")]
		private var ButImgLoginNormal:Class;
		[Embed(source="../../../../assets/skin/athena/loginScene/butLoginHover.png")]
		private var ButImgLoginHover:Class;
		public function getLoginButton():Button
		{
			if (loginButton == null)
			{
				loginButton = new Button();
				loginButton.setSkin( new ButImgLoginNormal(), new ButImgLoginHover());
				setupButton(loginButton);
			}
			return loginButton;
		}
		private function setupButton(button:Button):void
		{
			button.useHandCursor = true;
			button.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler, false, 0, true);
			button.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler, false, 0, true);
		
		}
		private function rollOverHandler(e:MouseEvent):void
		{
			//SoundManager.playSoundEffect(SoundManager.TYPE_BUT_MOVE_OVER);
		}
		
		private function mouseDownHandler(e:MouseEvent):void
		{
			//SoundManager.playSoundEffect(SoundManager.TYPE_BUT_CLICK);
		}
		
		
	}
}
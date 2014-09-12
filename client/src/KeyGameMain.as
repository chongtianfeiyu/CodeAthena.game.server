package
{
	import com.bit101.components.InputText;
	import com.bit101.components.Label;
	import com.bit101.components.PushButton;
	import com.junkbyte.console.Cc;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import CodeAthena.logger.service.Log;
	import CodeAthena.loginScene.LoginCmd;
	import CodeAthena.net.service.SocketService;
	import CodeAthena.ui.skin.athena.Button;
	import CodeAthena.ui.skin.athena.UICommon;

	[SWF(width="800", height="600", frameRate="60", backgroundColor="#FFFFFF")]
	public class KeyGameMain extends Sprite
	{
		private static var  log:Log = new Log("KeyGameMain");
		
		
		private var inputUserName:InputText;
		private var inputPassWord:InputText;
		public function KeyGameMain()
		{
			Cc.start(this.stage, "showcamuslog");
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.showDefaultContextMenu = false;	
			stage.stageFocusRect = false;
			var butLogin:Button = UICommon.getInstance().getLoginButton();
			butLogin.x = 100;
			butLogin.y = 100;
			this.addChild(butLogin);
			butLogin.visible = true;
			
			butLogin.addEventListener(MouseEvent.MOUSE_DOWN, onButtonClickEvent);
			new Label(this, 20, 10, "user login ");  
			inputUserName = new InputText(this, 20, 30, "username");  
			inputPassWord = new InputText(this, 20, 50, "password");
			inputPassWord.password = true;  
			//PushButton  
			new PushButton(this, 20, 70, "login", onButtonClickEvent);  
			log.info(" start");
		}
		
		
		private function onButtonClickEvent(event:Event):void{  
			var loginCmd:LoginCmd = new LoginCmd();
			loginCmd.userName = inputUserName.text;
			loginCmd.passWord = inputPassWord.text;
			log.info("login now [userName]"+inputUserName.text +" [passWord]" +inputPassWord.text);  
			var sc:SocketService = new SocketService();
			sc.connect("127.0.0.1", 6688 );
			sc.sendObj(loginCmd);
			
		}  
	}
}

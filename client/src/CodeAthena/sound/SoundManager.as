package CodeAthena.sound
{
	
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	import CodeAthena.logger.service.Log;
	
	public class SoundManager
	{
		private static var  log:Log = new Log("SoundManager");
		public static const TYPE_BUT_CLICK:int = 1;
		
		[Embed(source="../../assets/skin/athena/mp3/butClick.mp3")]
		private static var SndButtonClick:Class;
		
		private static var sndButtonClick:Sound = new SndButtonClick();
		
		
		public function SoundManager()
		{
			
		}
		
		public static function playSoundEffect(soundEffect:int):void
		{
			var channel:SoundChannel;
			
			try
			{
				switch (soundEffect)
				{
					case SoundManager.TYPE_BUT_CLICK:
						channel = SndButtonClick.play();
						break;
					
					default:
						break;
				}
			}
			catch( e:Error )
			{
				log.error("playSoundEffect "+soundEffect + "error");
				log.error(e.getStackTrace());
			}
			
			
		}
		
	}
}
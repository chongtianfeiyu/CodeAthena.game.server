package CodeAthena.logger.service
{
	import com.junkbyte.console.Cc;
	

	public class Log implements ILog
	{

		private var channelName:String;
		public function Log(channelName:String):void
		{
			this.channelName = channelName;
		}
		
		public  function warn(text:String):void
		{
			Cc.warn(channelName+"-" +text);
			trace("[WARN]"+channelName+"-" +text);
		}
		
		public  function error(text:String):void
		{
			Cc.error(channelName+"-" +text);
			trace("[ERR]"+channelName+"-" +text);
		}

		public  function info(text:String):void
		{
			Cc.log(channelName+"-" +text);
			trace("[INFO]"+channelName+"-" +text);
		}
		
		public  function debug(text:String):void
		{
			Cc.log(channelName+"-" +text);
			trace("[INFO]"+channelName+"-" +text);
		}
	}

}

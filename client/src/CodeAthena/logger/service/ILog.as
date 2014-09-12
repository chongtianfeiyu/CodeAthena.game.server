package CodeAthena.logger.service
{
	public interface ILog
	{
		
		function warn(text:String):void;

		function error(text:String):void;

		function info(text:String):void;

		function debug(text:String):void;
	}
}

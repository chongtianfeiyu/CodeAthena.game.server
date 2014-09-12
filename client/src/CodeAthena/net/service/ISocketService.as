package CodeAthena.net.service
{
	public interface ISocketService
	{
		/**
		 * 连接远程服务
		 * @param url 连接地址
		 * @param arguments 其他不定参数
		 *
		 */
		function connect(url:String, port:int):void;
		
		/**
		 * 断开服务
		 *
		 */
		function disConnect():void;
		
		function reconect():void;		
		function sendObj(obj:Object):void;
		function clearRequesQueue():void;


		/**
		 * 是否已连接
		 * @return
		 *
		 */
		function get connected():Boolean;

	}
}

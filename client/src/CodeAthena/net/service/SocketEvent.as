

package CodeAthena.net.service
{
	import flash.events.Event;
	
	public class SocketEvent extends Event
	{
		public static const SOCKET_DATA:String      = "network.DATA";
		public static const ERROR:String            = "network.ERROR";
		public static const SUCCESS:String          = "network.SUCCESS";
		public static const DISCONNECT:String      = "network.DISCONNECT";

		public function SocketEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
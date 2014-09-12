package CodeAthena.net.service
{
	import com.bit101.components.Text;
	
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	
	import CodeAthena.pack.ParseUtils;

	public class SocketService  extends EventDispatcher
	{
		private var serverAddress:String;
		private var serverPort:int;
		private var socketProxy:SocketProxy;
		private var socketProxyData:ByteArray;
		private var requestQueue:Array;

		
		public function SocketService()
		{
			super();
			requestQueue = [];
		}
		
		public function get socketData():ByteArray
		{
			return socketProxyData;
		}
		
		public function get socketDataToObject():Object
		{
			return ParseUtils.decode(socketProxyData);
		}
		
		public function connect( address:String, port:int ):void
		{
			serverPort = port;
			serverAddress = address;
			socketProxy  = new SocketProxy();
			socketProxy.connect(serverAddress,serverPort,onConnect,onError,onData);
		}
		
		public function reconect():void
		{
			socketProxy = new SocketProxy();
			socketProxy.connect(serverAddress,serverPort,onConnect,onError,onData);
		}
		
		public function sendObj( data:Object ):void
		{
			send(ParseUtils.encode(data));
		}
		
		public function send(data:ByteArray):void
		{
			if ( socketProxy && socketProxy.connected )
			{
				socketProxy.send(data);
			}
			else
			{
				requestQueue.push(data);
			}
			
		}
		
		public function get connected():Boolean
		{
			if(!socketProxy)
			{
				return false;
			}
			
			return socketProxy.connected;
		}
		
		public function disConnect():void
		{
			destory();
			dispatchEvent(new SocketEvent(SocketEvent.DISCONNECT));
		}
		
		public function destory():void
		{
			socketProxyData = null;
			clearRequestQueue();
			if(socketProxy)
			{
				socketProxy.disConnect();
			}
			socketProxy = null;
		}
		
		public function onError(...arguments):void
		{
			dispatchEvent(new SocketEvent(SocketEvent.ERROR));
		}
		
		private function onData(data:ByteArray):void
		{
			socketProxyData = data;
			var jsonText:Object = ParseUtils.decode(socketProxyData);
			
		}
		
		private function onConnect():void
		{
			dispatchEvent(new SocketEvent(SocketEvent.SUCCESS));
			
			while (requestQueue.length > 0)
			{
				socketProxy.send(requestQueue.shift());
			}
		}
		
		public function clearRequestQueue():void
		{
			requestQueue = [];
		}
	}
}
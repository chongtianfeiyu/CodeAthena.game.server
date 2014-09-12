package CodeAthena.net.service
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	
	import CodeAthena.logger.service.Log;

	public class SocketProxy
	{
		private var socket:Socket;
		private var serverAddress:String;
		private var port:int;
		private var onSocketData:Function;
		private var onSocketError:Function;
		private var onSocketConnect:Function;
		
		private static var log:Log=new Log("SocketProxy");

		public function SocketProxy()
		{
			socket = null;
		}

		public function get connected():Boolean
		{
			if (socket == null)
			{
				return false;
			}
			return socket.connected
		}

		public function send(data:ByteArray):void
		{
			socket.writeBytes(data);
			socket.flush();
			data.clear();
		}

		public function connect(address:String, port:int, onConnectFun:Function, onErrorFun:Function, onDataFun:Function):void
		{
			if (socket)
			{
				log.error("Socket has already existed");
				throw new Error("Socket has already existed " + address);
			}

			onSocketData=onDataFun;
			onSocketError=onErrorFun;
			onSocketConnect=onConnectFun;
			this.serverAddress=address;
			this.port = port;
			socket=new Socket();

			socket.addEventListener(Event.CONNECT, onConnect);
			socket.addEventListener(Event.CLOSE, onClose);
			socket.addEventListener(ProgressEvent.SOCKET_DATA, onData);
			socket.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);

			log.info( "connect "+serverAddress + "  : " + port);
			socket.connect(serverAddress, port);
		}



		public function disConnect():void
		{
			log.info("disConnect "+serverAddress + "  : " + port);

			socket.removeEventListener(Event.CONNECT, onConnect);
			socket.removeEventListener(Event.CLOSE, onClose);
			socket.removeEventListener(ProgressEvent.SOCKET_DATA, onData);
			socket.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
			socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);

			try
			{
				if (socket)
				{
					socket.close();
				}
			}
			catch (error:Error)
			{
				
			}

			socket=null;
			onSocketConnect=null;
			onSocketData=null;
			onSocketError=null;
		}


		private function onConnect(evt:Event):void
		{
			log.info("connect socket ok");

			if (onSocketConnect != null)
			{
				onSocketConnect();
			}

		}

	
		private function onClose(evt:Event):void
		{

			log.info("connect was cloesed.");
			if (onSocketError != null)
			{
				onSocketError(null);
			}

		}

		private function onData(evt:ProgressEvent):void
		{
			log.info("onData"+evt);
			var curDataArray:ByteArray=new ByteArray();
			socket.readBytes(curDataArray);
			curDataArray.position=0;
			if (onSocketData != null)
			{
				onSocketData(curDataArray);
			}
		}

	
		public function onIOError(evt:IOErrorEvent):void
		{
			log.error("IOErrorEvent "+evt.text);
			if (onSocketError != null)
			{
				onSocketError(null);
			}

		}

		public function onSecurityError(evt:SecurityErrorEvent):void
		{
			log.error("SecurityErrorEvent"+evt.text);
			if (onSocketError != null)
			{
				onSocketError(null);
			}
		}
	}

}

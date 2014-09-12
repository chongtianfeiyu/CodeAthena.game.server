package CodeAthena.pack
{
	
	import flash.utils.ByteArray;
	
	import CodeAthena.logger.service.Log;

	public class ParseUtils
	{
		private static var log:Log=new Log("ParseUtils");
		private static var _buffer:ByteArray = new ByteArray();
		
		
		public static function decode( byte:ByteArray ):Object
		{
			// 把接到的数据写入到buffer中
			_buffer.position      =  _buffer.length;
			_buffer.writeBytes(byte);
			_buffer.position      = 0;
			
			while (_buffer.bytesAvailable)
			{
				var len:int = _buffer.readShort();
				var type:int = _buffer.readByte();
				var compress:int = _buffer.readByte();
				
				if (_buffer.position + len <= _buffer.length)
				{
					var newByte:ByteArray = new ByteArray();
					_buffer.readBytes(newByte, 0, len);
					newByte.position     = 0;
					
					var str:String = newByte.readUTF();
					log.debug("receive a message" + str);
					if ( _buffer.position > 0 )
					{
						var len:int = _buffer.length - _buffer.position;
						if ( len == 0 )
						{
							_buffer.clear();
							_buffer.position = 0;
						}
						else
						{
							var newByte:ByteArray = new ByteArray();
							
							_buffer.readBytes(newByte,_buffer.position,len);
							_buffer = newByte;
							_buffer.position = 0;
						}
						
					}
					return str;
					
				}
				else
				{
					_buffer.position -= 4;
					break;
				}

			}
			
			
			
			return null;
		}
		
		
		
		
		
		public static function encode( object:Object ):ByteArray
		{
			
			var jsonByteData:ByteArray    = JsonParser.encode(object);
			var sendByteData:ByteArray  = new ByteArray();
			var len:int = jsonByteData.length;
			
			
			sendByteData.writeShort(len);
			sendByteData.writeByte(ParseType.TYPE_JSON);
			sendByteData.writeByte(ParseType.COMPRESS_NONE);
			
			jsonByteData.position = 0;
			var str:String = jsonByteData.readUTF();
			
			sendByteData.writeUTF(str);
			
			return sendByteData;
		}
		
		
		
	}
}
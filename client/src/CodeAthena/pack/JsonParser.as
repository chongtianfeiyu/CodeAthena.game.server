package CodeAthena.pack
{

	import flash.utils.ByteArray;

	import CodeAthena.logger.service.Log;

	public class JsonParser
	{
		private static var log:Log=new Log("JsonParser");

		public function JsonParser()
		{

		}

		public static function decode(byte:ByteArray):Object
		{
			var jsonStr:String=byte.readUTF();
			log.info("receive " + jsonStr);
			return JSON.parse(jsonStr);
		}

		public static function encode(object:Object):ByteArray
		{
			var jsonStr:String=JSON.stringify(object);
			log.info("send " + jsonStr);
			var byte:ByteArray=new ByteArray();
			byte.writeUTF(jsonStr);
			byte.position=0;
			return byte;
		}



	}
}

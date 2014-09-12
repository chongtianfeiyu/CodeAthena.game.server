package CodeAthena.pack;

import org.apache.mina.core.buffer.IoBuffer;
import org.apache.mina.core.session.IoSession;
import org.apache.mina.filter.codec.CumulativeProtocolDecoder;
import org.apache.mina.filter.codec.ProtocolDecoderOutput;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
public class PackDecoder extends CumulativeProtocolDecoder {
	static final Logger log = LoggerFactory.getLogger(PackDecoder.class);

	@Override
	protected boolean doDecode(IoSession arg0, IoBuffer buffer, ProtocolDecoderOutput out) throws Exception {		
		if (buffer.remaining() >= Pack.HEAD_SIZE) {
			int pos = buffer.position();
			short len = PackUtils.unpackShort(buffer);
			byte type = PackUtils.unpackByte(buffer);
			byte compress = PackUtils.unpackByte(buffer);
			
			if (len <0) {
				throw new Exception("[pack] len < 0 ");
			}

			if (len == 0) {
				Pack pack = new Pack();
				pack.len = 0;
				pack.type = type;
				pack.compress = compress;
				pack.obj = null;
				out.write(pack);
				return true;
			}

			if (buffer.remaining() < len) {
				log.info("waiting left data");
				buffer.position(pos);
				return false;
			} else {
				int curpos = buffer.position();
				IoBuffer dataBuffer = IoBuffer.allocate(len, false);
				dataBuffer.put(buffer.array(), curpos, len);
				dataBuffer.flip();
				buffer.position(curpos + len);
				Pack pack = new Pack();
				pack.type = type;
				pack.compress = compress;
				pack.len = len;
				
				if ( type == PackType.TYPE_JSON && compress == PackType.COMPRESS_NONE )
				{
					String jsonText = PackUtils.unpackString(dataBuffer);
					pack.obj = jsonText;
				}
				
				out.write(pack);
				return true;
			}
		} else {
			return false;
		}
	}

}

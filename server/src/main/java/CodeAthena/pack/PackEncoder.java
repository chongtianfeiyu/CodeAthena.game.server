package CodeAthena.pack;

import org.apache.mina.core.buffer.IoBuffer;
import org.apache.mina.core.session.IoSession;
import org.apache.mina.filter.codec.ProtocolEncoder;
import org.apache.mina.filter.codec.ProtocolEncoderOutput;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class PackEncoder implements ProtocolEncoder {
	static final Logger log = LoggerFactory.getLogger(PackEncoder.class);
	public void encode(IoSession session, Object message, ProtocolEncoderOutput out) throws Exception {
		
		Pack pack = (Pack) message;
		
		String text=(String)pack.obj; 
		
		if ( text == null )
		{
			text = "";
		}
		
		IoBuffer objBuffer = IoBuffer.allocate(text.getBytes().length+8, true);
		
		PackUtils.packString(objBuffer, text);
		pack.len  = (short) objBuffer.position();
		
		IoBuffer newBuffer = IoBuffer.allocate(pack.len+4, false);
		
		PackUtils.packShort(newBuffer, pack.len);
		PackUtils.packByte(newBuffer, pack.type);
		PackUtils.packByte(newBuffer, pack.compress);
		PackUtils.packString(newBuffer, text);
		newBuffer.flip();
		out.write(newBuffer);
		
	}

	@Override
	public void dispose(IoSession arg0) throws Exception {
		

	}

}
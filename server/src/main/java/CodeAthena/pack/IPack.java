package CodeAthena.pack;

import org.apache.mina.core.buffer.IoBuffer;

public interface IPack {
	public void pack(IoBuffer out) throws Exception;

	public void unpack(IoBuffer buffer) throws Exception;
}

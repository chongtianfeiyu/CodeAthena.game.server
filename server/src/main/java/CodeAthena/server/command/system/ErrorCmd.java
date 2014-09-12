package CodeAthena.server.command.system;

import org.apache.mina.core.buffer.IoBuffer;

import CodeAthena.pack.PackUtils;
import CodeAthena.server.command.Command;

public class ErrorCmd extends Command {
	public int code;
	public String text;

	public void pack(IoBuffer out) throws Exception {
		PackUtils.packInt(out, code);
		PackUtils.packString(out, text);
	}

	public void unpack(IoBuffer in) throws Exception {
		code = PackUtils.unpackInt(in);
		text = PackUtils.unpackString(in);
	}
}

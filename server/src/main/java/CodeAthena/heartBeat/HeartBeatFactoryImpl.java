package CodeAthena.heartBeat;

import org.apache.mina.core.session.IoSession;
import org.apache.mina.filter.keepalive.KeepAliveMessageFactory;

import CodeAthena.pack.Pack;
import CodeAthena.pack.PackType;

public class HeartBeatFactoryImpl implements KeepAliveMessageFactory {

	public boolean isRequest(IoSession session, Object message) {
		Pack pack = (Pack) message;
		if (pack.type == PackType.TYPE_PING) {
			return true;
		}
		return false;
	}

	public boolean isResponse(IoSession session, Object message) {
		Pack pack = (Pack) message;
		if (pack.type == PackType.TYPE_PONG) {
			return true;
		}
		return false;
	}

	public Object getRequest(IoSession session) {
		Pack pack = new Pack();
		pack.len = 0;
		pack.type = PackType.TYPE_PING;
		pack.compress = PackType.COMPRESS_NONE;
		pack.obj = null;
		return pack;
	}

	public Object getResponse(IoSession session, Object request) {
		Pack pack = new Pack();
		pack.len = 0;
		pack.type = PackType.TYPE_PONG;
		pack.compress = PackType.COMPRESS_NONE;
		pack.obj = null;
		return pack;
	}
}

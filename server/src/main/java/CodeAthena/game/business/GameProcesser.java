package CodeAthena.game.business;

import org.apache.mina.core.service.IoHandlerAdapter;
import org.apache.mina.core.session.IdleStatus;
import org.apache.mina.core.session.IoSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import CodeAthena.game.command.LoginResponse;
import CodeAthena.pack.Pack;
import CodeAthena.pack.PackType;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;

public class GameProcesser extends IoHandlerAdapter {

	private final static Logger log = LoggerFactory.getLogger(GameProcesser.class);

	public void sessionCreated(IoSession session) throws Exception {
		log.info("sessionCreated");
	}

	public void sessionOpened(IoSession session) throws Exception {
		log.info("sessionOpened");
	}

	public void sessionClosed(IoSession session) throws Exception {
		log.info("sessionClosed");
	}

	public void sessionIdle(IoSession session, IdleStatus status) throws Exception {
		//log.info("sessionIdle");
	}

	public void exceptionCaught(IoSession session, Throwable cause) throws Exception {
		log.error("exceptionCaught, close session", cause);
		session.close(true);
	}

	public void messageReceived(IoSession session, Object message) throws Exception {
		log.error("messageReceived");
		
		Pack pack = (Pack)message;
		
		log.info((String)pack.obj);
		LoginResponse loginResponse = new LoginResponse();
		String text = JSON.toJSONString(loginResponse, SerializerFeature.WriteMapNullValue, SerializerFeature.WriteNullStringAsEmpty, SerializerFeature.WriteNullNumberAsZero);
		
		Pack response = new Pack();
		pack.type = PackType.TYPE_JSON;
		pack.compress = PackType.COMPRESS_NONE;
		pack.obj = text;
		session.write(pack);
	}

	public void messageSent(IoSession session, Object message) throws Exception {
		log.info("messageSent");
	}

}

package CodeAthena.game.business;

import java.util.concurrent.ConcurrentHashMap;

import org.apache.mina.core.session.IoSession;

public class GameApp {
	public static ConcurrentHashMap<Integer, IoSession> allUserSocketMap = new ConcurrentHashMap<Integer, IoSession>();
}

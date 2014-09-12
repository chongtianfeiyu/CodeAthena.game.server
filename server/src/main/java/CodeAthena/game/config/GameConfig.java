package CodeAthena.game.config;

import org.apache.commons.configuration.XMLConfiguration;

public class GameConfig {
	public static int port;
	public static int idleTimeout;
	public static int heartBeat;
	public static int heartBeatTimout;
	public static int heartBeatInterval;
	public static String text = "";

	public static void load() {
		XMLConfiguration config = null;
		try {
			config = new XMLConfiguration("config.xml");
			port = config.getInt("port", 6688);
			idleTimeout = config.getInt("idleTimeout", 60);
			heartBeat = config.getInt("heartBeat");
			heartBeatTimout = config.getInt("heartBeatTimout");
			heartBeatInterval = config.getInt("heartBeatInterval");
			config.clear();
		} catch (Exception e) {
			e.printStackTrace();
			port = 8888;
			heartBeat = 0;
			heartBeatTimout = 15;
			heartBeatInterval = 1;
		} finally {
			text =  "\n================================================================";
			text += "\n  [server port]       : " + port;
			text += "\n  [idleTimeout] : " + idleTimeout;
			text += "\n  [heartBeat] : " + heartBeat;
			text += "\n  [heartBeatTimout] : " + heartBeatTimout;
			text += "\n  [heartBeatInterval] : " + heartBeatInterval;
			text += "\n================================================================";
		}
	}
}

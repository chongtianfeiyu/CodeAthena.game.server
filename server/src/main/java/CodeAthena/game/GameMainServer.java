package CodeAthena.game;

import java.io.File;
import java.net.InetSocketAddress;
import java.util.concurrent.Executors;

import org.apache.mina.core.session.IdleStatus;
import org.apache.mina.filter.codec.ProtocolCodecFilter;
import org.apache.mina.filter.executor.ExecutorFilter;
import org.apache.mina.filter.keepalive.KeepAliveFilter;
import org.apache.mina.filter.keepalive.KeepAliveMessageFactory;
import org.apache.mina.transport.socket.nio.NioSocketAcceptor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import CodeAthena.game.business.GameProcesser;
import CodeAthena.game.config.GameConfig;
import CodeAthena.game.config.GameInfo;
import CodeAthena.heartBeat.HeartBeatFactoryImpl;
import CodeAthena.pack.PackFactory;
import ch.qos.logback.classic.LoggerContext;
import ch.qos.logback.classic.joran.JoranConfigurator;
import ch.qos.logback.core.joran.spi.JoranException;
import ch.qos.logback.core.util.StatusPrinter;

public class GameMainServer {
	static GameProcesser processer;

	public static void printVersion() {
		System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
		System.out.println("	                 version : " + GameInfo.version);
		System.out.println("	                 author  : " + GameInfo.author);
		System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
	}

	public static boolean logbackInit() {
		LoggerContext context = (LoggerContext) LoggerFactory.getILoggerFactory();
		boolean flag = false;
		try {
			JoranConfigurator configurator = new JoranConfigurator();
			configurator.setContext(context);
			context.reset();
			String logbackXml = System.getProperty("user.dir") + File.separatorChar + "logback.xml";
			configurator.doConfigure(logbackXml);
			System.out.println(logbackXml + " load ok.");
			flag = true;
		} catch (JoranException je) {
			je.printStackTrace();
			if (context != null) {
				StatusPrinter.print(context);
			}
		}
		return flag;
	}

	public static void main(String[] args) {
		if (!logbackInit()) {
			System.out.println("[logback] Init error");
			return;
		}

		GameConfig.load();

		final Logger log = LoggerFactory.getLogger(GameMainServer.class);
		try {
			processer = new GameProcesser();

			NioSocketAcceptor acceptor = new NioSocketAcceptor();
			acceptor.setReuseAddress(true);
			acceptor.getSessionConfig().setIdleTime(IdleStatus.BOTH_IDLE, GameConfig.idleTimeout);
			acceptor.getFilterChain().addLast("codec", new ProtocolCodecFilter(new PackFactory()));

			if (GameConfig.heartBeat == 1) {
				KeepAliveMessageFactory heartBeatFactory = new HeartBeatFactoryImpl();
				KeepAliveFilter heartBeat = new KeepAliveFilter(heartBeatFactory, IdleStatus.BOTH_IDLE);
				heartBeat.setForwardEvent(true);
				heartBeat.setRequestInterval(GameConfig.heartBeatInterval);
				heartBeat.setRequestTimeout(GameConfig.heartBeatTimout);
				acceptor.getFilterChain().addLast("heartbeat", heartBeat);
			}

			acceptor.getFilterChain().addLast("threadPool", new ExecutorFilter(Executors.newSingleThreadExecutor()));
			acceptor.setHandler(processer);
			acceptor.getSessionConfig().setReadBufferSize(1024);
			acceptor.getSessionConfig().setIdleTime(IdleStatus.BOTH_IDLE, 10);
			printVersion();
			System.out.println(GameConfig.text);
			System.out.println("server is running...");
			acceptor.bind(new InetSocketAddress(GameConfig.port));
		} catch (Exception e) {
			log.error("server error", e);
		}
	}
}

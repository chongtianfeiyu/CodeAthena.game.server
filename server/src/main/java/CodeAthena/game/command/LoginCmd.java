package CodeAthena.game.command;

import java.io.IOException;

import org.apache.mina.core.buffer.IoBuffer;

import CodeAthena.pack.PackUtils;
import CodeAthena.server.command.Command;

public class LoginCmd extends Command {

	private int userId;
	private String userName;
	private String userPassword;

	public void pack(IoBuffer out) throws IOException {
		PackUtils.packInt(out, userId);
		PackUtils.packString(out, userName);
		PackUtils.packString(out, userPassword);
	}

	public void unpack(IoBuffer in) throws IOException {
		userId = PackUtils.unpackInt(in);
		userName = PackUtils.unpackString(in);
		userPassword = PackUtils.unpackString(in);
	}
}

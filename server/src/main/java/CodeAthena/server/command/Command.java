package CodeAthena.server.command;

import org.apache.mina.core.buffer.IoBuffer;

import CodeAthena.pack.IPack;

public class Command implements IPack {
	private short mod;
	private short cmd;

	public Command() {
		
	}

	public void pack(IoBuffer out) throws Exception {
		
	}

	public void unpack(IoBuffer in) throws Exception {

	}

	public short getMod() {
		return mod;
	}

	public void setMod(short mod) {
		this.mod = mod;
	}

	public short getCmd() {
		return cmd;
	}

	public void setCmd(short cmd) {
		this.cmd = cmd;
	}

}
package CodeAthena.pack;

import java.nio.charset.CharacterCodingException;
import java.nio.charset.Charset;
import java.nio.charset.CharsetDecoder;
import java.nio.charset.CharsetEncoder;
import java.util.Date;

import org.apache.mina.core.buffer.IoBuffer;

public class PackUtils {

	public static CharsetDecoder charsetDecoder = Charset.forName("UTF8").newDecoder();
	public static CharsetEncoder charsetEncoder = Charset.forName("UTF8").newEncoder();

	public static void packBoolean(IoBuffer out, boolean val) {
		if (val) {
			packByte(out, (byte) 1);
		} else {
			packByte(out, (byte) 0);
		}
	}

	public static void packByte(IoBuffer out, byte val) {
		out.put(val);
	}

	public static void packChar(IoBuffer out, char val) {
		out.putChar(val);
	}

	public static void packShort(IoBuffer out, short val) {
		out.putShort(val);
	}

	public static void packInt(IoBuffer out, int val) {
		out.putInt(val);
	}

	public static void packLong(IoBuffer out, long val) {
		out.putLong(val);
	}

	public static void packFloat(IoBuffer out, float val) {
		out.putFloat(val);
	}

	public static void packDate(IoBuffer out, Date val) throws CharacterCodingException {
		out.putLong(val.getTime());

	}

	public static void packString(IoBuffer out, String val) throws CharacterCodingException {
		if (val == null) {
			val = "";
		}
		out.putPrefixedString(val, Charset.forName("UTF8").newEncoder());
	}

	public static void packIoBuffer(IoBuffer out, IoBuffer val) {
		out.put(val);
	}

	public static byte unpackByte(IoBuffer buffer) {
		byte val = buffer.get();
		return val;
	}

	public static char unpackChar(IoBuffer buffer) {
		char val = buffer.getChar();
		return val;
	}

	public static boolean unpackBoolean(IoBuffer buffer) {
		byte bool = unpackByte(buffer);
		boolean val;
		if (bool == 1) {
			val = true;
		} else {
			val = false;
		}
		return val;
	}

	public static int unpackInt(IoBuffer buffer) {
		int val = buffer.getInt();
		return val;
	}

	public static float unpackFloat(IoBuffer buffer) {
		float val = buffer.getFloat();
		return val;
	}

	public static String unpackString(IoBuffer buffer) throws CharacterCodingException {
		String val = buffer.getPrefixedString(charsetDecoder);
		return val;
	}

	public static Date unpackDate(IoBuffer buffer) {
		Long val = buffer.getLong();
		Date date = new Date(val);
		return date;
	}

	public static short unpackShort(IoBuffer buffer) {
		short val = buffer.getShort();
		return val;
	}

	public static long unpackLong(IoBuffer buffer) {
		long val = buffer.getLong();
		return val;
	}

	public static IoBuffer unpackIoBuffer(IoBuffer out) {
		int curpos = out.position();
		int size = out.limit() - curpos;
		IoBuffer newbuffer = IoBuffer.allocate(size, false);
		newbuffer.put(out.array(), curpos, size);
		newbuffer.flip();
		return newbuffer;
	}
}

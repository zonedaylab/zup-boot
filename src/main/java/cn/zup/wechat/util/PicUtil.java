package cn.zup.wechat.util;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
/**
 * @Description: 在微信端下载二进制图片，并保存到本地
 * @author han
 */
public class PicUtil {
	public static void downloadImg(String mediaId, String access_token,
			String filePath) {
		InputStream is = null;
		String url = "http://file.api.weixin.qq.com/cgi-bin/media/get?access_token="
				+ access_token + "&media_id=" + mediaId;
		try {
			URL urlGet = new URL(url);
			HttpURLConnection conn = (HttpURLConnection) urlGet
					.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Content-Type",
					"application/x-www-form-urlencoded");
			conn.setDoOutput(true);
			conn.setDoInput(true);

			System.setProperty("sun.net.client.defaultConnectTimeout", "30000");
			System.setProperty("sun.net.client.defaultReadTimeout", "30000");

			conn.connect();

			is = conn.getInputStream();

			byte[] data = new byte[1024];
			int len = 0;
			FileOutputStream fileOutputStream = null;
			try {
				fileOutputStream = new FileOutputStream(filePath);

				while ((len = is.read(data)) != -1)
					fileOutputStream.write(data, 0, len);
			} catch (IOException e) {
				e.printStackTrace();

				if (is != null) {
					try {
						is.close();
					} catch (IOException e2) {
						e2.printStackTrace();
					}
				}
				if (fileOutputStream == null)
					return;
				try {
					fileOutputStream.close();
				} catch (IOException e1) {
					e1.printStackTrace();
				}
			} finally {
				if (is != null) {
					try {
						is.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
				if (fileOutputStream != null)
					try {
						fileOutputStream.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
			}
			try {
				fileOutputStream.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}

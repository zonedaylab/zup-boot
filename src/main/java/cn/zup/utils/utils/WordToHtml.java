package cn.zup.utils.utils;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.apache.poi.hwpf.HWPFDocument;
import org.apache.poi.hwpf.converter.PicturesManager;
import org.apache.poi.hwpf.converter.WordToHtmlConverter;
import org.apache.poi.hwpf.usermodel.PictureType;

import org.apache.poi.xwpf.converter.core.BasicURIResolver;
import org.apache.poi.xwpf.converter.core.FileImageExtractor;
import org.apache.poi.xwpf.converter.xhtml.XHTMLConverter;
import org.apache.poi.xwpf.converter.xhtml.XHTMLOptions;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.w3c.dom.Document;

/**
 * doc文件转换html
 * @author 韩圣传
 * @date 2016-8-1
 */
public class WordToHtml {

	/**
	 * 
	 * 
	 * @param inputStream
	 * @param filepath
	 *            当word中有图片的时候，将图片存储的路径
	 * @return
	 */
	public static String convertDoc2Html(InputStream inputStream,
			String filepath) {
		if (inputStream != null) {

			final File catalog = new File(Config.ADVERTFILE_PATH + "/"
					+ filepath);
			if (catalog != null && !catalog.exists()) {
				catalog.mkdirs();
			}
			ByteArrayOutputStream outStream = new ByteArrayOutputStream();
			try {
				HWPFDocument wordDocument = new HWPFDocument(inputStream);
				WordToHtmlConverter wordToHtmlConverter = new WordToHtmlConverter(
						DocumentBuilderFactory.newInstance()
								.newDocumentBuilder().newDocument());
				// 图片保存
				wordToHtmlConverter.setPicturesManager(new PicturesManager() {

					public String savePicture(byte[] content,
							PictureType pictureType, String suggestedName,
							float widthInches, float heightInches) {
						File file = new File(catalog.getPath() + "/"
								+ suggestedName);
						try {
							OutputStream os = new FileOutputStream(file);
							os.write(content);
							os.close();
						} catch (FileNotFoundException e) {
							e.printStackTrace();
						} catch (IOException e) {
							e.printStackTrace();
						}

						// 获取http 地址
						String abPath = file.getAbsolutePath();
						String file_uri = abPath.substring(abPath
								.indexOf("file") + 4, abPath.length());
						file_uri = file_uri.replaceAll("\\\\", "/");
						String path = Config.ADVERTFILE_READPATH + file_uri;
						return path;
					}
				});

				wordToHtmlConverter.processDocument(wordDocument);
				Document htmlDocument = wordToHtmlConverter.getDocument();

				DOMSource domSource = new DOMSource(htmlDocument);
				StreamResult streamResult = new StreamResult(outStream);

				TransformerFactory tf = TransformerFactory.newInstance();
				Transformer serializer = tf.newTransformer();
				serializer.setOutputProperty(OutputKeys.ENCODING, "utf-8");
				serializer.setOutputProperty(OutputKeys.INDENT, "yes");
				serializer.setOutputProperty(OutputKeys.METHOD, "html");
				serializer.transform(domSource, streamResult);
				// 生成html代码
				String htmlCode = new String(outStream.toByteArray(), "UTF-8");
				return htmlCode;

			} catch (TransformerConfigurationException e) {
				e.printStackTrace();
			} catch (TransformerException e) {
				e.printStackTrace();
			} catch (IOException e1) {
				e1.printStackTrace();
			} catch (ParserConfigurationException e1) {
				e1.printStackTrace();
			} finally {
				if (outStream != null) {
					try {
						outStream.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
		}
		return "";
	}

	/**
	 * 2007 docx文件转换html
	 * 
	 * @param inputStream
	 * @return
	 */
	public static String convertDocx2Html(InputStream inputStream,
			String filepath) {
		if (inputStream != null) {
			ByteArrayOutputStream outStream = new ByteArrayOutputStream();
			try {
				File catalog = new File(Config.ADVERTFILE_PATH + "/" + filepath);
				if (catalog != null && !catalog.exists()) {
					catalog.mkdirs();
				}

				XWPFDocument document = new XWPFDocument(inputStream);
				// word图片存放路径
				File folder = new File(catalog.getPath());
				// 获取http 地址
				String httpPath = Config.ADVERTFILE_READPATH + File.separator
						+ filepath;
				// new BasicURIResolver(httpPath) 可以将word中图片的路径替换成你需要的http访问路径
				XHTMLOptions options = XHTMLOptions.create().URIResolver(
						new BasicURIResolver(httpPath));
				// 上传图片的物理路径
				options.setExtractor(new FileImageExtractor(folder));
				options.setIgnoreStylesIfUnused(false);
				options.setFragment(true);
				XHTMLConverter.getInstance().convert(document, outStream,
						options);

				// 生成html代码
				String htmlCode = new String(outStream.toByteArray());
				return htmlCode;
			} catch (IOException e1) {
				e1.printStackTrace();
			} finally {
				if (outStream != null) {
					try {
						outStream.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
		}

		return "";
	}

	/**
	 * @param args
	 * @throws IOException
	 * @throws ParserConfigurationException
	 * @throws TransformerException
	 */
	public static void main(String[] args) throws IOException,
			ParserConfigurationException, TransformerException {

		final String path = "E:\\jeecgworknew\\Test\\upfile\\";
		final String file = "aa.doc";
		
		long start = System.currentTimeMillis();
		
		
		
		InputStream input = new FileInputStream(path + file);
		HWPFDocument wordDocument = new HWPFDocument(input);
		WordToHtmlConverter wordToHtmlConverter = new WordToHtmlConverter(
				DocumentBuilderFactory.newInstance().newDocumentBuilder()
						.newDocument());
		wordToHtmlConverter.setPicturesManager(new PicturesManager() {
			public String savePicture(byte[] content, PictureType pictureType,
					String suggestedName, float widthInches, float heightInches) {
				File file = new File(path + suggestedName);
				try {
					OutputStream os = new FileOutputStream(file);
					os.write(content);
					os.close();
				} catch (FileNotFoundException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				return path + suggestedName;
			}
		});

		wordToHtmlConverter.processDocument(wordDocument);
		Document htmlDocument = wordToHtmlConverter.getDocument();
		File htmlFile = new File(path + "1aa.html");
		OutputStream outStream = new FileOutputStream(htmlFile);
		DOMSource domSource = new DOMSource(htmlDocument);
		StreamResult streamResult = new StreamResult(outStream);

		TransformerFactory tf = TransformerFactory.newInstance();
		Transformer serializer = tf.newTransformer();
		serializer.setOutputProperty(OutputKeys.ENCODING, "utf-8");
		serializer.setOutputProperty(OutputKeys.INDENT, "yes");
		serializer.setOutputProperty(OutputKeys.METHOD, "html");
		serializer.transform(domSource, streamResult);
		outStream.close();
		
		long end = System.currentTimeMillis();
		
		System.out.println(end-start);
		System.out.println("完成");
	}

}

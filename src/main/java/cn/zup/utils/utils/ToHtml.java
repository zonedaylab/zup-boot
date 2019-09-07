

package cn.zup.utils.utils;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.apache.commons.io.output.ByteArrayOutputStream;
import org.apache.poi.hwpf.HWPFDocument;
import org.apache.poi.hwpf.converter.PicturesManager;
import org.apache.poi.hwpf.converter.WordToHtmlConverter;
import org.apache.poi.hwpf.model.PicturesTable;
import org.apache.poi.hwpf.usermodel.CharacterRun;
import org.apache.poi.hwpf.usermodel.Paragraph;
import org.apache.poi.hwpf.usermodel.Picture;
import org.apache.poi.hwpf.usermodel.PictureType;
import org.apache.poi.hwpf.usermodel.Range;
import org.apache.poi.hwpf.usermodel.Table;
import org.apache.poi.hwpf.usermodel.TableCell;
import org.apache.poi.hwpf.usermodel.TableIterator;
import org.apache.poi.hwpf.usermodel.TableRow;
import org.apache.poi.xwpf.converter.core.BasicURIResolver;
import org.apache.poi.xwpf.converter.core.FileImageExtractor;
import org.apache.poi.xwpf.converter.core.FileURIResolver;
import org.apache.poi.xwpf.converter.xhtml.XHTMLConverter;
import org.apache.poi.xwpf.converter.xhtml.XHTMLOptions;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.w3c.dom.Document;

/**
 * 
 * @author Mafx
 *
 */
public class ToHtml {
	
	public static void main(String argv[]) {
		try {
			//doc2Html("f://1.doc", "1.doc.jsp");
			//docx2Html("f://3.docx", "3.docx.jsp");
			//docx2Html("f://4.docx", "4.docx.jsp");
			docx2Html("g://1//2//G.docx", "g.docx.jsp");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/**
	 * doc转换为html
	 * 
	 * @author samson
	 * @param fileName
	 * @param outPutFile
	 * @throws TransformerException
	 * @throws IOException
	 * @throws ParserConfigurationException
	 */
	public static void doc2Html(String fileName, String outPutFile) throws TransformerException, IOException, ParserConfigurationException {
		//获取pro文件中的跳转链接
		Map<String, String> map = OpenPropertiesFile.getProValue("filePath.properties");
		String tempPath = map.get("tempPath");
		String outPath = map.get("outPath");
		String codeFormat = map.get("codeFormat");
		
		outPutFile = outPath+outPutFile;
		long startTime = System.currentTimeMillis();
		HWPFDocument wordDocument = new HWPFDocument(new FileInputStream(fileName));
		WordToHtmlConverter wordToHtmlConverter = new WordToHtmlConverter(DocumentBuilderFactory.newInstance().newDocumentBuilder().newDocument());
		wordToHtmlConverter.setPicturesManager(new PicturesManager() {
			public String savePicture(byte[] content, PictureType pictureType, String suggestedName, float widthInches, float heightInches) {
				return "test/" +suggestedName;
			}
		});
		wordToHtmlConverter.processDocument(wordDocument);
		// 保存图片
		List<Picture> pics = wordDocument.getPicturesTable().getAllPictures();
		if (pics != null) {
			for (int i = 0; i < pics.size(); i++) {
				Picture pic = (Picture) pics.get(i);
				System.out.println();
				try {
					pic.writeImageContent(new FileOutputStream(tempPath + pic.suggestFullFileName()));
				} catch (FileNotFoundException e) {
					e.printStackTrace();
				}
			}
		}
		Document htmlDocument = wordToHtmlConverter.getDocument();
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		DOMSource domSource = new DOMSource(htmlDocument);
		StreamResult streamResult = new StreamResult(out);

		TransformerFactory tf = TransformerFactory.newInstance();
		Transformer serializer = tf.newTransformer();
		serializer.setOutputProperty(OutputKeys.ENCODING, codeFormat);
		serializer.setOutputProperty(OutputKeys.INDENT, "yes");
		serializer.setOutputProperty(OutputKeys.METHOD, "html");
		serializer.transform(domSource, streamResult);
		out.close();
		writeFile(new String(out.toByteArray()), outPutFile);
		System.out.println("Generate " + outPutFile + " with " + (System.currentTimeMillis() - startTime) + " ms.");
	}

	/**
	 * 写文件
	 * 
	 * @author samson
	 * @param content
	 * @param path
	 */
	public static void writeFile(String content, String path) {
		
//		String regExp = "&#\\d*;"; 
//        Matcher m = Pattern.compile(regExp).matcher(content);
//        StringBuffer sb = new StringBuffer();
//        while (m.find()) {
//            String s = m.group(0);
//            s = s.replaceAll("(&#)|;", "");
//            char c = (char) Integer.parseInt(s);
//            m.appendReplacement(sb, Character.toString(c));
//        }
//        m.appendTail(sb); 
		//获取pro文件中的跳转链接
		Map<String, String> map = OpenPropertiesFile.getProValue("filePath.properties");
		String codeFormat = map.get("codeFormat");
		
		FileOutputStream fos = null;
		BufferedWriter bw = null;
		try {
			File file = new File(path);
			fos = new FileOutputStream(file);
			bw = new BufferedWriter(new OutputStreamWriter(fos, codeFormat));
			bw.write(content);
		} catch (FileNotFoundException fnfe) {
			fnfe.printStackTrace();
		} catch (IOException ioe) {
			ioe.printStackTrace();
		} finally {
			try {
				if (bw != null)
					bw.close();
				if (fos != null)
					fos.close();
			} catch (IOException ie) {
			}
		}
	}

	/**
	 * docx格式word转换为html
	 * 
	 * @author samson
	 * @param fileName
	 *            docx文件路径
	 * @param outPutFile
	 *            html输出文件路径
	 * @throws TransformerException
	 * @throws IOException
	 * @throws ParserConfigurationException
	 */
	public static void docx2Html(String fileName, String outPutFile) throws TransformerException, IOException, ParserConfigurationException {
		//获取pro文件中的跳转链接
		Map<String, String> map = OpenPropertiesFile.getProValue("filePath.properties");
		String httpPicPath = map.get("httpPicPath");
		String tempPath = map.get("tempPath");
		String outPath = map.get("outPath");
		
		String fileOutName = outPath+outPutFile;
		long startTime = System.currentTimeMillis();
		XWPFDocument document = new XWPFDocument(new FileInputStream(fileName));
		//XHTMLOptions options = XHTMLOptions.create().indent(4);

 
		
		// 获取http 地址
		String httpPath = httpPicPath;
		// new BasicURIResolver(httpPath) 可以将word中图片的路径替换成你需要的http访问路径
		XHTMLOptions options = XHTMLOptions.create().URIResolver(
				new BasicURIResolver(httpPath)); 
		// 导出图片
		File imageFolder = new File(tempPath);
		options.setExtractor(new FileImageExtractor(imageFolder));
		// URI resolver
		//options.URIResolver(new FileURIResolver(imageFolder));
		options.setIgnoreStylesIfUnused(false);
		options.setFragment(true);
		File outFile = new File(fileOutName);
		outFile.getParentFile().mkdirs();
		OutputStream out = new FileOutputStream(outFile);
		XHTMLConverter.getInstance().convert(document, out, options);

		//writeFile(new String(out.toString()), fileOutName);
		
		System.out.println("Generate " + fileOutName + " with " + (System.currentTimeMillis() - startTime) + " ms.");

	}

}

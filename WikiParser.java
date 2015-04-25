package mediHelpMain;

import java.io.IOException;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class WikiParser {
	private final String urlStr = "http://en.wikipedia.org/wiki/";
	
	public String extractFirstPara(String title) throws IOException
	{
		title = title.replace(" ", "_");
		String url = urlStr + title;
		Document doc = Jsoup.connect(url).timeout(1000*1000).get();
		doc.setBaseUri(urlStr);
		String ans = "";
		Elements paragraphs = doc.select("#mw-content-text p");
		Element firstParagraph = paragraphs.first();
	    Element lastParagraph = paragraphs.last();
	    Element p;
	    int i=1;
	    p=firstParagraph;
	    System.out.println(p.text());
	    while (p!=lastParagraph){
	        p=paragraphs.get(i);
	        //System.out.println(p.text());
	        ans += p.text()+"\n\n\n\n";
	        i++;
	        if(i==6) break;
	    } 
	    
	    System.out.println(ans);
	    return ans;

	}
}

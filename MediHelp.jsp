<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import = "mediHelpMain.*, org.jsoup.*, org.jsoup.nodes.*, org.jsoup.nodes.Element, org.jsoup.select.Elements"
    errorPage="ShowError.jsp"
    %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link href="css/style.css" rel="stylesheet" type="text/css"/>
		<script type="text/javascript" src="js/jquery.js"></script>
		<title>MediHelp - A medical QA system</title>
	</head>
	<body>
		<div id="top"></div>
		<img src="imgs/mediHelp.png" alt="MediHelp" style="width:300px;height:145px" id="banner">
		<div id="body2">
		<p id="Geninfo">The main sources of MediHelp are WikiPedia, PubMed Abstracts, Healthboard forums and Dorland's Medical Dictionary for Health Care Consumers, which provide authoritative descriptions of medical conditions, medications, anatomical terms, noted medical personalities and much more.</p>
		
		<form id="search" method="post" action="MediHelp.jsp">
			<div id="searchbox">
					<input type="text" id="disease" name="disease" placeholder="Name of disease I'm searching for"/>
					<input type="submit" id="submit1" title="Submit" style="background: #4479BA;color: #FFF;"/>
					<input type="text" id="symptom" name="symptom" placeholder="Symptoms I'm having"/>
					<input type="submit" id="submit2" title="Submit1" style="background: #4479BA;color: #FFF;"/>
					<input type="text" id="question" name="question" placeholder="Enter general medical question"/>
					<input type="submit" id="submit3" title="Search" style="background: #4479BA;color: #FFF;"/>
			</div>
		</form>
		<% 
			long startTime = System.currentTimeMillis();
			long total = 0;
	      	String query =  request.getParameter("question"); 
			String query1 = null;
			String url = "", ans="";
			String time="0";  
			if (query == null || query.trim() == "") 
			 {%>
				<h2></h2>			
		 	<%}
			else {
			MediHelpMain mhm = new MediHelpMain();
			QueryParseNResults qpr = new QueryParseNResults();
			query1 = qpr.setQuery(query);
			TopicDetect td = new TopicDetect();
			String topic = td.getTopic(query1).toLowerCase();
			AttributeDetect ad = new AttributeDetect();
			String attribute = ad.getAttribute(query1).toLowerCase();
			QuestionTypeDetect qtd = new QuestionTypeDetect();
			String questionT = qtd.getCategory(query1).toLowerCase();
			AdditionalKeywordsDetect akd = new AdditionalKeywordsDetect();
			String keywords = akd.getKeywords(query1).toLowerCase();
			NLPOntology nlpo = new NLPOntology();
			String keywords1 = nlpo.getAttribute(query1).toLowerCase();			
			%>
			<h4>User Query: <em><%= query %></em></h4>	
			<h4>Query without stopwords: <em><%= query1 %></em></h4>
			<h4>Topic: <em><%= topic %></em></h4>
			<h4>Attribute: <em><%= attribute %></em></h4>
			<h4>Question Type: <em><%= questionT %></em></h4>
			<h4>Additional Keywords: <em><%= keywords %></em></h4>
			<%
			if (topic == null || topic.trim() == "")
			{
				
			}
			
			else
			{
				DBParser dbp = new DBParser();
				String urlStr1 = dbp.getDBParser()+topic;
				Connection con1 = Jsoup.connect(urlStr1).userAgent("Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.21 (KHTML, like Gecko) Chrome/19.0.1042.0 Safari/535.21").timeout(100000);
			    Connection.Response resp1 = con1.execute();
		

				
			    Document doc1 = null;
			    
			    if (resp1.statusCode() == 200) {
			    	   
			    	String html1 = resp1.body();
			    	doc1 = Jsoup.parse(html1);
				   doc1.select("span[style=color: black;]").remove();
				   doc1.select(".header_stripe").remove();
				   doc1.select(".header").remove();
				   doc1.select(".sidebar_style").get(3).remove();
			    	
					
					Elements paragraphs1 = doc1.select("div");
					Element firstParagraph = paragraphs1.first();
				    Element lastParagraph = paragraphs1.last();
				    Element p;
				    int j=2;
				    p=firstParagraph;
				   //System.out.println(p);
				    while (p!=lastParagraph){
				        p=paragraphs1.get(j);
				        //System.out.println(p.text());
				       %>
				        <p><%= p.text() %></p>
				        <%
				        j++;
				        if(j==100) break;
				    } 
				    
				  
				   			}

			}
			
			%> 
			
			
			<%} %>
			
			<% 
			String diseaseName =  request.getParameter("disease"); 
			if (diseaseName == null || diseaseName.trim() == "") 
			{%>
			<h2></h2>			
	 	<%}
			else{
				%>
			
			<% 
			MDParser dbp = new MDParser();
			String urlStr = dbp.getMDParser();
			String diseaseNameOutput = diseaseName;
			diseaseName = diseaseName.replace(" ", "+");
			
			String url1 = urlStr+diseaseName;
			Connection con = Jsoup.connect(url1).userAgent("Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.21 (KHTML, like Gecko) Chrome/19.0.1042.0 Safari/535.21").timeout(8000);
		    Connection.Response resp = con.execute();
		    Document doc = null;
		    
		    if (resp.statusCode() == 200) {
		    	   
		    	%>
		    	<h3 style = "font-size:25px;">Results for : <%= diseaseNameOutput %> </h3>
		    	<p><em>Please note that this information is not intended to be used in place of a visit, consultation, or advice of a medical professional.</em></p>
		    	<%
		    	
		    	  String html = resp.body();
		    	  doc = Jsoup.parse(html);
		    	  doc = Jsoup.parse(html);
			      doc.select(".afs_ads").remove();
			      doc.select(".footer-bottom").remove();
			      doc.select(".holder-list").remove();
			      doc.select(".footer-block").remove();
			      doc.select(".language-block").remove();
			      doc.select("link").remove();
			      doc.select("meta").remove();
			      doc.select("h4").remove();
			      //doc.select("h1").remove();
			      //doc.select("h3").remove();
			      doc.select("h2").remove();
			      //doc.select("ul").remove();
			      //doc.select("li").remove();
			      doc.select("tr").remove();
			      doc.select("td").remove();
			      doc.select("strong").remove();
			      doc.select("script").remove();
			      doc.select(".footer-block mobile-hidden").remove();
			      doc.select("#fixedBlock").remove();
			      doc.select("#sidebar").remove();
			   	  doc.select(".share-block").remove();
			      doc.select("#footer").remove();
			      doc.select(".pic").remove();
		    	  //System.out.println(doc);
		    	  
		    	 Elements paragraph1 = doc.select("#Definition section");
		    	  		    		 
		    	 Element theList= paragraph1.get(0);
		    	 String section = theList+"";
		    	 // String section ="";
		    	  %>
				 <p style="color:black;font-size: 14px;"><%= section %></p> 
		    	  <%	
		    	  
		    	// Elements paragraphs = doc.select("#Definition");
		    	// int i;
		    	// String key = "", key7="";
		    	// for(i=1;i<10;i++)
		    		//{
					//Element firstParagraph = paragraphs.select("h3").get(i);
					//Element sec = paragraphs.select("div").get(i);
					//key = firstParagraph.text()+"\n";
					//key7 =  sec.text();
					String key = null,key7 = null;
		    	  %>
		    	   <!-- <p><%= key %></p> --> 
		    	  <!-- <p><%= key7 %></p> 	-->
		    	  
		    	  <%
		    	 	//}	 
		    	  
		    	  
		    	%>
		    				
		  			<hr>
				       
				       <%
				       DBParser dbp1 = new DBParser();
						String urlStr1 = dbp1.getDBParser()+diseaseName;
						Connection con1 = Jsoup.connect(urlStr1).userAgent("Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.21 (KHTML, like Gecko) Chrome/19.0.1042.0 Safari/535.21").timeout(100000);
					    Connection.Response resp1 = con1.execute();
				

						
					    Document doc1 = null;
					    
					    if (resp1.statusCode() == 200) {
					    	   
					    	String html1 = resp1.body();
					    	doc1 = Jsoup.parse(html1);
						   doc1.select("span[style=color: black;]").remove();
						   doc1.select(".header_stripe").remove();
						   doc1.select(".header").remove();
						   doc1.select(".sidebar_style").get(3).remove();
					    	
							
							Elements paragraphs1 = doc1.select("div");
							Element firstParagraph = paragraphs1.first();
						    Element lastParagraph = paragraphs1.last();
						    Element p;
						    int j=2;
						    p=firstParagraph;
						   //System.out.println(p);
						    while (p!=lastParagraph){
						        p=paragraphs1.get(j);
						        //System.out.println(p.text());
						       %>
						        <p><%= p.text() %></p>
						        <%
						        j++;
						        if(j==100) break;
						    } 
						    
						  
						   			}

		    		
		    			

		        }
			} 
			
			String symptoms =  request.getParameter("symptom");

			if (symptoms == null || symptoms.trim() == "") 
			{%>
			<h2></h2>			
	 	<%}
		else
	 	{
			QueryParseNResults qpr1  = new QueryParseNResults();
			symptoms = qpr1.remStopWords(symptoms);
			 DBParser dbp2 = new DBParser();
			String urlStr = dbp2.getDBParser();
			//String urlStr = "http://gotoanswer.com/?q=";
			symptoms = symptoms.replace(" ", "+");
			String url1 = urlStr+symptoms;
			   
			
			Connection con = Jsoup.connect(url1).userAgent("Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.21 (KHTML, like Gecko) Chrome/19.0.1042.0 Safari/535.21").timeout(8000);
		    Connection.Response resp = con.execute();
	

			
		    Document doc = null;
		    
		    if (resp.statusCode() == 200) {
		    	   
		    	String html = resp.body();
		    	doc = Jsoup.parse(html);
			   doc.select("span[style=color: black;]").remove();
			   doc.select(".header_stripe").remove();
			   doc.select(".header").remove();
			   doc.select(".sidebar_style").get(3).remove();
		    	
				
				Elements paragraphs = doc.select("div");
				Element firstParagraph = paragraphs.first();
			    Element lastParagraph = paragraphs.last();
			    Element p;
			    int i=3;
			    p=firstParagraph;
			   //System.out.println(p);
			    while (p!=lastParagraph){
			        p=paragraphs.get(i);
			       // System.out.println(p.text());
			        %>
			        <p><%= p.text() %></p>
			        <%
			        
			        i++;
			        if(i==100) break;
			    } 
			    
			  
			   			}
		
	 	}
			long stopTime = System.currentTimeMillis();
		    long elapsedTime = stopTime - startTime;
		    System.out.println(elapsedTime);	
		%>
		</div>	
	</body>
</html>
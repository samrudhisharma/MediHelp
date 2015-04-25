package mediHelpMain;

public class WikiCitationsRemove {
	public String remStopWords(String text) {
		
		String[] query = text.split(" ");
		StringBuilder sb = new StringBuilder();
		String[] stopwords = {"[1]","[2]","[3]","[4]","[5]","[6]","[7]","[8]","[9]","[10]","[11]","[12]","[13]","[14]"};//expand list
		for (int i = 0; i < query.length; i++) {
		
			B:for (int j = 0; j < stopwords.length; j++) {
				if (query[i].toLowerCase().equals(stopwords[j])) { 
					break B;
				} 
				else { 
			
					if(j==stopwords.length-1)
					{
						sb.append(query[i]+" ");

					}
				}
			}
		} 
		return sb.toString().trim();
	}
		
	
}

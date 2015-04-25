package mediHelpMain;

public class QueryParseNResults {

	public static String query1;
	public static String query2 = "Who is Roy ?";
	public static String Topic = "meow";
	public static String qCategory;
	public static String Attribute;
	
	public QueryParseNResults()
	{
		
		
	}
	
	public String remStopWords(String text) {
		String[] query = text.split(" ");
		StringBuilder sb = new StringBuilder();
		String[] stopwords = {"is","was","the","a","and","has","have","had","in","into","an","as","at","on"};//expand list
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
	public String clean(String text)
	{
		return text.replaceAll("['!@#%\\$\\^\\(\\)\\~\\?]", "");
	}
	public String setQuery(String query) {
		
				query1 = query.toLowerCase();
				query1 = remStopWords(query);
				query1 = clean(query1);
				return query1;
				
	}
}

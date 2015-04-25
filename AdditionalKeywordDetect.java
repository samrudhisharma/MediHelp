package mediHelpMain;

import java.util.ArrayList;
import java.util.List;

import edu.stanford.nlp.ling.CoreLabel;
import edu.stanford.nlp.ling.Sentence;
import edu.stanford.nlp.parser.lexparser.LexicalizedParser;
import edu.stanford.nlp.trees.Tree;

public class AdditionalKeywordsDetect {
	public String getKeywords(String query)
	{
		
	
		LexicalizedParser lp = LexicalizedParser.loadModel("edu/stanford/nlp/models/lexparser/englishPCFG.ser.gz");
		String[] sent = query.split(" ");
		List<CoreLabel> rawWords = Sentence.toCoreLabelList(sent);
	    Tree parse = lp.apply(rawWords);
		List<Tree> l = GetProperNounPhrases(parse);
		String Topic="";
		for (int i = 0; i < l.size(); i++) {
			for (Tree subtree: l.get(i))
			{  
				if(subtree.isLeaf())
				{
					if(Topic.equals(""))
					{
						Topic = subtree.label().toString();
					}
					else
					{
						Topic = Topic +" "+subtree.label();
					}
				}
			}
		}
		return Topic;
	}
	
	public static List<Tree> GetProperNounPhrases(Tree parse)
	{

		List<Tree> phraseList=new ArrayList<Tree>();
		for (Tree subtree: parse)
		{
    
			if(subtree.label().value().equals("NNS")||subtree.label().value().equals("NNP")||subtree.label().value().equals("NNPS"))
			{
				phraseList.add(subtree);
				//System.out.println(subtree);				
			}
		}

		return phraseList;

	}
	
}

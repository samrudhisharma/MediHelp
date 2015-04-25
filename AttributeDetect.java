package mediHelpMain;

import java.util.ArrayList;
import java.util.List;

import edu.stanford.nlp.ling.CoreLabel;
import edu.stanford.nlp.ling.Sentence;
import edu.stanford.nlp.parser.lexparser.LexicalizedParser;
import edu.stanford.nlp.trees.Tree;

public class AttributeDetect {
	
	public static List<Tree> GetRemainingPhrases(Tree parse)
	{

		List<Tree> phraseList=new ArrayList<Tree>();
		for (Tree subtree: parse)
		{
    
			if(subtree.label().value().equals("FW")||subtree.label().value().equals("IN")||subtree.label().value().equals("JJ")||subtree.label().value().equals("JJR")||subtree.label().value().equals("JJS")||subtree.label().value().equals("RB")||subtree.label().value().equals("VB")||subtree.label().value().equals("VBD")||subtree.label().value().equals("VBG")||subtree.label().value().equals("VBN")||subtree.label().value().equals("VBP"))
			{
				phraseList.add(subtree);
				//System.out.println(subtree);
			}
		}

		return phraseList;

	}

	public String getAttribute(String query) {
		LexicalizedParser lp = LexicalizedParser.loadModel("edu/stanford/nlp/models/lexparser/englishPCFG.ser.gz");
		String[] sent = query.split(" ");
		List<CoreLabel> rawWords = Sentence.toCoreLabelList(sent);
		Tree parse = lp.apply(rawWords);
		List<Tree> l = GetRemainingPhrases(parse);
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

	
}


package dao;

import dbcon.DatabaseConnection;
import dto.Questions_dto;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;

public class Questions_dao {
    
    private static Connection con;
    private static PreparedStatement pst;
    private static ResultSet rs;
    
    public static boolean addQuestion(Questions_dto obj){
        
        boolean b = false;
        
        try{
            
            con = DatabaseConnection.getConnection();
            
            pst = con.prepareStatement("insert into questions(question, questioner_email_id, category, tag1, tag2, tag3, tag4, tag5) values(?,?,?,?,?,?,?,?)");
            pst.setString(1, obj.getQuestion());
            pst.setString(2, obj.getQuestionerEmailID());
            pst.setString(3, obj.getCategory());
            pst.setString(4, obj.getTag1());
            pst.setString(5, obj.getTag2());
            pst.setString(6, obj.getTag3());
            pst.setString(7, obj.getTag4());
            pst.setString(8, obj.getTag5());
            
            int x = pst.executeUpdate();
            
            if(x>0)
                b = true;
            
            con.close();
            
        }catch(SQLException e){
            e.printStackTrace();
        }
        
        return b;
    }
    
    public static ArrayList<Questions_dto> getAllQuestionsOfQuestioner(String questionerId){
    
        ArrayList<Questions_dto> quesList = new ArrayList<>();
        
        try{
            
            con = DatabaseConnection.getConnection();
            
            pst = con.prepareStatement("select * from questions where questioner_email_id = ?");
            pst.setString(1, questionerId);
            
            rs = pst.executeQuery();
            
            if(rs.isBeforeFirst()){
                while(rs.next()){
                    Questions_dto obj = new Questions_dto();
                    obj.setQuestionID(rs.getInt("question_id"));
                    obj.setQuestion(rs.getString("question"));
                    
                    quesList.add(obj);
                }
            }
            
            con.close();
        
        }catch(SQLException e){
            e.printStackTrace();
        }
        
        return quesList;
    }
    
    public static boolean deleteQuestion(int quesId){
    
        boolean b = false;
        
        try{
            
            con = DatabaseConnection.getConnection();
            
            pst = con.prepareStatement("delete from questions where question_id = ?");
            pst.setInt(1, quesId);
            
            int x = pst.executeUpdate();
            
            if(x>0)
                b = true;
            
            con.close();
        
        }catch(SQLException e){
            e.printStackTrace();
        }
        
        return b;
    }
    
    public static ArrayList<Questions_dto> getAllQuestionsOfCategory(String category){
    
        ArrayList<Questions_dto> quesDetails = new ArrayList<>();
        
        try{
        
            con = DatabaseConnection.getConnection();
            
            pst = con.prepareStatement("select * from questions where category = ?");
            pst.setString(1, category);
            
            rs = pst.executeQuery();
            
            if(rs.isBeforeFirst()){
                while(rs.next()){
                    
                    Questions_dto obj = new Questions_dto();
                    obj.setQuestionID(rs.getInt("question_id"));
                    obj.setQuestion(rs.getString("question"));
                    obj.setQuestionerEmailID(rs.getString("questioner_email_id"));
                    obj.setCategory(rs.getString("category"));
                    obj.setTag1(rs.getString("tag1"));
                    obj.setTag2(rs.getString("tag2"));
                    obj.setTag3(rs.getString("tag3"));
                    obj.setTag4(rs.getString("tag4"));
                    obj.setTag5(rs.getString("tag5"));
                    
                    quesDetails.add(obj);
                }
            }
            
            con.close();
            
        }catch(SQLException e){
            e.printStackTrace();
        }
        
        return quesDetails;
    }
    
    public static String getQuestionFromQuestionID(int quesID){
    
        String ques = null;
        
        try{
            
            con = DatabaseConnection.getConnection();
            
            pst = con.prepareStatement("select question from questions where question_id = ?");
            pst.setInt(1, quesID);
            
            rs = pst.executeQuery();
            
            if(rs.isBeforeFirst()){
                rs.next();
                ques = rs.getString("question");
            }
            
            con.close();
            
        }catch(SQLException e){
            e.printStackTrace();
        }
        
        return ques;
    }
    
    public static ArrayList<Questions_dto> getAllQuestions(){
        
        ArrayList<Questions_dto> qList = new ArrayList<>();
        
        try{
        
            con = DatabaseConnection.getConnection();
            
            pst = con.prepareStatement("select question_id, question, tag1, tag2, tag3, tag4, tag5 from questions");
            
            rs = pst.executeQuery();
            
            if(rs.isBeforeFirst()){
                while(rs.next()){
                    Questions_dto obj = new Questions_dto();
                    obj.setQuestionID(rs.getInt("question_id"));
                    obj.setQuestion(rs.getString("question"));
                    obj.setTag1(rs.getString("tag1"));
                    obj.setTag2(rs.getString("tag2"));
                    obj.setTag3(rs.getString("tag3"));
                    obj.setTag4(rs.getString("tag4"));
                    obj.setTag5(rs.getString("tag5"));
                    
                    qList.add(obj);
                }
            }
            
            con.close();
            
        }catch(SQLException e){
            e.printStackTrace();
        }
        
        return qList;
    }
    
    public static ArrayList<Questions_dto> searchResults(String question){
        
        String uselessWords[] = {"i", "me", "my", "myself", "we", "our", "ours", "ourselves" ,
            "you", "you're", "you've", "you'll", "you'd", "your", "yours", "yourself" ,
            "yourselves","he", "him", "his", "himself", "she", "she's", "her", "hers", "herself",
            "it", "it's", "its", "itself", "they" , "them" , "their", "theirs","themselves",
            "what", "which", "who", "whom", "this", "that", "that'll", "these", "those", "am",
            "is", "are", "was", "were","be", "been","being", "have", "has", "had", "having",
            "do", "does", "did", "doing", "a", "an", "the", "and", "but", "if", "or", "because", "as",
            "until", "while", "of", "at", "by", "for", "with", "about", "against", "between", "into",
            "through", "during", "before", "after", "above", "below", "to", "from", "up", "down", "in",
            "out", "on", "off", "over", "under", "again", "further", "then", "once", "here", "there", "when",
            "where", "why", "how", "all", "any", "both", "each", "few", "more", "most", "other", "some",
            "such", "no", "nor", "not", "only", "own", "same", "so", "than", "too", "very", "s", "t",
            "can", "will", "just", "don", "don't", "should", "should've", "now", "d", "ll", "m", "o", "re",
            "ve", "y", "ain", "aren", "aren't", "couldn", "couldn't", "didn", "didn't", "doesn", "doesn't",
            "hadn", "hadn't", "hasn", "hasn't", "haven", "haven't", "isn", "isn't", "ma", "mightn", "mightn't",
            "mustn", "mustn't", "needn", "needn't", "shan", "shan't", "shouldn", "shouldn't", "wasn", "wasn't",
            "weren", "weren't", "won", "won't", "wouldn", "wouldn't"};
        
        String ques[] = question.split("[ ,.?-]");
        ArrayList<String> quesWords = new ArrayList<>();
        for(String w : ques){
            if(w != null && !w.equals("")){
                int flagg = 0;
                for(String word : uselessWords){
                    if(w.toLowerCase().equals(word)){
                        flagg = 1;
                        break;
                    }
                }
                if(flagg == 0){
                    quesWords.add(w);
                }
            }
        }
        
        ArrayList<Questions_dto> quesFromDB = getAllQuestions();
        Iterator itr = quesFromDB.iterator();
        
        ArrayList<Questions_dto> searchResult = new ArrayList<>();
        
        while(itr.hasNext()){
            Questions_dto qObj = (Questions_dto)itr.next();
            
            int tagsMatched = 0;
            
            for(String w : quesWords){
                if(qObj.getTag1().toLowerCase().equals(w) || qObj.getTag2().toLowerCase().equals(w) || qObj.getTag3().toLowerCase().equals(w) || qObj.getTag4().toLowerCase().equals(w) || qObj.getTag5().toLowerCase().equals(w)){
                    tagsMatched += 1;
                    if(tagsMatched >= 3){
                        searchResult.add(qObj);
                        break;
                    }
                }
            }
        }
        
        return searchResult;
    }
}

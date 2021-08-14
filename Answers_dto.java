package dto;

public class Answers_dto {
    
    private int answerID;
    private String answer;
    private int questionID;
    private String expertID;
    private int agree;
    private int disagree;

    public Answers_dto() {
    }

    public Answers_dto(int answerID, String answer, int questionID, String expertID, int agree, int disagree) {
        this.answerID = answerID;
        this.answer = answer;
        this.questionID = questionID;
        this.expertID = expertID;
        this.agree = agree;
        this.disagree = disagree;
    }

    public void setAnswerID(int answerID) {
        this.answerID = answerID;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public void setQuestionID(int questionID) {
        this.questionID = questionID;
    }

    public void setExpertID(String expertID) {
        this.expertID = expertID;
    }

    public void setAgree(int agree) {
        this.agree = agree;
    }

    public void setDisagree(int disagree) {
        this.disagree = disagree;
    }

    public int getAnswerID() {
        return answerID;
    }

    public String getAnswer() {
        return answer;
    }

    public int getQuestionID() {
        return questionID;
    }

    public String getExpertID() {
        return expertID;
    }

    public int getAgree() {
        return agree;
    }

    public int getDisagree() {
        return disagree;
    }
}

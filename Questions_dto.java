package dto;

public class Questions_dto {

    private int questionID;
    private String question;
    private String category;
    private String questionerEmailID;
    private String tag1;
    private String tag2;
    private String tag3;
    private String tag4;
    private String tag5;

    public Questions_dto() {
    }

    public Questions_dto(int questionID, String question, String category, String questionerEmailID, String tag1, String tag2, String tag3, String tag4, String tag5) {
        this.questionID = questionID;
        this.question = question;
        this.category = category;
        this.questionerEmailID = questionerEmailID;
        this.tag1 = tag1;
        this.tag2 = tag2;
        this.tag3 = tag3;
        this.tag4 = tag4;
        this.tag5 = tag5;
    }

    public void setQuestionID(int questionID) {
        this.questionID = questionID;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public void setQuestionerEmailID(String questionerEmailID) {
        this.questionerEmailID = questionerEmailID;
    }

    public void setTag1(String tag1) {
        this.tag1 = tag1;
    }

    public void setTag2(String tag2) {
        this.tag2 = tag2;
    }

    public void setTag3(String tag3) {
        this.tag3 = tag3;
    }

    public void setTag4(String tag4) {
        this.tag4 = tag4;
    }

    public void setTag5(String tag5) {
        this.tag5 = tag5;
    }

    public int getQuestionID() {
        return questionID;
    }

    public String getQuestion() {
        return question;
    }

    public String getCategory() {
        return category;
    }

    public String getQuestionerEmailID() {
        return questionerEmailID;
    }

    public String getTag1() {
        return tag1;
    }

    public String getTag2() {
        return tag2;
    }

    public String getTag3() {
        return tag3;
    }

    public String getTag4() {
        return tag4;
    }

    public String getTag5() {
        return tag5;
    }
}

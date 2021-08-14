package dto;

public class Expert_dto {


    private String firstName;
    private String lastName;
    private String emailID;
    private String password;
    private String category;
    private int reportCount;
    private boolean block;

    public Expert_dto() {
    }

    public Expert_dto(String firstName, String lastName, String emailID, String password, String category, int reportCount, boolean block) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.emailID = emailID;
        this.password = password;
        this.category = category;
        this.reportCount = reportCount;
        this.block = block;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public void setEmailID(String emailID) {
        this.emailID = emailID;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public void setReportCount(int reportCount) {
        this.reportCount = reportCount;
    }

    public void setBlock(boolean block) {
        this.block = block;
    }

    public String getFirstName() {
        return firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public String getEmailID() {
        return emailID;
    }

    public String getPassword() {
        return password;
    }

    public String getCategory() {
        return category;
    }

    public int getReportCount() {
        return reportCount;
    }

    public boolean getBlock() {
        return block;
    }
}

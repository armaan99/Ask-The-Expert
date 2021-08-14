package dto;

public class Questioner_dto {
    
    private String firstName;
    private String lastName;
    private String emailID;
    private String password;
    private String confirmPassword;
    private int reportCount;
    private boolean block;

    public Questioner_dto() {
    }

    public Questioner_dto(String firstName, String lastName, String emailID, String password, String confirmPassword, int reportCount, boolean block) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.emailID = emailID;
        this.password = password;
        this.confirmPassword = confirmPassword;
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

    public void setConfirmPassword(String confirmPassword) {
        this.confirmPassword = confirmPassword;
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

    public String getConfirmPassword() {
        return confirmPassword;
    }

    public int getReportCount() {
        return reportCount;
    }

    public boolean getBlock() {
        return block;
    }

    
}

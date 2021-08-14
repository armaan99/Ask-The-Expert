package dto;

public class Admin_dto {

    private String firstName;
    private String lastName;
    private String emailID;
    private String password;

    public Admin_dto() {
    }

    public Admin_dto(String firstName, String lastName, String emailID, String password) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.emailID = emailID;
        this.password = password;
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
}

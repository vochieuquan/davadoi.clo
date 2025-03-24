package model;

import java.sql.Date;

public class User {
    private int id;
    private String firstName;
    private String lastName;
    private String gender;
    private Date dob;
    private String username;
    private String email;
    private String passwordHash;
    private String userRole;
    private String status;

    public User(int id, String firstName, String lastName, String gender, Date dob,
                String username, String email, String passwordHash, String userRole, String status) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.gender = gender;
        this.dob = dob;
        this.username = username;
        this.email = email;
        this.passwordHash = passwordHash;
        this.userRole = userRole;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public Date getDob() {
        return dob;
    }

    public void setDob(Date dob) {
        this.dob = dob;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public String getUserRole() { 
        return userRole;
    }

    public void setUserRole(String userRole) { 
        this.userRole = userRole;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}

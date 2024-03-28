package com.spm.g8t6.Registration;
import com.fasterxml.jackson.annotation.JsonProperty;
import javax.persistence.*;


@Entity
@Table
public class registration {
    @Id
    @Column
    private int Reg_ID;

    @Column
    private String Course_ID;

    @Column
    private int Staff_ID;

    @Column
    private String Reg_Status;

    @Column
    private String Completion_Status;

    public registration(){

    }

    public registration(@JsonProperty("id") int id,
                        @JsonProperty("course_id") String cID,
                        @JsonProperty("staff_id") int sID,
                        @JsonProperty("reg_status") String regStatus,
                        @JsonProperty("completion_status") String completionStatus
                        ){
        this.Reg_ID = id;
        this.Course_ID = cID;
        this.Staff_ID = sID;
        this.Reg_Status = regStatus;
        this.Completion_Status = completionStatus;


    }

    public registration(@JsonProperty("course_id") String cID,
                        @JsonProperty("staff_id") int sID,
                        @JsonProperty("reg_status") String regStatus,
                        @JsonProperty("completion_status") String completionStatus
                        ){
        this.Course_ID = cID;
        this.Staff_ID = sID;
        this.Reg_Status = regStatus;
        this.Completion_Status = completionStatus;
    
    }

    public int getReg_ID() {
        return Reg_ID;
    }

    public String getCourse_ID() {
        return Course_ID;
    }

    public int getStaff_ID() {
        return Staff_ID;
    }

    public String getReg_Status() {
        return Reg_Status;
    }

    public String getCompletion_Status() {
        return Completion_Status;
    }

    public void setReg_ID(int reg_ID) {
        Reg_ID = reg_ID;
    }

    public void setCourse_ID(String course_ID) {
        Course_ID = course_ID;
    }

    public void setStaff_ID(int staff_ID) {
        Staff_ID = staff_ID;
    }

    public void setReg_Status(String reg_Status) {
        Reg_Status = reg_Status;
    }

    public void setCompletion_Status(String completion_Status) {
        Completion_Status = completion_Status;
    }
    
}

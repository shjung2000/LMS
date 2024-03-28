package com.spm.g8t6.Course;


import com.fasterxml.jackson.annotation.JsonProperty;

import javax.persistence.*;

@Entity
@Table(name = "course")
public class course {
    @Id
    @Column
    private String Course_ID;

    @Column
    private String Course_Name;

    @Column
    private String Course_Desc;

    @Column
    private String Course_Status;

    @Column
    private String Course_Type;

    @Column
    private String Course_Category;

    @Column
    private int Course_Is_Active;

    

    public course(){

    }

    public course(@JsonProperty("course_id") String course_id,
                  @JsonProperty("course_name") String course_name,
                  @JsonProperty("course_desc") String course_desc,
                  @JsonProperty("course_status") String course_status,
                  @JsonProperty("course_type") String course_type,
                  @JsonProperty("course_category") String course_category,
                  @JsonProperty("course_active") int course_is_active) {
        Course_ID = course_id;
        Course_Name = course_name;
        Course_Desc = course_desc;
        Course_Status = course_status;
        Course_Type = course_type;
        Course_Category = course_category;
        Course_Is_Active = course_is_active;
    }


    public String getCourse_ID() {
        return Course_ID;
    }

    public void setCourse_ID(String course_ID) {
        Course_ID = course_ID;
    }


    public String getCourse_Name() {
        return Course_Name;
    }

    public void setCourse_Name(String course_Name) {
        Course_Name = course_Name;
    }

    public String getCourse_Desc() {
        return Course_Desc;
    }

    public void setCourse_Desc(String course_Desc) {
        Course_Desc = course_Desc;
    }

    public String getCourse_Status() {
        return Course_Status;
    }

    public void setCourse_Status(String course_Status) {
        Course_Status = course_Status;
    }

    public String getCourse_Type() {
        return Course_Type;
    }

    public void setCourse_Type(String course_Type) {
        Course_Type = course_Type;
    }

    public String getCourse_Category() {
        return Course_Category;
    }

    public void setCourse_Category(String course_Category) {
        Course_Category = course_Category;
    }

    public int getCourse_Is_Active() {
        return Course_Is_Active;
    }

    public void setCourse_Is_Active(int course_Is_Active) {
        Course_Is_Active = course_Is_Active;
    }


}

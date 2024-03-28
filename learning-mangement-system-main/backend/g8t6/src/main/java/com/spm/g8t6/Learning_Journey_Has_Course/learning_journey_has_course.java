package com.spm.g8t6.Learning_Journey_Has_Course;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonProperty;

@Entity
@Table
public class learning_journey_has_course {
    
    @Id
    @Column
    private int LJ_HC_ID;

    @Column
    private int Learning_Journey_LJ_ID;

    @Column
    private String Course_ID;


    public learning_journey_has_course(){

    }

    public learning_journey_has_course(@JsonProperty("ID") int id,
                                       @JsonProperty("LJ_ID") int lj_id,
                                       @JsonProperty("course_id") String course_id){
        this.LJ_HC_ID = id;
        this.Learning_Journey_LJ_ID = lj_id;
        this.Course_ID = course_id;
    }


    public int getID(){
        return this.LJ_HC_ID;
    }

    public int getLJID(){
        return this.Learning_Journey_LJ_ID;
    }

    public String getCourseID(){
        return this.Course_ID;
    }

    
}

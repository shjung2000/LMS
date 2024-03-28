package com.spm.g8t6.Learning_Journey_Has_Course;

import com.fasterxml.jackson.annotation.JsonProperty;

public class LJ_Has_Course_Request_Body {
    private int role_id;

    private String course_id;
    

    public LJ_Has_Course_Request_Body(){

    }

    public LJ_Has_Course_Request_Body(@JsonProperty("role_id") int rID,
                                           @JsonProperty("course_id") String id){
        this.role_id = rID;
        this.course_id = id;
    }

    
    public int getRole_ID(){
        return this.role_id;
    }

    public String getCourse_ID(){
        return this.course_id;
    }
}

package com.spm.g8t6.Registration;

import com.fasterxml.jackson.annotation.JsonProperty;

public class registerDataTransfer {
    
    private String Course_ID;
    private int Staff_ID;
    
    public registerDataTransfer(){
    
    }
    
    public registerDataTransfer(@JsonProperty("course_id") String course_id,
                                    @JsonProperty("staff_id") int staff_id){
        this.Course_ID = course_id;
        this.Staff_ID = staff_id;
    }
    
    public String getCourseID(){
        return this.Course_ID;
    }
    
    public int getStaffID(){
        return this.Staff_ID;
    }

}

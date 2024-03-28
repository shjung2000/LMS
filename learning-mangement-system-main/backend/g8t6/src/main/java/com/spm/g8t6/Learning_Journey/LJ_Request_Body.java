package com.spm.g8t6.Learning_Journey;

import com.fasterxml.jackson.annotation.JsonProperty;

public class LJ_Request_Body {
    private int staff_id;
    private int role_id;


    public LJ_Request_Body(){
        
    }


    public LJ_Request_Body(@JsonProperty("staff_id") int staff_id,
                  @JsonProperty("role_id") int role_id){
        this.staff_id = staff_id;
        this.role_id = role_id;
    }


    public int getRole_ID(){
        return this.role_id;
    }

    public int getStaff_ID(){
        return this.staff_id;
    }
    
}

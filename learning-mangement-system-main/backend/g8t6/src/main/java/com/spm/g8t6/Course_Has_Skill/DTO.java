package com.spm.g8t6.Course_Has_Skill;

import com.fasterxml.jackson.annotation.JsonProperty;

public class DTO {
    
    private String Course_ID;
    private Integer[] list;

    public DTO(){
    
    }

    public DTO(@JsonProperty("id") String id,
                    @JsonProperty("list") Integer[] list){
        this.Course_ID = id;
        this.list = list;
    }

    public String getID(){
        return this.Course_ID;
    }

    public Integer[] getList(){
        return this.list;
    }


    
}

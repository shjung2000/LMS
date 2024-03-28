package com.spm.g8t6.Role_Has_Skill;

import com.fasterxml.jackson.annotation.JsonProperty;

public class function {
    
    private int id;
    private String name;
    private String des;
    private Integer[] list;
    


    public function(){


    }

    
    public function(@JsonProperty("id") int id ,  @JsonProperty("name") String name , 
                    @JsonProperty("des") String des , @JsonProperty("list") Integer[] list){
        this.id = id;
        this.name = name;
        this.des = des;
        this.list = list;
    }


    public int getRoleID(){
        return this.id;
    }

    public String getName(){
        return this.name;
    }


    public String getDes(){
        return this.des;
    }

    public Integer[] getList(){
        return this.list;
    }



}

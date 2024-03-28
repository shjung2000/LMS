package com.spm.g8t6.Role_Has_Skill;



import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonProperty;






@Entity
@Table(name = "role_has_skill")
public class role_has_skill implements Serializable{
    
    @Id
    @Column
    private int Role_has_Skill_ID;


    @Column
    private int Role_ID;


    @Column
    private int Skill_ID;


    @Column
    private String Skill_Name;


    public role_has_skill(){

    }

    

    public role_has_skill(@JsonProperty("id") int id,
                          @JsonProperty("role_id") int role_id,
                          @JsonProperty("skill_id") int skill_id,
                          @JsonProperty("skill_name") String skill_name){
        this.Role_has_Skill_ID = id;
        this.Role_ID = role_id;
        this.Skill_ID = skill_id;
        this.Skill_Name = skill_name;
    }



    public int getID(){
        return this.Role_has_Skill_ID;
    }
    
    public int getRoleID(){
        return this.Role_ID;
    }



    public int getSkillID(){
        return this.Skill_ID;
    }



    public String getSkillName(){
        return this.Skill_Name;
    }

    
    
    
}
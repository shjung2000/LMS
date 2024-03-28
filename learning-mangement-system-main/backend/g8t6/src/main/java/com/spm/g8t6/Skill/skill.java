package com.spm.g8t6.Skill;


import com.fasterxml.jackson.annotation.JsonProperty;
import javax.persistence.*;

@Entity
@Table
public class skill {

    @Id
    @Column
    private int Skill_ID;
    
    @Column
    private String Skill_Name;

    @Column
    private String Skill_Des;

    @Column
    private int Skill_Is_Active;


    public skill(){

    }


    public skill(@JsonProperty("skill_name") String skill_name,
                 @JsonProperty("skill_des") String skill_des,
                 @JsonProperty("skill_status") int skill_is_active) {
        Skill_Name = skill_name;
        Skill_Des = skill_des;
        Skill_Is_Active = skill_is_active;
    }


    public skill(@JsonProperty("skill_id") int skill_id,
                 @JsonProperty("skill_name") String skill_name,
                 @JsonProperty("skill_des") String skill_des,
                 @JsonProperty("skill_status") int skill_is_active) {
        Skill_ID = skill_id;
        Skill_Name = skill_name;
        Skill_Des = skill_des;
        Skill_Is_Active = skill_is_active;
    }
    

    public int getSkill_ID() {
        return Skill_ID;
    }

    public void setSkill_ID(int skill_ID) {
        Skill_ID = skill_ID;
    }


    public String getSkill_Name() {
        return Skill_Name;
    }

    public void setSkill_Name(String skill_Name) {
        Skill_Name = skill_Name;
    }

    public String getSkill_Des() {
        return Skill_Des;
    }

    public void setSkill_Des(String skill_Des) {
        Skill_Des = skill_Des;
    }

    public int getSkill_Is_Active() {
        return Skill_Is_Active;
    }

    public void setSkill_Is_Active(int skill_Is_Active) {
        Skill_Is_Active = skill_Is_Active;
    }

    
}

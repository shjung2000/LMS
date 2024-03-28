package com.spm.g8t6.Course_Has_Skill;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonProperty;


@Entity
@Table(name = "course_has_skill")
public class course_has_skill {
    
    @Id
    @Column
    private int Course_has_Skill_ID;


    @Column
    private String Course_ID;

    @Column
    private int Skill_ID;

    @Column
    private String Skill_Name;


    public course_has_skill(){

    }

    public course_has_skill(@JsonProperty("id") int id,
                            @JsonProperty("course_id") String cID,
                            @JsonProperty("skill_id") int sID,
                            @JsonProperty("skill_name") String sName){
        this.Course_has_Skill_ID = id;
        this.Course_ID = cID;
        this.Skill_ID = sID;
        this.Skill_Name = sName;
    }

    public int getID(){
        return this.Course_has_Skill_ID;
    }

    public String getCID(){
        return this.Course_ID;
    }

    public int getSID(){
        return this.Skill_ID;
    }

    public String getsNAME(){
        return this.Skill_Name;
    }


                            
}

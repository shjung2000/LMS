package com.spm.g8t6.Learning_Journey;

import com.fasterxml.jackson.annotation.JsonProperty;
import javax.persistence.*;


@Entity
@Table
public class learning_journey {

    @Id
    @Column
    private int LJ_ID;

    @Column
    private int Staff_ID;

    @Column
    private int Role_ID;

    @Column
    private String Role_Name;

    @Column
    private int has_start;
    
    
    public learning_journey(){

    }

    public learning_journey(@JsonProperty("lj_id") int lj_id,
                           @JsonProperty("staff_id") int staff_id,
                           @JsonProperty("role_id") int role_id,
                           @JsonProperty("role_name") String role_name,
                           @JsonProperty("has_start") int start){
        this.LJ_ID = lj_id;
        this.Staff_ID = staff_id;
        this.Role_ID = role_id;
        this.Role_Name = role_name;
        this.has_start = start;
    }

    public learning_journey(@JsonProperty("staff_id") int staff_id,
                           @JsonProperty("role_id") int role_id,
                           @JsonProperty("role_name") String role_name,
                           @JsonProperty("has_start") int start){
        
        this.Staff_ID = staff_id;
        this.Role_ID = role_id;
        this.Role_Name = role_name;
        this.has_start = start;
    }


    
    public int getLJ_ID() {
        return this.LJ_ID;
    }

    public int getRole_ID(){
        return this.Role_ID;
    }

    public String getRole_Name(){
        return this.Role_Name;
    }

    public int getStaff_ID(){
        return this.Staff_ID;
    }
    
    
    public int getHasStart(){
        return this.has_start;
    }

}

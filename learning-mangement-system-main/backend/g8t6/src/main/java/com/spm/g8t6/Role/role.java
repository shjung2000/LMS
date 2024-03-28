package com.spm.g8t6.Role;

import com.fasterxml.jackson.annotation.JsonProperty;


import javax.persistence.*;




//Mark class as an Entity
@Entity
//define class name as Table Name
@Table
public class role{
    //defining role id as primary key
    @Id      
    @Column
    private int Role_ID;

    
    @Column
    private String Role_Name;

    @Column
    private String Role_Des;

    @Column
    private int Role_Is_Active;

    

    public role(){

    }

    //this constructor is to define the parameter that you want to inject into the database
    public role(@JsonProperty("role_name") String role_name ,
                @JsonProperty("role_description") String role_description,
                @JsonProperty("role_status") int role_is_active){
        this.Role_Name = role_name;
        this.Role_Des = role_description;
        this.Role_Is_Active = role_is_active;
    }
    

    //this constructor is to define the parameter that you want to inject into the database
    public role(@JsonProperty("role_id") int role_id ,
                @JsonProperty("role_name") String role_name ,
                @JsonProperty("role_description") String role_description,
                @JsonProperty("role_status") int role_is_active){
        this.Role_ID = role_id;
        this.Role_Name = role_name;
        this.Role_Des = role_description;
        this.Role_Is_Active = role_is_active;
    }
    
    
    
    //ID related
    public int getRole_id(){
        return Role_ID;
    }
    public void setRole_id(int id){
        this.Role_ID = id;
    }

    //Name related
    public String getRole_name(){
        return Role_Name;
    }

    public void setRole_name(String name){
        this.Role_Name = name;
    }


    //Description related
    public String getRole_description(){
        return Role_Des;
    }

    public void setRole_description(String description){
        this.Role_Des = description;
    }

    //status related
    public int getStatus(){
        return Role_Is_Active;
    }

    public void setRole_Is_Enabled(int status){
        this.Role_Is_Active = status;
    }

    






}



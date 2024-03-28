package com.spm.g8t6.Role_Has_Skill;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.spm.g8t6.Learning_Journey.learning_journey;
import com.spm.g8t6.Learning_Journey.learning_journeyRepo;
import com.spm.g8t6.Role.*;
import com.spm.g8t6.Skill.*;


@CrossOrigin(origins = "*" , allowedHeaders = "*")
@RestController
public class functionController {
    
    @Autowired
    role_has_skill_Repo role_has_skill_Repo;
    
    @Autowired
    roleRepo roleRepo;
    
    @Autowired
    skillRepo skillRepo;

    @Autowired
    learning_journeyRepo learning_journeyRepo;
    
    
    @CrossOrigin(origins = "http://localhost:8080")
    @PostMapping("/editRole")
    private String modify(@RequestBody function function){

        //Retrieve all the data from json
        int id = function.getRoleID();
        String name = function.getName();
        String des;
        Integer[] skill_list = function.getList();


        String return_skill_names = "";
        String return_role_name= "";

        


        //create an empty skill list
        List<skill> all_skill = new ArrayList<>();

        //Get the entire skill rows and save them into an array
        skillRepo.findAll().forEach(skill -> all_skill.add(skill));
        





        //Create an empty role_has_skill list
        List<role_has_skill> all_role_has_skill = new ArrayList<>();

        //Get the entire role_has_skill rows and save them into an array
        role_has_skill_Repo.findAll().forEach(item -> all_role_has_skill.add(item));







        //create an empty role list
        List<role> all_role = new ArrayList<>();

        //Get the entire role rows and save them into an array
        roleRepo.findAll().forEach(role -> all_role.add(role));

        if(id == 0){
            return "Please select a role to edit";
        }else{
            
            //If description input field is empty, use the original description
            if(function.getDes().equals("")){
                des = roleRepo.findById(id).get().getRole_description();
            }else{
                des = function.getDes();
            }

            if(name.length() > 20){
                return "Role name should be less than or equals to 20 characters";
            }else{
                //Check if the input role name already exists in the role table
                int check_counter = 0;
                //compare both names after making them into lowercase for fair comparison
                for(int i = 0 ; i < all_role.size() ; i++){
                    if(name.replaceAll("\\s" , "").toLowerCase().equals(all_role.get(i).getRole_name().replaceAll("\\s", "").toLowerCase())){
                        check_counter += 1;
                    }
                }
                
                
                //if check_counter >0 means that there is existing role name
                if(check_counter > 0){
                    return "\"" + name + "\"" + " already exists";
                }else{
                    
                    //Update the role with the input role name and description
                    role role = roleRepo.findById(id).get();
            
                    int role_status = role.getStatus();
                    
                    
                    if(name.equals("")){
                        System.out.println("Role Name is not changed");
                        String replaceName = role.getRole_name();
                        return_role_name += replaceName;
                        roleRepo.save(new role(id, replaceName , des , role_status));
                        
    
    
                        
                        List<role_has_skill> referenceList = new ArrayList<>();
                        
                        for(int x = 0 ; x < all_role_has_skill.size() ; x++){
                            if(all_role_has_skill.get(x).getRoleID() == id){
                                referenceList.add(all_role_has_skill.get(x));
                            }
                        }
                        
                        if(referenceList.size() == 0){
                            for(int i = 0 ; i < skill_list.length ; i ++){
                                
                                int min = 0;
                                int max = 1000;
                                
                                skill skill = skillRepo.findById(skill_list[i]).get();
                
                                String skill_name = skill.getSkill_Name();
                                
                                int primaryID = (int)Math.floor(Math.random()*(max-min+1)+min);
                                
                                System.out.println("skill id does not exist. Proceed to assign the skill " + skill_list[i]);
                                role_has_skill_Repo.save(new role_has_skill(primaryID , id , skill_list[i], skill_name));
                                return_skill_names += skill_name + ", ";
                                
                            }
                        }else{
                            
                            ArrayList <Integer> SkillExist = new ArrayList<>();
    
                            for(int i = 0 ; i < skill_list.length ; i ++){
                                int counter = 0;
                                System.out.println(skill_list[i]);
                                
                                skill skill = skillRepo.findById(skill_list[i]).get();
                
                                String skill_name = skill.getSkill_Name();
                            
                                return_skill_names += skill_name + ", ";
            
                                for(int j = 0 ; j < referenceList.size() ; j++){
                                    if(referenceList.get(j).getSkillID() == skill_list[i]){
                                        System.out.println("skill id already exists");
                                        counter += 1;
                                        SkillExist.add(skill_list[i]);
                                    }
                                }
                                
                                
                                
                                if(counter == 0){
                                    System.out.println("skill id does not exist. Proceed to assign the skill " + skill_list[i]);
                                    int min = 0;
                                    int max = 1000;
                                    int primaryID = (int)Math.floor(Math.random()*(max-min+1)+min);
                                    role_has_skill_Repo.save(new role_has_skill(primaryID , id , skill_list[i] , skill_name));
                                }
                            }
                            
                            if(referenceList.size() != SkillExist.size()){
                                System.out.println("There are skills to be de-assigned");;
                                for(int i = 0 ; i < referenceList.size() ; i++){
                                    for(int j = 0 ; j < SkillExist.size() ; j++){
                                        if(referenceList.get(i).getSkillID() == SkillExist.get(j)){
                                            referenceList.remove(i);
                                        }
                                    }
                                }
            
                                if(referenceList.size() > 0){
                                    System.out.println("Proceed to de-assign skills");
                                    for(int i = 0 ; i < referenceList.size() ; i++){
                                        role_has_skill item = referenceList.get(i);
                                        int primaryKey = item.getID();
                                        role_has_skill_Repo.deleteById(primaryKey);
                                        System.out.println("Skill ID" + referenceList.get(i).getSkillID() + " is de-assigned");
                                    }
                                }
                            }else{
                                System.out.println("There are no skills to be de-assigned");
                            }
                            
    
    
    
                        
                        }
    
                    }else{
                        
                        System.out.println("Role Name is changed");
                        
                        System.out.println("Change the role name in the role table");
                        roleRepo.save(new role(id , name , des , role_status));
                        
                        return_role_name += name;
                        System.out.println("Change the role name in the learning journey table");
                        List<learning_journey> all_LJ_list = new ArrayList<>();
                        learning_journeyRepo.findAll().forEach(item -> all_LJ_list.add(item));
                        for(int i = 0 ; i < all_LJ_list.size() ; i++){
                            if(all_LJ_list.get(i).getRole_ID() == id){
                                learning_journey object = all_LJ_list.get(i);
                                int LJ_ID = object.getLJ_ID();
                                int staff_id = object.getStaff_ID();
                                int has_start = object.getHasStart();
                                learning_journeyRepo.save(new learning_journey(LJ_ID , staff_id , id , name,has_start));
                            }
                        }
    
                        
                        List<role_has_skill> referenceList = new ArrayList<>();
                        
                        
                        
                        for(int x = 0 ; x < all_role_has_skill.size() ; x++){
                            if(all_role_has_skill.get(x).getRoleID() == id){
                                referenceList.add(all_role_has_skill.get(x));
                            }
                        }
                        
                        if(referenceList.size() == 0){
                            for(int i = 0 ; i < skill_list.length ; i ++){
                                
                                int min = 0;
                                int max = 1000;
                                
                                skill skill = skillRepo.findById(skill_list[i]).get();
                
                                String skill_name = skill.getSkill_Name();
                                
                                int primaryID = (int)Math.floor(Math.random()*(max-min+1)+min);
                                
                                System.out.println("skill id does not exist. Proceed to assign the skill " + skill_list[i]);
                                role_has_skill_Repo.save(new role_has_skill(primaryID , id , skill_list[i] , skill_name));
    
                                return_skill_names += skill_name + ", ";
                                
                            }
                        }else{
                            ArrayList <Integer> SkillExist = new ArrayList<>();
    
                            for(int i = 0 ; i < skill_list.length ; i ++){
                                int counter = 0;
                                System.out.println(skill_list[i]);
                                
                                skill skill = skillRepo.findById(skill_list[i]).get();
                
                                String skill_name = skill.getSkill_Name();
                            
                                return_skill_names += skill_name + ", ";
            
                                for(int j = 0 ; j < referenceList.size() ; j++){
                                    if(referenceList.get(j).getSkillID() == skill_list[i]){
                                        System.out.println("skill id already exists");
                                        counter += 1;
                                        SkillExist.add(skill_list[i]);
                                    }
                                }
                                
                                
                                
                                if(counter == 0){
                                    System.out.println("skill id does not exist. Proceed to assign the skill " + skill_list[i]);
                                    int min = 0;
                                    int max = 1000;
                                    int primaryID = (int)Math.floor(Math.random()*(max-min+1)+min);
                                    role_has_skill_Repo.save(new role_has_skill(primaryID , id , skill_list[i], skill_name));
                                }
                            }
                            
                            if(referenceList.size() != SkillExist.size()){
                                System.out.println("There are skills to be de-assigned");;
                                for(int i = 0 ; i < referenceList.size() ; i++){
                                    for(int j = 0 ; j < SkillExist.size() ; j++){
                                        if(referenceList.get(i).getSkillID() == SkillExist.get(j)){
                                            referenceList.remove(i);
                                        }
                                    }
                                }
            
                                if(referenceList.size() > 0){
                                    System.out.println("Proceed to de-assign skills");
                                    for(int i = 0 ; i < referenceList.size() ; i++){
                                        role_has_skill item = referenceList.get(i);
                                        int primaryKey = item.getID();
                                        role_has_skill_Repo.deleteById(primaryKey);
                                        System.out.println("Skill ID" + referenceList.get(i).getSkillID() + " is de-assigned");
                                    }
                                }
                            }else{
                                System.out.println("There are no skills to be de-assigned");
                            }
                            
    
                        }
    
                        System.out.println("All role_has_skill rows are added or removed. Now update the name");
                        
                        ArrayList<role_has_skill> NewAllRoleSkillList = new ArrayList<>();
                        
                        role_has_skill_Repo.findAll().forEach(item -> NewAllRoleSkillList.add(item));
                        
                        ArrayList<role_has_skill> changeNameList = new ArrayList<>();
                        
                        for(int i = 0 ; i < NewAllRoleSkillList.size() ; i++){
                            if(NewAllRoleSkillList.get(i).getRoleID() == id){
                                changeNameList.add(NewAllRoleSkillList.get(i));
                            }
                        }
    
                        for(int x = 0 ; x < changeNameList.size() ; x++){
                            role_has_skill object = changeNameList.get(x);
    
                            int primary = object.getID();
                            int rID = object.getRoleID();
                            int sID = object.getSkillID();
                            String sName = object.getSkillName();
                            
                            role_has_skill_Repo.save(new role_has_skill(primary, rID , sID , sName));
                        }
    
                        
                    }
                    
                    //1st success path -> Role Name is not changed and skills are de-assigned (no skills are selected)
                    if(return_skill_names.length() == 0 &&  !(return_role_name.equals(name)) ){
                        return "No skills are assigned to " + "\"" + return_role_name + "\"";
                    //2nd success path -> Role Name is changed and skills are de-assigned (no skills are selected)
                    }else if(return_skill_names.length() == 0 && return_role_name.equals(name)){
                        return "Updated " + "\"" + return_role_name + "\"" + " and No skills are assigned to  " + "\"" + return_role_name + "\"";
                    //3rd success path -> Role Name is not changed and skills are assigned (skills are selected)
                    }else if(return_skill_names.length() != 0 &&  !(return_role_name.equals(name)) ){
                        return_skill_names = return_skill_names.substring(0 , return_skill_names.length() -2);
                        return "Successfully Assigned " + "\"" + return_skill_names + "\"" + " to " + "\"" + return_role_name + "\"";
                    //4th success path -> Role Name is changed and skills are assigned (skills are selected)
                    }else{
                        return_skill_names = return_skill_names.substring(0 , return_skill_names.length() -2);
                        return "Successfully Updated " + "\"" + return_role_name + "\"" + " and successfully assigned " + "\"" + return_skill_names + "\"" + " to " + "\"" + return_role_name + "\"";
                    }
                    
                    
                }
            }

        }


        
    }
}

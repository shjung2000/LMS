package com.spm.g8t6.Course_Has_Skill;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.spm.g8t6.Skill.skillRepo;
import com.spm.g8t6.Course.*;
import com.spm.g8t6.Skill.*;



@CrossOrigin(origins = "*" , allowedHeaders = "*")
@RestController
public class DTOController {
    
    @Autowired
    course_has_skill_Repo course_has_skill_Repo;

    @Autowired
    skillRepo skillRepo;

    @Autowired
    courseRepo courseRepo;

    @CrossOrigin(origins = "http://localhost:8080")
    @PostMapping("/editCourse")
    private String modify(@RequestBody DTO dto){
        String course_id = dto.getID();
        Integer[] skill_list = dto.getList();

        String return_skill_names = "";
        String return_course_name= "";

        //create an empty skill list
        List<skill> all_skill = new ArrayList<>();

        //Get the entire skill rows and save them into an array
        skillRepo.findAll().forEach(skill -> all_skill.add(skill));


        //Create an empty course list
        List<course> all_course = new ArrayList<>();

        //Get the entire course rows and add them into the list
        courseRepo.findAll().forEach(item -> all_course.add(item));

        //Find the corresponding course name
        for(int j = 0 ; j < all_course.size() ; j++){
            if(all_course.get(j).getCourse_ID().equals(course_id)){
                return_course_name += all_course.get(j).getCourse_Name();
            } 
        }
        
        //Create an empty course_has_skill list
        List<course_has_skill> all_course_has_skill = new ArrayList<>();

        //Get the entire course_has_skill rows and save them into an array
        course_has_skill_Repo.findAll().forEach(item -> all_course_has_skill.add(item));



        List<course_has_skill> referenceList = new ArrayList<>();

        if(course_id.equals("")){
            return "Please select a course to edit";
        }else{
            for(int i = 0 ; i < all_course_has_skill.size() ; i++){
                if(all_course_has_skill.get(i).getCID().equals(course_id)){
                    referenceList.add(all_course_has_skill.get(i));
                }
            }
    
            if(referenceList.size() == 0){
                System.out.println("This course_id does not exist in this table. Proceed to add all the skills");
    
                for(int i = 0 ; i < skill_list.length ; i++){
                    int min = 0;
                    int max = 1000;
    
                    skill skill = skillRepo.findById(skill_list[i]).get();
                    
                    String skill_name = skill.getSkill_Name();
    
                    return_skill_names += skill_name + ", ";
                
                    int primaryID = (int)Math.floor(Math.random()*(max-min+1)+min);
    
                    System.out.println("Assigning the skill " + skill_list[i]);
                    course_has_skill_Repo.save(new course_has_skill(primaryID , course_id , skill_list[i] , skill_name));
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
                        if(referenceList.get(j).getSID() == skill_list[i]){
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
                        course_has_skill_Repo.save(new course_has_skill(primaryID , course_id , skill_list[i] , skill_name));
                    }
                }
    
                if(referenceList.size() != SkillExist.size()){
                    System.out.println("There are skills to be de-assigned");;
                    for(int i = 0 ; i < referenceList.size() ; i++){
                        for(int j = 0 ; j < SkillExist.size() ; j++){
                            if(referenceList.get(i).getSID() == SkillExist.get(j)){
                                referenceList.remove(i);
                            }
                        }
                    }
    
                    if(referenceList.size() > 0){
                        System.out.println("Proceed to de-assign skills");
                        for(int i = 0 ; i < referenceList.size() ; i++){
                            course_has_skill item = referenceList.get(i);
                            int primaryKey = item.getID();
                            course_has_skill_Repo.deleteById(primaryKey);
                            System.out.println("Skill ID" + referenceList.get(i).getSID() + " is de-assigned");
                        }
                    }
                }else{
                    System.out.println("There are no skills to be de-assigned");
                }

            }
    
    
            if(return_skill_names.length() == 0){
                return "No skills are assigned to Course: " + return_course_name;
            }else{
                return_skill_names = return_skill_names.substring(0 , return_skill_names.length() -2);
                return "Successfully Assigned " + "\"" + return_skill_names +  "\""  + " to "  + "\""+ return_course_name + "\"";
            }



    
        }
    }
}

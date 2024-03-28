package com.spm.g8t6.Skill;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;


@CrossOrigin(origins = "*" , allowedHeaders = "*")
@RestController
public class skillController {

    @Autowired
    skillService skillService;

    @Autowired
    skillRepo skillRepo;

    @CrossOrigin(origins = "http://localhost:8080")
    @GetMapping("/AllSkill")
    private List<skill> getAllSkills(){
        return skillService.getAllSkills();
    }

    @CrossOrigin(origins = "http://localhost:8080")
    @PostMapping("/CreateSkill")
    private String createSkill(@RequestBody skill skill){
        int status = skillService.createSkill(skill);
        String name = skill.getSkill_Name();
        if(status == 2){
            return "Successfully Created " + "\"" + name + "\"";
        }else if(status == 1){
            return "\"" + name + "\"" + " already exists!";
        }else if(status == 3){
            return "Name field cannot be empty";
        }else{
            return "Skill name should be less than or equals to 50 characters";
        }
    }


    @CrossOrigin(origins = "http://localhost:8080")
    @PostMapping("/DeleteSkill/{skillID}")
    private String deleteSkill(@PathVariable("skillID") int id){
        boolean status = skillService.deleteSkill(id);
        if(status == true){
            String skill_name = skillRepo.findById(id).get().getSkill_Name();
            return "Successfully deactivated " + "\"" + skill_name + "\"";
        }
        return "Something went wrong while deletion!";
    }

    @CrossOrigin(origins = "http://localhost:8080")
    @PostMapping("/UpdateSkill")
    private String updateSkill(@RequestBody skill skill){
        int status = skillService.updateSkill(skill);
        if(status == 2){
            String skill_name = skill.getSkill_Name();
            return "Successfully updated to " + "\"" + skill_name + "\"";
        }else if(status == 1){
            String skill_name = skill.getSkill_Name();
            return "\"" + skill_name + "\"" + " already exists";
        }else if(status == 0){
            return "Skill name should be less than or equals to 50 characters";
        }else{
            return "Please select a skill to edit";
        }
        
    }
    



}

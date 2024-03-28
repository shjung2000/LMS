package com.spm.g8t6.Role_Has_Skill;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.spm.g8t6.Skill.skill;

import java.util.List;

@CrossOrigin(origins = "*" , allowedHeaders = "*")
@RestController
public class role_has_skill_Controller {
    
    @Autowired
    role_has_skill_Service role_has_skill_Service;


    
    @CrossOrigin(origins = "http://localhost:8080")
    @GetMapping("/all_role_skill")
    private List<role_has_skill> getAll(){
        return role_has_skill_Service.getAll();
    }

    @CrossOrigin(origins = "http://localhost:8080")
    @GetMapping("/getRolesRelatedSkills/{roleID}")
    private List<skill> getRelatedSkills(@PathVariable("roleID") int id){
        
        return role_has_skill_Service.getRelatedSkills(id);
        
    }

}

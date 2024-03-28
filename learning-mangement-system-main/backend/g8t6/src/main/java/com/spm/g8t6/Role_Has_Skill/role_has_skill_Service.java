package com.spm.g8t6.Role_Has_Skill;


import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spm.g8t6.Skill.*;

@Service
public class role_has_skill_Service {
    
    @Autowired
    role_has_skill_Repo role_has_skill_Repo;

    @Autowired
    skillRepo skillRepo;


    public List<role_has_skill> getAll(){
        List<role_has_skill> list = new ArrayList<>();
        role_has_skill_Repo.findAll().forEach(item -> list.add(item));
        return list;
    }

    public List<skill> getRelatedSkills(int id){
        
        List<role_has_skill> all_role_has_skill = new ArrayList<>();
        role_has_skill_Repo.findAll().forEach(item -> all_role_has_skill.add(item));

        List<Integer> skillIDList = new ArrayList<>();
        List<skill> returnList = new ArrayList<>();

        System.out.println("Put all the skill ids that are attached to the role id: " + id + " into the list first");
        for(int i = 0 ; i < all_role_has_skill.size() ; i++){
            if(all_role_has_skill.get(i).getRoleID() == id){
                skillIDList.add(all_role_has_skill.get(i).getSkillID());
            }
        }

        
        System.out.println("Put all the skill names that have those skill ids");

        for(int j = 0 ; j < skillIDList.size() ; j++){
            returnList.add(skillRepo.findById(skillIDList.get(j)).get());
        }
        
        
        return returnList;
        


    }
}

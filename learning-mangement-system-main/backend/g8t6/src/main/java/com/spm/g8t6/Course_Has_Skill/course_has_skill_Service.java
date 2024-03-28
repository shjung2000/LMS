package com.spm.g8t6.Course_Has_Skill;

import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.spm.g8t6.Skill.*;


@Service
public class course_has_skill_Service {
    
    @Autowired
    course_has_skill_Repo course_has_skill_Repo;

    @Autowired
    skillRepo skillRepo;

    public List<course_has_skill> getAll(){
        List<course_has_skill> list = new ArrayList<>();
        course_has_skill_Repo.findAll().forEach(item -> list.add(item));
        return list;
    }

    public List<String> getRelatedSkills(String id){
        
        List<course_has_skill> all_course_has_skill = new ArrayList<>();
        course_has_skill_Repo.findAll().forEach(item -> all_course_has_skill.add(item));

        List<Integer> skillIDList = new ArrayList<>();
        List<String> returnList = new ArrayList<>();

        System.out.println("Put all the skill ids that are attached to the course id: " + id + " into the list first");
        for(int i = 0 ; i < all_course_has_skill.size() ; i++){
            if(all_course_has_skill.get(i).getCID().equals(id)){
                skillIDList.add(all_course_has_skill.get(i).getSID());
            }
        }

        
        System.out.println("Put all the skill names that have those skill ids");

        for(int j = 0 ; j < skillIDList.size() ; j++){
            returnList.add(skillRepo.findById(skillIDList.get(j)).get().getSkill_Name());
        }

        
        return returnList;
        


    }
}


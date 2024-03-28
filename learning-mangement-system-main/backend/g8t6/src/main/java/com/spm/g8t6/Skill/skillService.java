package com.spm.g8t6.Skill;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

import com.spm.g8t6.Role_Has_Skill.*;
import com.spm.g8t6.Course_Has_Skill.*;



@Service
public class skillService {

    @Autowired
    skillRepo skillRepo;

    @Autowired
    role_has_skill_Repo role_has_skill_Repo;

    @Autowired
    course_has_skill_Repo course_has_skill_Repo;



    public List<skill> getAllSkills(){
        List<skill> skillList = new ArrayList<>();
        skillRepo.findAll().forEach(skill -> skillList.add(skill));    //each role add into the arrayList
        return skillList;
    }

    public int createSkill(skill skill){
        int check_counter = 0;
        String skillName = skill.getSkill_Name();
        if(skillName.equals("")){
            return 3;
        }else{
            List<skill> skillList = new ArrayList<>();
            skillRepo.findAll().forEach(skills -> skillList.add(skills));   

            if(skillName.length() > 50){
                return 0;
            }else{
                for(int i = 0 ; i < skillList.size() ; i++){
                    if(skillName.toLowerCase().equals(skillList.get(i).getSkill_Name().toLowerCase())){
                        check_counter += 1;
                    }
                }
        
                if(check_counter == 1){
                    return 1;
                }else{
                    String skillDescription = skill.getSkill_Des();
                    int status = 1;
                    skillRepo.save(new skill(skillName , skillDescription , status));
                    return 2;
                }
            }
        }
        
        
    }


    public boolean deleteSkill(int id){
        
        skill skill = skillRepo.findById(id).get();
        
        int ID = skill.getSkill_ID();
        int status = 0;
        String name = skill.getSkill_Name();
        String des = skill.getSkill_Des();

        skillRepo.save(new skill(ID, name , des , status));

        return true;
        
    }


    public int updateSkill(skill skill){
        int id = skill.getSkill_ID();
        String name = skill.getSkill_Name();
        String des = skill.getSkill_Des();
        

        if(id == 0 ){
            return 3;
        }else{
            int status = skillRepo.findById(id).get().getSkill_Is_Active();
            ArrayList<skill> checkSkill = new ArrayList<>();
            skillRepo.findAll().forEach(item -> checkSkill.add(item));
        
            int checkSkillCounter = 0;
            
            if(name.length() > 50){
                return 0;
            }else{
                for(int y = 0 ; y < checkSkill.size() ; y++){
                    if(checkSkill.get(y).getSkill_Name().replaceAll("\\s", "").toLowerCase().equals(name.replaceAll("\\s","").toLowerCase())){
                        checkSkillCounter += 1;
                    }
                }
                System.out.println(checkSkillCounter);
                if(checkSkillCounter == 1){
                    return 1;
                }else{
                    
                    skillRepo.save(new skill(id , name , des , status));
        
                    List<role_has_skill> all_role_has_skill =  new ArrayList<>();
                    
                    List<course_has_skill> all_course_has_skill = new ArrayList<>();
        
                    role_has_skill_Repo.findAll().forEach(item -> all_role_has_skill.add(item));
                    course_has_skill_Repo.findAll().forEach((item -> all_course_has_skill.add(item)));
        
                    List<role_has_skill> referenceListRole = new ArrayList<>();
        
                    List<course_has_skill> referenceListCourse = new ArrayList<>();
        
                    for(int i = 0 ; i < all_role_has_skill.size() ; i++){
                        if(all_role_has_skill.get(i).getSkillID() == id){
                            referenceListRole.add(all_role_has_skill.get(i));
                        }
                    }
        
                    for(int x = 0 ; x < all_course_has_skill.size() ; x++){
                        if(all_course_has_skill.get(x).getSID() == id){
                            referenceListCourse.add(all_course_has_skill.get(x));
                        }
                    }
        
        
                    for(int z = 0 ; z < referenceListRole.size() ; z++){
                        role_has_skill item = referenceListRole.get(z);
                        int pri = item.getID();
                        int rID = item.getRoleID();
                        int sID = item.getSkillID();
        
        
                        role_has_skill_Repo.save(new role_has_skill(pri , rID , sID , name ));
                    
                    }
        
                    for(int j = 0 ; j < referenceListCourse.size() ; j++){
                        course_has_skill item = referenceListCourse.get(j);
                        int pri = item.getID();
                        String cid = item.getCID();
                        int sid = item.getSID();
        
                        course_has_skill_Repo.save(new course_has_skill(pri , cid , sid , name ));
        
                    }
                    
                    return 2;
                }
        
            }
        }
        
    }
        
        
}

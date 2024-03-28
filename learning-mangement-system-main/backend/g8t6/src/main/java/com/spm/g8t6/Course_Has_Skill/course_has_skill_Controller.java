package com.spm.g8t6.Course_Has_Skill;


    
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
import java.util.List;

@CrossOrigin(origins = "*" , allowedHeaders = "*")
@RestController
public class course_has_skill_Controller {
    
    @Autowired
    course_has_skill_Service course_has_skill_Service;

    @CrossOrigin(origins = "http://localhost:8080")
    @GetMapping("/all_course_skill")
    private List<course_has_skill> getAll(){
        return course_has_skill_Service.getAll();
    }


    @CrossOrigin(origins = "http://localhost:8080")
    @GetMapping("/getCourseRelatedSkills/{courseID}")
    private List<String> getRelatedSkills(@PathVariable("courseID") String id){
        
        return course_has_skill_Service.getRelatedSkills(id);

    }
    
    
}


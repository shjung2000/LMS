package com.spm.g8t6.Registration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.spm.g8t6.Course.*;

import java.util.ArrayList;
import java.util.List;
@CrossOrigin(origins = "*" , allowedHeaders = "*")
@RestController
public class registrationController {
    @Autowired
    registrationService registrationService;

    @Autowired
    courseRepo courseRepo;

    @CrossOrigin(origins = "http://localhost:8080")
    @GetMapping("/allRegistration")
    private List<registration> getAllRegistration(){
        return registrationService.getAllRegistration();
    }

    @CrossOrigin(origins = "http://localhost:8080")
    @GetMapping("/oneRegistration/{Reg_ID}")
    private registration getRegistrationById(@PathVariable("Reg_ID") int id){
        return registrationService.getRegistrationByID(id);
    }

    @CrossOrigin(origins = "http://localhost:8080")
    @PostMapping("/registerCourse")
    private String registerCourse(@RequestBody registerDataTransfer object){
        int status = registrationService.registerCourse(object);
        String course_name = "";
            List<course> all_course = new ArrayList<>();
            courseRepo.findAll().forEach(item -> all_course.add(item));
            for(int i = 0 ; i < all_course.size() ; i++){
                if(all_course.get(i).getCourse_ID().equals(object.getCourseID())){
                    course_name += all_course.get(i).getCourse_Name();
                }
            }
        if(status == 1){
            return "Successfully Registered for " + "\"" + course_name + "\"";
        }else{
            return "You have already registered for " + "\"" + course_name + "\"";
        }
    }

}

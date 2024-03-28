package com.spm.g8t6.Learning_Journey_Has_Course;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.spm.g8t6.Course.*;
import com.spm.g8t6.Learning_Journey.*;
import com.spm.g8t6.Role.*;


@CrossOrigin(origins = "*" , allowedHeaders = "*")
@RestController
public class LJ_Has_Course_Request_Body_Controller {
    
    @Autowired
    learning_journeyRepo learning_journeyRepo;

    @Autowired
    learning_journey_has_courseRepo learning_journey_has_courseRepo;

    @Autowired
    roleRepo roleRepo;

    @Autowired
    courseRepo courseRepo;
    
    @CrossOrigin(origins = "http://localhost:8080")
    @PostMapping("/addCourse")
    private String addCourse(@RequestBody LJ_Has_Course_Request_Body dto){
        int role_id = dto.getRole_ID();
        String course_id = dto.getCourse_ID();
        int check_course_exist = 0;
        String course_name = "";
        List<course> course_list = new ArrayList<>();
        courseRepo.findAll().forEach(item -> course_list.add(item));
        for(int j = 0 ; j < course_list.size() ; j++){
            if(course_list.get(j).getCourse_ID().equals(course_id)){
                course_name += course_list.get(j).getCourse_Name();
            }
        }
        System.out.println(role_id);
        System.out.println(course_id);

        //List<Integer> getLJ_ID = new ArrayList<>();
        
        int LJ_ID = 0;
        List<learning_journey> LJ_list = new ArrayList<>();
        learning_journeyRepo.findAll().forEach(item -> LJ_list.add(item));
        
        //Get the LJ ID with the Role ID passed
        for(int i = 0 ; i < LJ_list.size() ; i++){
            if(LJ_list.get(i).getRole_ID() == role_id){
                LJ_ID = LJ_list.get(i).getLJ_ID();
            }
        }

        //Map that LJ ID with the LJ_ID in Learning Journey Has Course Table and get all objects with that LJ ID
        List<learning_journey_has_course> LJ_Has_Course_list = new ArrayList<>();
        learning_journey_has_courseRepo.findAll().forEach(item -> LJ_Has_Course_list.add(item));
        List<learning_journey_has_course> particular_LJ_Has_Course_list = new ArrayList<>();
        for(int j = 0 ; j < LJ_Has_Course_list.size() ; j++){
            if(LJ_Has_Course_list.get(j).getLJID() == LJ_ID){
                particular_LJ_Has_Course_list.add(LJ_Has_Course_list.get(j));
            }
        }

        //Loop through retrieved LJ objects with that LJ ID if that course has already been registered
        for(int i = 0 ; i < particular_LJ_Has_Course_list.size() ; i++){
            if(particular_LJ_Has_Course_list.get(i).getCourseID().equals(course_id)){
                check_course_exist += 1;
            }
        }
        
        if(check_course_exist == 0){
            int min = 0;
            int max = 1000;
            int ID = (int)Math.floor(Math.random()*(max-min+1)+min);
            learning_journey_has_courseRepo.save(new learning_journey_has_course(ID , LJ_ID , course_id));

            return "Successfully added " + "\"" + course_name + "\"" + " to My Courses";
        }else{
            return "\"" + course_name + "\"" + " has already been added";
        }
    }

    
    @CrossOrigin(origins = "http://localhost:8080")
    @PostMapping("/removeCourse")
    private String removeCourse(@RequestBody LJ_Has_Course_Request_Body dto){
        int role_id = dto.getRole_ID();
        String course_id = dto.getCourse_ID();
        String course_name = "";
        List<course> course_list = new ArrayList<>();
        courseRepo.findAll().forEach(item -> course_list.add(item));
        for(int j = 0 ; j < course_list.size() ; j++){
            if(course_list.get(j).getCourse_ID().equals(course_id)){
                course_name += course_list.get(j).getCourse_Name();
            }
        }

        

        List<learning_journey> LJ_list = new ArrayList<>();
        learning_journeyRepo.findAll().forEach(item -> LJ_list.add(item));

        List<learning_journey_has_course> LJ_Course_list = new ArrayList<>();
        learning_journey_has_courseRepo.findAll().forEach(item -> LJ_Course_list.add(item));
        
        System.out.println(LJ_list.size());
        int setLJ_ID = 0;

        for(int i = 0 ; i < LJ_list.size() ; i++){
            if(LJ_list.get(i).getRole_ID() == role_id){
                setLJ_ID = LJ_list.get(i).getLJ_ID();
            }
        }

        learning_journey learning_journey = learning_journeyRepo.findById(setLJ_ID).get();
        int started_status = learning_journey.getHasStart();
        if(started_status == 0){
            for(int j = 0 ; j < LJ_Course_list.size() ; j++){
                if(LJ_Course_list.get(j).getLJID() == setLJ_ID && LJ_Course_list.get(j).getCourseID().equals(course_id)){
                    learning_journey_has_courseRepo.deleteById(LJ_Course_list.get(j).getID());
                }
            }
    
            return "Successfully removed " + "\"" + course_name + "\"" + " from my Courses";
        }else{
            int counter = 0;
            for(int i = 0 ; i < LJ_Course_list.size() ; i++){
                if(LJ_Course_list.get(i).getLJID() == setLJ_ID){
                    counter += 1;
                }
            }
            if(counter == 1){
                return "You need at least 1 course in your Learning Journey";
            }else{
                for(int j = 0 ; j < LJ_Course_list.size() ; j++){
                    if(LJ_Course_list.get(j).getLJID() == setLJ_ID && LJ_Course_list.get(j).getCourseID().equals(course_id)){
                        learning_journey_has_courseRepo.deleteById(LJ_Course_list.get(j).getID());
                    }
                }
        
                return "Successfully removed " + "\"" + course_name + "\"" + " from my Courses";
            }
        }
        

    }

    @CrossOrigin(origins = "http://localhost:8080")
    @GetMapping("/allLJ_has_course")
    private List<learning_journey_has_course> getAll(){
        List<learning_journey_has_course> return_list = new ArrayList<>();
        learning_journey_has_courseRepo.findAll().forEach(item -> return_list.add(item));
        return return_list;
    }

    @CrossOrigin(origins = "http://localhost:8080")
    @PostMapping("/startLearningJourney/{id}")
    private String startLJ(@PathVariable("id") int id){
        String role_name = learning_journeyRepo.findById(id).get().getRole_Name();
        learning_journey LJ_obj = learning_journeyRepo.findById(id).get();
        
        if(LJ_obj.getHasStart() == 1){
            return "Learning Journey for " + "\"" + role_name + "\"" + " has already started";
        }else{
            
            int checkCounter = 0;
            List<learning_journey_has_course> allLJ_has_course_list = new ArrayList<>();
            learning_journey_has_courseRepo.findAll().forEach(item -> allLJ_has_course_list.add(item));


            List<learning_journey_has_course> particular_LJ_has_course_List = new ArrayList<>();

            for(int i = 0 ; i < allLJ_has_course_list.size() ; i++){
                if(allLJ_has_course_list.get(i).getLJID() == id){
                    particular_LJ_has_course_List.add(allLJ_has_course_list.get(i));
                }
            }

            for(int j = 0 ; j < particular_LJ_has_course_List.size() ; j++){
                checkCounter += 1;
            }
            
            if(checkCounter > 0){
                int LJ_ID = LJ_obj.getLJ_ID();
                int staff_id = LJ_obj.getStaff_ID();
                int role_id = LJ_obj.getRole_ID();
                int new_start = 1;
                learning_journeyRepo.save(new learning_journey(LJ_ID, staff_id, role_id, role_name, new_start));
                return "Successfully started Learning Journey for " + "\"" + role_name + "\"";
            }else{
                return "You need at least 1 course in your Learning Journey";
            }
        }
        
        

    }

}

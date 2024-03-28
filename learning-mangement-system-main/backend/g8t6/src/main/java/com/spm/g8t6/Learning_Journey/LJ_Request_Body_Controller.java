package com.spm.g8t6.Learning_Journey;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import com.spm.g8t6.Role.*;



@CrossOrigin(origins = "*" , allowedHeaders = "*")
@RestController
public class LJ_Request_Body_Controller {
    
    @Autowired
    roleRepo roleRepo;

    @Autowired
    learning_journeyRepo learning_journeyRepo;

    @CrossOrigin(origins = "http://localhost:8080")
    @PostMapping("/createLearningJourney")
    private String createLJ(@RequestBody LJ_Request_Body dto){
        int staff_id = dto.getStaff_ID();
        int role_id = dto.getRole_ID();
        String roleName = roleRepo.findById(role_id).get().getRole_name();
        List<learning_journey> LJ_list = new ArrayList<>();
        int checkCounter = 0;
        learning_journeyRepo.findAll().forEach(item -> LJ_list.add(item));

        for(int i = 0 ; i < LJ_list.size() ; i++){
            int rID = LJ_list.get(i).getRole_ID();

            if(rID == role_id){
                checkCounter += 1;
            }
        }
        System.out.println(checkCounter);
        if(checkCounter == 1){
            return "The learning journey with the following Role Name: " + roleName + " has already been created!";
        }else{
        
            String name = roleRepo.findById(role_id).get().getRole_name();
            int start = 0;
            learning_journeyRepo.save(new learning_journey(staff_id , role_id , name , start));

            return "Learning Journey with Role Name: " + name + " created successfully!";
        }
    }
}

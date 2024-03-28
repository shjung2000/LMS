package com.spm.g8t6.Learning_Journey;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

import javax.swing.text.DefaultStyledDocument.ElementSpec;


@CrossOrigin(origins = "*" , allowedHeaders = "*")
@RestController
public class learning_journeyController {
    
    @Autowired
    learning_journeyService learning_journeyService;

    @Autowired
    learning_journeyRepo learning_journeyRepo;

    @CrossOrigin(origins = "http://localhost:8080")
    @GetMapping("/allLearningJourney")
    private List<learning_journey> getAllLJ(){

        return learning_journeyService.getAllLJ();

    }

    @CrossOrigin(origins = "http://localhost:8080")
    @PostMapping("/deleteLearningJourney/{id}")
    private String deleteLJ(@PathVariable("id") int id ){
        String role_name;
        if(id == 0){
            role_name = "";
        }else{
            role_name = learning_journeyRepo.findById(id).get().getRole_Name();
        }
        
        boolean status = learning_journeyService.deleteLJ(id);
        if(status == true){
            return "Successfully deleted learning journey for " + "\"" + role_name + "\"";
        }else{
            return "Please select a role name to delete the Learning Journey";
        }

    }
    
}

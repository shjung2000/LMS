package com.spm.g8t6.Learning_Journey;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spm.g8t6.Learning_Journey_Has_Course.*;

import java.util.ArrayList;
import java.util.List;


@Service
public class learning_journeyService {
    @Autowired
    learning_journeyRepo learning_journeyRepo;

    @Autowired
    learning_journey_has_courseRepo learning_journey_has_courseRepo;
    

    public List<learning_journey> getAllLJ(){
        List<learning_journey> LJList = new ArrayList<>();
        learning_journeyRepo.findAll().forEach(item-> LJList.add(item));
        return LJList;
    }

    public boolean deleteLJ(int id){
        if(id == 0){
            return false;
        }else{
            
            List<learning_journey_has_course> all_LJ_Has_Course_List = new ArrayList<>();
            learning_journey_has_courseRepo.findAll().forEach(item -> all_LJ_Has_Course_List.add(item));

            for(int i = 0 ; i < all_LJ_Has_Course_List.size() ; i++){
                if(all_LJ_Has_Course_List.get(i).getLJID() == id){
                    learning_journey_has_course object = all_LJ_Has_Course_List.get(i);
                    int remove_id = object.getID();
                    learning_journey_has_courseRepo.deleteById(remove_id);
                }
            }
            
            
            learning_journeyRepo.deleteById(id);
            return true;
        }
    
    }
    
}

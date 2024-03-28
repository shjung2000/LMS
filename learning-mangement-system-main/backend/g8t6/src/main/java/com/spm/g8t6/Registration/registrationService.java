package com.spm.g8t6.Registration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import java.util.ArrayList;
import java.util.List;


@Service
public class registrationService {

    @Autowired
    registrationRepo registrationRepo;

    

    public registration getRegistrationByID(int id){
        return registrationRepo.findById(id).get();
    }

    public List<registration> getAllRegistration(){
        List<registration> registrationList = new ArrayList<>();
        registrationRepo.findAll().forEach(registration -> registrationList.add(registration));
        return registrationList;
    }



    public registration getRegistrationById(int id){
        return registrationRepo.findById(id).get();
    }

    public int registerCourse(registerDataTransfer object){
        String course_id = object.getCourseID();
        System.out.println(course_id);
        int staff_id = object.getStaffID();
        List<registration> all_registration_list = new ArrayList<>();
        List<registration> staff_register_list = new ArrayList<>();
        int course_register_check = 0;

        registrationRepo.findAll().forEach(item -> all_registration_list.add(item));

        for(int i = 0 ; i < all_registration_list.size() ; i++){
            if(all_registration_list.get(i).getStaff_ID() == staff_id){
                staff_register_list.add(all_registration_list.get(i));
            }
        }

        for(int j = 0 ; j < staff_register_list.size() ; j++){
            if(staff_register_list.get(j).getCourse_ID().equals(course_id)){
                course_register_check += 1;
            }
        }
        System.out.println(course_register_check);
        if(course_register_check == 1){
            return 0; //Course is already registered by that staff
        }else{
            String reg_status = "Registered";
            String completion_status = "";
            registrationRepo.save(new registration(course_id, staff_id, reg_status , completion_status));
            return 1; //Course is registered
        }

    }
    

}

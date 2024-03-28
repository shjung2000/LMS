package com.spm.g8t6.Course;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import java.util.ArrayList;
import java.util.List;

//Business Logics
@Service
public class courseService {

    @Autowired
    courseRepo courseRepo;


    public List<course> getAllCourses(){
        List<course> courseList = new ArrayList<>();
        courseRepo.findAll().forEach(role -> courseList.add(role));    //each role add into the arrayList
        return courseList;                                           //returning the arrayList containing the roles
    }


}

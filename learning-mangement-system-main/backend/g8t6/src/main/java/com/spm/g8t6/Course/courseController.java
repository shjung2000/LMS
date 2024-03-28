package com.spm.g8t6.Course;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;


@CrossOrigin(origins = "*" , allowedHeaders = "*")
@RestController
public class courseController {

    @Autowired
    courseService courseService;

    
    @GetMapping("/all_course")
    private List<course> getAllCourses(){

        return courseService.getAllCourses();

    }



}

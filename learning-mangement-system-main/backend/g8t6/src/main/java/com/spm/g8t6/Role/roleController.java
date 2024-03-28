package com.spm.g8t6.Role;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

//Mark as controller
@CrossOrigin(origins = "*" , allowedHeaders = "*")
@RestController
public class roleController {

    //Auto-wire the roleService class / Automatically create an instance of roleService class to be able to use the method of roleService
    @Autowired
    roleService roleService;

    @Autowired
    roleRepo roleRepo;

    //create a get mapping that retrieves all roles from the database
    @CrossOrigin(origins = "http://localhost:8080")
    @GetMapping("/AllRole")
    private List<role> getAllRoles(){       
        //getAllRoles() method retrieves all the roles from role table which will be defined in roleService.java  
        return roleService.getAllRoles();  
    }

    @CrossOrigin(origins = "http://localhost:8080")
    @GetMapping("/oneRole/{Role_ID}")
    private role getOneRole(@PathVariable("Role_ID") int id){
        return roleService.getRoleById(id);
    }

    

    //create a post mapping that creates a new role
    @CrossOrigin(origins = "http://localhost:8080")
    @PostMapping("/CreateRole")
    private String createRole(@RequestBody role role){
        int status = roleService.createRole(role);
        if(status == 2){
            String role_name = role.getRole_name();
            return "Successfully created " + "\"" + role_name + "\"";
        }else if(status == 0){
            return "Role name should be less than or equals to 20 characters";
        }else if(status == 3){
            return "Name field cannot be empty";
        }else{
            String role_name = role.getRole_name();
            return "\"" + role_name + "\"" + " already exists";
        }
    }

    //create a delete mapping that deletes a certain role -> Soft Delete by updating the ID to 0
    @CrossOrigin(origins = "http://localhost:8080")
    @PostMapping("/DeleteRole/{RoleID}")
    private String deleteRole(@PathVariable("RoleID") int id){
        boolean status = roleService.deleteRole(id);
        if(status == true){
            String role_name = roleRepo.findById(id).get().getRole_name();
            return "Successfully deactivated " + "\"" + role_name + "\"";
        }else{
            return "Something went wrong during deletion!";
        }
    }

    

    




}

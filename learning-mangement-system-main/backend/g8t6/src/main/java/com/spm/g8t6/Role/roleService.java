package com.spm.g8t6.Role;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.ArrayList;
import java.util.List;

//define the backend logics
@Service
public class roleService {
    
    @Autowired
    roleRepo roleRepo;

    

    
    public List<role> getAllRoles(){
        List<role> roleList = new ArrayList<>();
        roleRepo.findAll().forEach(role -> roleList.add(role));    
        return roleList;                                           
    }



    public role getRoleById(int id){
        return roleRepo.findById(id).get();
    }


    

    
   
    public int createRole(role role){
        int check_counter = 0;
        String roleName = role.getRole_name();
        if(roleName.equals("")){
            return 3;
        }else{
            List<role> roleList = new ArrayList<>();
            roleRepo.findAll().forEach(roles -> roleList.add(roles));   
            if(roleName.length() > 20){
                return 0;
            }else{
                for(int i = 0 ; i < roleList.size() ; i++){
                    if(roleName.replaceAll("\\s","").toLowerCase().equals(roleList.get(i).getRole_name().replaceAll("\\s","").toLowerCase())){
                        check_counter += 1;
                    }
                }
                
                if(check_counter == 1){
                    return 1;
                }else{
                    String roleDescription = role.getRole_description();
                    int status = 1;
                    roleRepo.save(new role(roleName , roleDescription , status));
                    return 2;
                }
            }
        }
        
    }


    
    public boolean deleteRole(int id){
        
        role role = roleRepo.findById(id).get();
        
        int ID = role.getRole_id();
        int status = 0;
        String name = role.getRole_name();
        String des = role.getRole_description();

        
        roleRepo.save(new role(ID, name , des , status));

        return true;
        
    }
            

   


    

}

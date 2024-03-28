package com.spm.g8t6;
import com.spm.g8t6.Role.role;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.CrudRepository;

public interface testroleRepo extends CrudRepository<role, Integer>{
}

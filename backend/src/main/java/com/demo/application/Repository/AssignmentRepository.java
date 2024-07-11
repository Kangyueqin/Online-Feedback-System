package com.demo.application.Repository;

import com.demo.application.model.Assignment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Set;

@Repository
public interface AssignmentRepository extends JpaRepository<Assignment, Long > {
    // 根据Module的moduleCode查询所有相关的Assignment
    Set<Assignment> findByModuleModuleCode(String moduleCode);
    Assignment findAssignmentById(Long assId);
}

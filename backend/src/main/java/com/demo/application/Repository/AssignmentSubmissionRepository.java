package com.demo.application.Repository;

import com.demo.application.model.Assignment;
import com.demo.application.model.AssignmentSubmission;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface AssignmentSubmissionRepository extends JpaRepository<AssignmentSubmission, Long> {
    @Query("SELECT a FROM AssignmentSubmission a WHERE a.student.id = :stuId And a.isFinal = 1 AND a.assignment.id = :assId")
    AssignmentSubmission findAssignmentSubmissionByStudentId(@Param("stuId") Long studentId, @Param("assId") Long assId);
    List<AssignmentSubmission> findAssignmentSubmissionsByStudentIdAndAssignmentId(Long stuId, Long assId);
}
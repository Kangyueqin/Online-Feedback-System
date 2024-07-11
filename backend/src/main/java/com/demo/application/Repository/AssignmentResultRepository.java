package com.demo.application.Repository;

import com.demo.application.model.AssignmentResult;
import com.demo.application.model.AssignmentSubmission;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Set;

@Repository
public interface AssignmentResultRepository extends JpaRepository<AssignmentResult, Long> {

    // 根据studentid和assid获取匹配的最终的作业成绩
    @Query("SELECT ar FROM AssignmentResult ar " +
            "JOIN ar.assignmentSubmission a " +
            "JOIN ar.criterion c " +
            "JOIN c.rubric r " +
            "WHERE a.isFinal = 1 " +
            "AND a.student.id = :stuId " +
            "AND a.assignment.id = :assId " +
            "AND r.id = :rubricId")
    List<AssignmentResult> findFinalAssignment(@Param("assId") Long assId, @Param("rubricId") Long rubricId, @Param("stuId") Long stuId);
}


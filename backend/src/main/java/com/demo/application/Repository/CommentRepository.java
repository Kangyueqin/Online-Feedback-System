package com.demo.application.Repository;

import com.demo.application.model.Comment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CommentRepository extends JpaRepository<Comment, Long> {
    // 根据分数获取位于对应区间的评论（理论上只能拿到一条，因为区间不会互相覆盖）
    @Query("SELECT c FROM Comment as c Where c.criterion.id = :criterionId and :mark >= c.lower_bound and :mark <= c.upper_bound ")
    Comment findCommentByCriterionIdAndMark(@Param("criterionId") Long criterionId, @Param("mark") Long mark);
    //  根据criterionId获取comment id列表
    @Query("SELECT c.id FROM Comment as c Where c.criterion.id = :criterionId")
    List<Long> findCommentIdsByCriterionId(@Param("criterionId") Long criterionId);
}

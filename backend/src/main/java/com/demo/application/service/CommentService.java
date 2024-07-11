package com.demo.application.service;

import com.demo.application.Repository.CommentRepository;
import com.demo.application.Repository.CriterionRepository;
import com.demo.application.model.Comment;
import com.demo.application.model.Criterion;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommentService {
    private final CriterionRepository criterionRepository;
    private final CommentRepository commentRepository;

    @Autowired
    public CommentService(CommentRepository commentRepository, CriterionRepository criterionRepository){
        this.commentRepository = commentRepository;
        this.criterionRepository = criterionRepository;
    }

    public void saveComment(Long criterionId, List<Comment> comments){
        Criterion criterion = criterionRepository.findById(criterionId).get();
        List<Long> oldCommentIds = commentRepository.findCommentIdsByCriterionId(criterionId);
        for(Comment comment : comments){
            // 逐个移除oldCommentIds中的旧评论Id，剩下的就是被删除的
            if (oldCommentIds.contains(comment.getId())){
                oldCommentIds.remove(comment.getId());
            }
            comment.setCriterion(criterion);
            commentRepository.save(comment);
        }
        // 移除旧评论
        for (Long commentId : oldCommentIds){
            commentRepository.deleteById(commentId);
        }
    }
}

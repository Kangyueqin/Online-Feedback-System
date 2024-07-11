package com.demo.application.service;

import com.demo.application.Repository.RubricRepository;
import com.demo.application.model.Comment;
import com.demo.application.model.Criterion;
import com.demo.application.model.Rubric;
import javassist.NotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.Collections;
import java.util.List;

@Service
public class RubricService {
    private final RubricRepository rubricRepository;
    @Autowired
    public RubricService(RubricRepository repository){
        this.rubricRepository = repository;
    }

    public List<Rubric> findRubricsByAssId(Long assId) throws NotFoundException {
        List<Rubric> rubrics = rubricRepository.findRubricsByAssId(assId);
        if (rubrics.isEmpty()) {
            throw new NotFoundException("Rubrics not found");
        }
        for(Rubric rubric: rubrics) {
            List<Criterion> criteria = rubric.getCriteria();
            for (Criterion criterion : criteria) {
                List<Comment> comments = criterion.getAuto_comments();
                // 将拿到的comment按照分数区间排序
                Collections.sort(comments, (a, b) -> Long.compare(a.getLower_bound(), b.getLower_bound()));
            }
        }
        return rubrics;
    }
}

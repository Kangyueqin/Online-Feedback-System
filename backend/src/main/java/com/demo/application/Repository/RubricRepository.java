package com.demo.application.Repository;

import com.demo.application.model.Criterion;
import com.demo.application.model.Rubric;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface RubricRepository extends JpaRepository<Rubric, Long> {
    List<Rubric> findRubricsByAssId(Long assId);
}

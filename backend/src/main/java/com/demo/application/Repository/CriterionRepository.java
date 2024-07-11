package com.demo.application.Repository;

import com.demo.application.model.Criterion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CriterionRepository extends JpaRepository<Criterion, Long> {
    Criterion findCriterionById(Long id);
}

package com.demo.application.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;

@Entity
@Table(name = "ass_mark_detail")
public class AssignmentResult {
    @Id
    private Long id;

    @ManyToOne
    @JsonBackReference
    @JoinColumn(name = "ass_submission_id")
    private AssignmentSubmission assignmentSubmission;

    @ManyToOne
    @JsonBackReference
    @JoinColumn(name = "criterion_id")
    private Criterion criterion;

    @Column
    private Long mark;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public AssignmentSubmission getAssignmentSubmission() {
        return assignmentSubmission;
    }

    public void setAssignmentSubmission(AssignmentSubmission assignmentSubmissionId) {
        this.assignmentSubmission = assignmentSubmissionId;
    }

    public Criterion getCriterion() {
        return criterion;
    }

    public void setCriterion(Criterion criterion) {
        this.criterion = criterion;
    }

    public Long getMark() {
        return mark;
    }

    public void setMark(Long mark) {
        this.mark = mark;
    }


}

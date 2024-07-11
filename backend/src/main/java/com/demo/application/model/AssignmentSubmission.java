package com.demo.application.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import lombok.Data;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Data
@Table(name = "ass_submission")
public class AssignmentSubmission {
    @Id
    private Long id;

    @ManyToOne
    @JsonBackReference
    @JoinColumn(name = "ass_id")
    private Assignment assignment;

    @Column(name = "is_final")
    private Long isFinal;

    @ManyToOne
    @JsonBackReference
    @JoinColumn(name = "student_id")
    private Student student;

    @Column(name = "submit_time")
    private LocalDateTime submitTime;

    @OneToMany(mappedBy = "assignmentSubmission")
    @JsonManagedReference
    private List<AssignmentResult> assignmentResults;

    @Column
    private String path;

    @Column
    private String category_offence;

    @Override
    public String toString() {
        return "AssignmentSubmission{" +
                "id=" + id +
                ", assignment=" + assignment +
                ", isFinal=" + isFinal +
                ", student=" + student +
                ", submitTime=" + submitTime +
                ", assignmentResults=" + assignmentResults +
                ", category_offence='" + category_offence + '\'' +
                '}';
    }
}

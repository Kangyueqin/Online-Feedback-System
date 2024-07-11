package com.demo.application.model;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;
import java.util.List;

@Entity
public class Criterion {
    @Id
    private Long id;

    @ManyToOne
    @JoinColumn(name = "rubric_id")
    @JsonIgnore
    private Rubric rubric;

    @Column(name = "content")
    private String criterion;

    @Column
    private Long value;

    @OneToMany(mappedBy = "criterion", fetch = FetchType.EAGER)
    private List<Comment> auto_comments;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Rubric getRubric() {
        return rubric;
    }

    public void setRubric(Rubric rubric) {
        this.rubric = rubric;
    }

    public String getCriterion() {
        return criterion;
    }

    public void setCriterion(String content) {
        this.criterion = content;
    }

    public Long getValue() {
        return value;
    }

    public void setValue(Long value) {
        this.value = value;
    }

    public List<Comment> getAuto_comments() {
        return auto_comments;
    }

    public void setAuto_comments(List<Comment> comments) {
        this.auto_comments = comments;
    }

    @Override
    public String toString() {
        return "Criterion{" +
                "id=" + id +
                ", rubric=" + rubric +
                ", criterion='" + criterion + '\'' +
                ", value=" + value +
                ", auto_comments=" + auto_comments +
                '}';
    }
}

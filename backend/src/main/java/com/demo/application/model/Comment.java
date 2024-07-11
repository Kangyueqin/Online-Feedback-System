package com.demo.application.model;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;
import java.util.Objects;

@Entity

public class Comment {
    @Id
    // id自增长
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "generate_lower_bound")
    private Long lower_bound;

    @Column(name = "generate_upper_bound")
    private Long upper_bound;

    @ManyToOne
    @JoinColumn(name = "criterion_id")
//    @JsonIgnore
    private Criterion criterion;

    @Column
    private String content;

    public Comment(){}

    public Comment(Long lower_bound, Long upper_bound, Criterion criterion, String content){
        this.lower_bound = lower_bound;
        this.upper_bound = upper_bound;
        this.criterion = criterion;
        this.content = content;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getLower_bound() {
        return lower_bound;
    }

    public void setLower_bound(Long generateLowerBound) {
        this.lower_bound = generateLowerBound;
    }

    public Long getUpper_bound() {
        return upper_bound;
    }

    public void setUpper_bound(Long generateUpperBound) {
        this.upper_bound = generateUpperBound;
    }

    public Long getCriterion() {
        return criterion.getId();
    }

    public void setCriterion(Criterion criterion) {
        this.criterion = criterion;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    @Override
    public String toString() {
        return "Comment{" +
                "id=" + id +
                ", lower_bound=" + lower_bound +
                ", upper_bound=" + upper_bound +
                ", content='" + content + '\'' +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Comment comment = (Comment) o;
        return id.equals(comment.id) && lower_bound.equals(comment.lower_bound) && upper_bound.equals(comment.upper_bound) && Objects.equals(criterion, comment.criterion) && Objects.equals(content, comment.content);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, lower_bound, upper_bound, criterion, content);
    }
}

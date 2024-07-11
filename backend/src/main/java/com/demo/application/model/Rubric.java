package com.demo.application.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Data;

import javax.persistence.*;
import java.util.List;

@Entity
@Data  // generate getter and setter automatically
public class Rubric {
    @Id
    private Long id;

    @Column(name = "ass_id")
    @JsonIgnore
    private Long assId;

    @Column(name = "content")
    private String rubric;

    @OneToMany(mappedBy = "rubric", fetch = FetchType.EAGER)
    private List<Criterion> criteria;

    @Override
    public String toString() {
        return "Rubric{" +
                "id=" + id +
                ", assId=" + assId +
                ", rubric='" + rubric + '\'' +
                ", criteria=" + criteria +
                '}';
    }
}

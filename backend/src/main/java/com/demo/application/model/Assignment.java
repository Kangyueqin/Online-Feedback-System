package com.demo.application.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Data;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Data
public class Assignment {
    @Id
    private Long id;

    @Column(name = "name")
    private String name;

    @Column(name = "start_time")
    private LocalDateTime startDate;

    @Column(name = "end_time")
    private LocalDateTime endDate;

    @Column
    private Long penalty;

    @JsonBackReference
    @ManyToOne()
    // name表示表中的外键名，referencedColumnName表示Module模型中被参照的列名
    @JoinColumn(name = "module_code", referencedColumnName = "moduleCode")
    private Module module;

    @JsonIgnore
    @Column
    private String path;


}

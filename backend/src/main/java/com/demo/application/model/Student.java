package com.demo.application.model;

import javax.persistence.*;
import java.util.Set;

// 标记实体类，表示该类会被映射到数据库中的一个表
@Entity
@Table(name = "student")  // 指定表的名称
public class Student {
    @Id  // 指定主键
    private Long id;

    @OneToOne
    @MapsId
    @JoinColumn(name = "id")  // student的主键也是user id的外键
    private User user;

    @Column(name = "name")
    private String name;

    @Column(name = "year")
    private Integer year;

    /*inverseJoinColumns 是 @JoinTable 注解的一个属性，
    它用于指定目标实体（被拥有方，inverse side）在关联表中的外键列的定义*/
    @ManyToMany
    @JoinTable(
            name = "module_student",
            joinColumns = @JoinColumn(name = "student_id"),
            inverseJoinColumns = @JoinColumn(name = "module_code")
    )
    private Set<Module> modules;


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getYear() {
        return year;
    }

    public void setYear(Integer year) {
        this.year = year;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Set<Module> getModules() {
        return modules;
    }

    public void setModules(Set<Module> modules) {
        this.modules = modules;
    }

    @Override
    public String toString() {
        return "Student{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", year=" + year +
                '}';
    }
}

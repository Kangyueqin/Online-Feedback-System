package com.demo.application.model;

import javax.persistence.*;
import java.util.Set;

@Entity
public class Teacher {
    @Id  // assign primary key
    private Long id;

    @OneToOne
    @MapsId
    @JoinColumn(name = "id")  // student's primary key is also the foreign key of user's id
    private User user;

    @Column(name = "name")
    private String name;

    @ManyToMany
    @JoinTable(
            name = "module_teacher",
            joinColumns = @JoinColumn(name = "teacher_id"),
            inverseJoinColumns = @JoinColumn(name = "module_code")
    )
    private Set<Module> modules;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Set<Module> getModules() {
        return modules;
    }

    public void setModules(Set<Module> modules) {
        this.modules = modules;
    }
}

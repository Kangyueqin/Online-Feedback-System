package com.demo.application.model;

import javax.persistence.*;

@Entity
public class User {

    @Id
    private Long id;

    @Column(name = "password")
    private String password;

    // The name attribute here corresponds to the primary key field name of the Role entity
    @ManyToOne
    @JoinColumn(name = "role")
    private Role role;

    private Boolean isEnabled = true;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role.getRole();
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public Boolean getEnabled() {
        return isEnabled;
    }

    public void setEnabled(Boolean enabled) {
        isEnabled = enabled;
    }
}

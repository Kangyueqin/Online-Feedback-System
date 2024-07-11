package com.demo.application.model;

import javax.persistence.*;
import java.util.Set;

@Entity
public class Module {
    @Id
    private String moduleCode;

    @Column(name = "module_name")
    private String moduleName;

    @Column(name = "year_start")
    private Integer year_start;

    @Column(name = "year_end")
    private Integer year_end;

    public String getModuleCode() {
        return moduleCode;
    }

    public void setModuleCode(String moduleCode) {
        this.moduleCode = moduleCode;
    }

    public String getModuleName() {
        return moduleName;
    }

    public void setModuleName(String moduleName) {
        this.moduleName = moduleName;
    }

    public Integer getYear_start() {
        return year_start;
    }

    public void setYear_start(Integer year_start) {
        this.year_start = year_start;
    }

    public Integer getYear_end() {
        return year_end;
    }

    public void setYear_end(Integer year_end) {
        this.year_end = year_end;
    }

}

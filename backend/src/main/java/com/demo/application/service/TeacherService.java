package com.demo.application.service;

import com.demo.application.Repository.TeacherRepository;
import com.demo.application.model.Module;
import com.demo.application.model.Teacher;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Set;

@Service
public class TeacherService {
    private TeacherRepository teacherRepository;

    @Autowired
    public TeacherService (TeacherRepository teacherRepository){
        this.teacherRepository = teacherRepository;
    }

    public Teacher findTeacherById(Long id){
        return teacherRepository.findTeacherById(id);
    }

    public Set<Module> findModulesByTeacherId(Long id){
        return teacherRepository.findModulesByTeacherId(id);
    }
}

package com.demo.application.service;

import com.demo.application.Repository.StudentRepository;
import com.demo.application.model.Module;
import com.demo.application.model.Student;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Set;

@Service
public class StudentService {
    private final StudentRepository studentRepository;

    @Autowired
//    直接在类的字段上使用，使得Spring负责依赖项的注入，
//    不需要调用显式的构造函数或者setter方法
    public StudentService(StudentRepository studentRepository) {
        this.studentRepository = studentRepository;}

    public Student getStudentByID(Long id){
        // 调用仓库接口的方法
        return studentRepository.findStudentById(id);
    }

    public Set<Module> findModulesByStudentId(Long id){
        return studentRepository.findModulesByStudentId(id);
    }

}




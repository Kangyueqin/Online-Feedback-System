package com.demo.application.service;

import com.demo.application.model.Module;
import com.demo.application.model.Student;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runner.Runner;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import javax.annotation.Resource;

import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.Set;
import java.util.stream.Collectors;

import static org.junit.Assert.*;

@SpringBootTest
@RunWith(SpringRunner.class)
public class StudentServiceTest {

    @Resource
    private StudentService studentService;

    @Test
    public void getStudentByID() {
        Long expectedId = 201322334L;
        Student expectedStudent = studentService.getStudentByID(expectedId);
        assertEquals(expectedId, expectedStudent.getId());
    }

    @Test
    public void getStudentByTeacherID() {
        Long expectedId = 201612345L;
        Student expectedStudent = studentService.getStudentByID(expectedId);
        assertNull(expectedStudent);
    }

    @Test
    public void getStudentByNonexistID() {
        Long expectedId = 000000000L;
        Student expectedStudent = studentService.getStudentByID(expectedId);
        assertNull(expectedStudent);
    }

    @Test
    public void findModulesByStudentId() {
        Set<String> moduleCodeList = new HashSet<>();
        moduleCodeList.add("COMP284");
        Set<Module> targetModule = studentService.findModulesByStudentId(201322334L);
        assertEquals(moduleCodeList, targetModule.stream().map(Module::getModuleCode).collect(Collectors.toSet()));
    }

    @Test
    public void findModulesByTeacherId() {
        // the case user is student
        Set<Module> emptyList = new LinkedHashSet<>();
        assertEquals(emptyList, studentService.findModulesByStudentId(201612345L));
    }

    @Test
    public void findModulesByNonexistId(){
        // the case user is student
        Set<Module> emptyList = new LinkedHashSet<>();
        assertEquals(emptyList, studentService.findModulesByStudentId(000000L));
    }
}
package com.demo.application.service;

import com.demo.application.model.Module;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import javax.annotation.Resource;

import java.util.*;
import java.util.stream.Collectors;

import static org.junit.Assert.*;

@SpringBootTest
@RunWith(SpringRunner.class)
public class TeacherServiceTest {

    @Resource
    private TeacherService teacherService;

    @Test
    public void findTeacherByCorrectId() {
        assertEquals("t1", teacherService.findTeacherById(201676887L).getName());
    }

    @Test
    public void findTeacherByStudentId() {
        // the case user is student
        Assert.assertNull(teacherService.findTeacherById(201698763L));
    }

    @Test
    public void findTeacherByNonexistId() {
        // the case user is student
        Assert.assertNull(teacherService.findTeacherById(12332312L));
    }

    @Test
    public void findModulesByTeacherId() {
        Set<String> moduleCodeList = new HashSet<>();
        moduleCodeList.add("COMP284");
        moduleCodeList.add("COMP333");
        Set<Module> targetModule = teacherService.findModulesByTeacherId(201612345L);
        assertEquals(moduleCodeList, targetModule.stream().map(Module::getModuleCode).collect(Collectors.toSet()));
    }

    @Test
    public void findModulesByStudentId(){
        // the case user is student
        Set<Module> emptyList = new LinkedHashSet<>();
        assertEquals(emptyList, teacherService.findModulesByTeacherId(201322334L));
    }

    @Test
    public void findModulesByNonexistId(){
        // the case user is student
        Set<Module> emptyList = new LinkedHashSet<>();
        assertEquals(emptyList, teacherService.findModulesByTeacherId(000000L));
    }

}
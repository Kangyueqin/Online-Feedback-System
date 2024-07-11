package com.demo.application.service;

import com.demo.application.model.Assignment;
import com.demo.application.model.AssignmentFileDTO;
import com.demo.application.model.AssignmentResultDTO;
import com.demo.application.model.AssignmentSubmission;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import javax.annotation.Resource;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import static org.junit.Assert.*;

@SpringBootTest
@RunWith(SpringRunner.class)
public class AssignmentServiceTest {

    @Resource
    private AssignmentService assignmentService;

    @Test
    public void findAssignmentByModuleCode() {
        String correctCode = "COMP390";
        List<String> expectedAssignmentNames = new ArrayList<>(Arrays.asList("test"));
        assertEquals(expectedAssignmentNames, assignmentService.findAssignmentsByModuleCode(correctCode).stream().map(Assignment::getName).collect(Collectors.toList()));
    }

    @Test
    public void findAssignmentByNonexistModuleCode() {
        String correctCode = "COMP3900";
        List<Assignment> emptyList = new ArrayList<>();
        assertEquals(emptyList, assignmentService.findAssignmentsByModuleCode(correctCode).stream().map(Assignment::getName).collect(Collectors.toList()));
    }

    @Test
    public void findFilesByAssIdAndStuId() {
        Long correctAssId = 1L;
        Long correctStuId = 201523456L;
        List<String> expectedFileNames = new ArrayList<>(Arrays.asList("stat.pl"));
        assertEquals(expectedFileNames, assignmentService.findFilesByAssIdAndStuId(correctAssId, correctStuId).stream().map(AssignmentFileDTO::getFileName).collect(Collectors.toList()));
    }

    @Test
    public void findFilesByAssIdAndWrongStuId() {
        Long correctAssId = 1L;
        Long wrongStuId = 0000000L;
        List<String> expectedFileNames = new ArrayList<>();
        assertEquals(expectedFileNames, assignmentService.findFilesByAssIdAndStuId(correctAssId, wrongStuId).stream().map(AssignmentFileDTO::getFileName).collect(Collectors.toList()));
    }

    @Test
    public void findFilesByWrongAssIdAndStuId() {
        Long correctAssId = -1L;
        Long wrongStuId = 201523456L;
        List<String> expectedFileNames = new ArrayList<>();
        assertEquals(expectedFileNames, assignmentService.findFilesByAssIdAndStuId(correctAssId, wrongStuId).stream().map(AssignmentFileDTO::getFileName).collect(Collectors.toList()));
    }


    @Test
    public void findStudentAssInfo() {
        Long correctAssId = 1L;
        Long correctStuId = 201523456L;
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.SSSSSS");
        LocalDateTime expectedSubmitTime = LocalDateTime.parse("2024-02-06 13:43:12.000000",formatter);
        LocalDateTime expectedDeadline = LocalDateTime.parse("2024-02-06 17:00:00.000000",formatter);
        assertEquals(expectedSubmitTime,assignmentService.findStudentAssInfo(correctAssId, correctStuId).getSubmitTime());
        assertEquals(expectedDeadline,assignmentService.findStudentAssInfo(correctAssId, correctStuId).getDeadline());
        }

    @Test
    public void findStudentAssInfoWithWrongAssId() {
        Long wrongAssId = -1L;
        Long correctStuId = 201523456L;
        assertNull(assignmentService.findStudentAssInfo(wrongAssId, correctStuId));
    }

    @Test
    public void findStudentAssInfoWithWrongStuId() {
        Long wrongAssId = 1L;
        Long correctStuId = 000000000L;
        assertNull(assignmentService.findStudentAssInfo(wrongAssId, correctStuId));
    }

    @Test
    public void findAssignmentSubmission() {
        Long correctAssId = 1L;
        Long correctStuId = 201523456L;
        Long firstMark = 10L;
        Long secondMark = 24L;
        assertEquals(firstMark,assignmentService.findAssignmentSubmission(correctAssId, correctStuId).get(0).getMark());
        assertEquals(secondMark,assignmentService.findAssignmentSubmission(correctAssId, correctStuId).get(1).getMark());
    }

    @Test
    public void findAssignmentSubmissionWithWrongAssId() {
        Long wrongAssId = -1L;
        Long correctStuId = 201523456L;
        List<AssignmentResultDTO> emptyList = new ArrayList<>();
        assertEquals(emptyList,assignmentService.findAssignmentSubmission(wrongAssId, correctStuId));
    }

    @Test
    public void findAssignmentSubmissionWithWrongStuId() {
        Long correctAssId = 1L;
        Long wrongStuId = -1000000000L;
        List<AssignmentResultDTO> target = assignmentService.findAssignmentSubmission(correctAssId, wrongStuId);
        assertEquals(5,target.size());
    }

    @Test
    public void downloadAssignment() throws Exception {
        org.springframework.core.io.Resource targetFile = assignmentService.downloadAssignment("COMP284-1/test/test.txt");
        String targetContent = new String(Files.readAllBytes(Paths.get(targetFile.getURI())));
        String exceptContent = "this is a test content";
        assertEquals(exceptContent,targetContent);
    }

    @Test
    public void downloadAssignmentWithWrongPath() throws Exception {
        try{
            org.springframework.core.io.Resource targetFile = assignmentService.downloadAssignment("wrong path");
            fail("Expected FileNotFoundException");
        }catch (Exception e){
            assertEquals("File not found: wrong path",e.getMessage());
        }

    }
}
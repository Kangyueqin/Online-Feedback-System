package com.demo.application.service;

import com.demo.application.model.Rubric;
import javassist.NotFoundException;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import javax.annotation.Resource;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import static org.junit.Assert.*;

@SpringBootTest
@RunWith(SpringRunner.class)
public class RubricServiceTest {

    @Resource
    private RubricService rubricService;

    @Test
    public void findRubricsByAssId() throws NotFoundException {
        Long correctId = 5L;
        List<String> expectedRubrics = new ArrayList<>(Arrays.asList("test rubric"));
        List<Rubric> getRubrics = rubricService.findRubricsByAssId(correctId);
        assertEquals(expectedRubrics, getRubrics.stream().map(Rubric::getRubric).collect(Collectors.toList()));
    }

    @Test
    public void findRubricsByNonexsitAssId() throws NotFoundException {
        Long correctId = 50L;
        List<String> expectedRubrics = new ArrayList<>(Arrays.asList("test rubric"));
        try {
            rubricService.findRubricsByAssId(correctId);
            fail("Expected NotFoundException");
        } catch (NotFoundException e) {
            assertEquals("Rubrics not found", e.getMessage());
        }
    }

}
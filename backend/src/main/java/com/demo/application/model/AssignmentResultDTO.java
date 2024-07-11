package com.demo.application.model;


import lombok.Data;

import java.util.List;
@Data
// 一个rubric对应一个assignmentResult
public class AssignmentResultDTO {
    private String rubric;
    private Long mark;
    private Long value;
    private List<String> comment;

    public AssignmentResultDTO(String rubric, Long studentMark, Long rubricValue, List<String> comment){
        this.rubric = rubric;
        this.comment = comment;
        this.mark = studentMark;
        this.value = rubricValue;
    }
}

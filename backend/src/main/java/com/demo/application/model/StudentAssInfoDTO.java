package com.demo.application.model;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class StudentAssInfoDTO {
    private LocalDateTime submitTime;
    private LocalDateTime deadline;
    private Long penalty;
    private String category_offence;

    public StudentAssInfoDTO(LocalDateTime submitTime, LocalDateTime deadline, Long penalty, String category_offence){
        this.submitTime = submitTime;
        this.deadline = deadline;
        this.penalty = penalty;
        this.category_offence = category_offence;
        if (category_offence == null || category_offence == "") this.category_offence = "none";
    }

    @Override
    public String toString() {
        return "StudentAssInfoDTO{" +
                "submitTime=" + submitTime +
                ", deadline=" + deadline +
                ", penalty=" + penalty +
                '}';
    }
}

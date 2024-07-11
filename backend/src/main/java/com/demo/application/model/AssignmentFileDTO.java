package com.demo.application.model;

import lombok.Data;

@Data
public class AssignmentFileDTO {
    private FileType fileType;
    private String fileName;
    private String filePath;  // the relative path to the module folder is not exposed

    public enum FileType{
        DIRECTORY, FILE
    }

    public AssignmentFileDTO(String fileName, String filePath){
        this.filePath = filePath;
        this.fileName = fileName;
    }
}

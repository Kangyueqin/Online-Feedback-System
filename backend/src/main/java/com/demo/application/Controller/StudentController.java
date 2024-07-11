package com.demo.application.Controller;

import com.demo.application.model.Assignment;
import com.demo.application.model.Module;
import com.demo.application.service.AssignmentService;
import com.demo.application.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Set;


@RestController
@RequestMapping("/student")
public class StudentController {

    private final StudentService studentService;
    private final AssignmentService assignmentService;

    @Autowired
    public StudentController(StudentService studentService, AssignmentService assignmentService){
        this.studentService = studentService;
        this.assignmentService = assignmentService;
    }

    @GetMapping("/modules")
    public ResponseEntity<Set<Module>> findModulesByStudentId(@RequestParam Long id){
        Set<Module> modules = studentService.findModulesByStudentId(id);
        return ResponseEntity.ok(modules);
    }

    @GetMapping("/assignments")
    public ResponseEntity<?> findAssignmentByModuleModuleCode(@RequestParam String moduleCode, Long id){
        Set<Module> modules = studentService.findModulesByStudentId(id);
        boolean isFind = false;
        for (Module module: modules
        ) {
            if (module.getModuleCode().equals(moduleCode)){
                isFind = true;
                break;
            }
        }
        if (!isFind) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body("Access denied");
        }
        Set<Assignment> assignments = assignmentService.findAssignmentsByModuleCode(moduleCode);
        return ResponseEntity.ok(assignments);
    }


}

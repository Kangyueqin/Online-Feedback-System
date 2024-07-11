package com.demo.application.Controller;

import com.demo.application.model.Assignment;
import com.demo.application.model.Comment;
import com.demo.application.model.Module;
import com.demo.application.model.Teacher;
import com.demo.application.service.CommentService;
import com.demo.application.service.AssignmentService;
import com.demo.application.service.TeacherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Set;

@RestController
@RequestMapping("/teacher")
public class TeacherController {
    private final TeacherService teacherService;
    private final AssignmentService assignmentService;
    private final CommentService commentService;

    @Autowired
    public TeacherController (TeacherService teacherService, AssignmentService assignmentService, CommentService commentService){
        this.teacherService = teacherService;
        this.assignmentService = assignmentService;
        this.commentService = commentService;
    }

    @GetMapping("/findTeacher")
    public ResponseEntity<Teacher> findTeacherById(@RequestParam Long id){
        Teacher teacher = teacherService.findTeacherById(id);
        return ResponseEntity.ok(teacher);
    }

    @PreAuthorize("#id.toString() == principal.username")
    @GetMapping("/modules")
    public ResponseEntity<Set<Module>> findModulesByTeacherId(@RequestParam Long id){
        Set<Module> modules = teacherService.findModulesByTeacherId(id);
        return ResponseEntity.ok(modules);
    }

    @PreAuthorize("#id.toString() == principal.username")
    @GetMapping("/assignments")
    public ResponseEntity<?> findAssignmentByModuleModuleCode(@RequestParam String moduleCode, Long id){
        Set<Module> modules = teacherService.findModulesByTeacherId(id);
        boolean isFind = false;
        for (Module module: modules
             ) {
            if (module.getModuleCode().equals(moduleCode)){
                isFind = true;
                break;
            }
        }
        if (!isFind) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("unauthorized module");
        }
        Set<Assignment> assignments = assignmentService.findAssignmentsByModuleCode(moduleCode);
        return ResponseEntity.ok(assignments);
    }

    @PostMapping("/saveComments")
    public ResponseEntity<?> saveComments(@Param("criterionId") Long criterionId, @RequestBody List<Comment> comments){
        // 验证分数区间是否连续不重复
        for (int i = 0; i < comments.size() - 1; i++){
            if (comments.size() > 1 && comments.get(i).getUpper_bound() != comments.get(i+1).getLower_bound() - 1){
                return ResponseEntity.badRequest().body("Please make sure the score range is continuous and no duplicate");
            }
        }
        commentService.saveComment(criterionId, comments);
        System.out.println("get cId"+criterionId);
        return ResponseEntity.ok("receive comments");
    }

}

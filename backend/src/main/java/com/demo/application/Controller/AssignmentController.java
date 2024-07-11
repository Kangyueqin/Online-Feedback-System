package com.demo.application.Controller;
import com.demo.application.model.*;
import com.demo.application.service.AssignmentService;
import com.demo.application.service.RubricService;
import com.demo.application.service.UserService;
import javassist.NotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.io.FileNotFoundException;
import java.util.List;

@RestController
@RequestMapping("/assignment")
public class AssignmentController {
    private final AssignmentService assignmentService;
    private final RubricService rubricService;
    private final UserService userService;

    @Autowired
    public AssignmentController(AssignmentService assignmentService, RubricService rubricService, UserService userService){
        this.rubricService = rubricService;
        this.assignmentService = assignmentService;
        this.userService = userService;
    }

    // Teacher only
    @PreAuthorize("hasAnyAuthority('Teacher') && #teacherId.toString() == principal.username")
    @GetMapping("/rubrics")
    public ResponseEntity<List<Rubric>> findRubricsByAssId(@RequestParam Long assId, Long teacherId) {
        String id = userService.getUserId();
        try{
            List<Rubric> rubrics = rubricService.findRubricsByAssId(assId);
            return ResponseEntity.ok(rubrics);
        }catch (NotFoundException e){
            return ResponseEntity.notFound().build();
        }
    }

    //Student himself only
    @PreAuthorize("#stuId.toString() == principal.username")
    @GetMapping("/result")
    public ResponseEntity<List<AssignmentResultDTO>> findAssignmentSubmission(@RequestParam Long assId, Long stuId){
        List<AssignmentResultDTO> assignmentSubmission = assignmentService.findAssignmentSubmission(assId, stuId);
        return ResponseEntity.ok(assignmentSubmission);
    }

    // 返回学生作业的提交时间，作业截止日期以及惩罚
    @PreAuthorize("#stuId.toString() == principal.username")
    @GetMapping("/overallInfo")
    public ResponseEntity<StudentAssInfoDTO> findStudentAssInfo(@RequestParam Long assId, Long stuId) {
        StudentAssInfoDTO studentAssInfoDTO = assignmentService.findStudentAssInfo(assId, stuId);
        if (studentAssInfoDTO == null){
            return ResponseEntity.notFound().build();
        }
        else return ResponseEntity.ok(studentAssInfoDTO);
    }

    @GetMapping("/getTargetFile")
    @PreAuthorize("#stuId.toString() == principal.username")
    public ResponseEntity<List<AssignmentFileDTO>> findFilesByAssIdAndStuId(@RequestParam Long assId, Long stuId){
        List<AssignmentFileDTO> assignmentFileDTOS = assignmentService.findFilesByAssIdAndStuId(assId, stuId);
        if (assignmentFileDTOS.size() == 0){
            return ResponseEntity.notFound().build();
        }
        else return ResponseEntity.ok(assignmentFileDTOS);
    }

    @PreAuthorize("#stuId.toString() == principal.username")
    @GetMapping("/download")
    public ResponseEntity<Resource> findCommentByCriterionIdAndMark(@RequestParam Long stuId, String path){
        System.out.println("getID: " + SecurityContextHolder.getContext().getAuthentication().getPrincipal());
        try{
            Resource resource = assignmentService.downloadAssignment(path);
            return ResponseEntity.ok()
                    .contentType(MediaType.APPLICATION_OCTET_STREAM)
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + resource.getFilename() + "\"")
                    .body(resource);
        } catch (FileNotFoundException e){
            return ResponseEntity.notFound().build();
        } catch (Exception e){
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();

        }
    }
}

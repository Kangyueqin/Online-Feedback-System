package com.demo.application.service;

import com.demo.application.Repository.*;
import com.demo.application.model.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.stereotype.Service;

import java.io.FileNotFoundException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Stream;

@Service
public class AssignmentService {
    private final AssignmentRepository assignmentRepository;
    private final AssignmentResultRepository assignmentResultRepository;
    private final AssignmentSubmissionRepository assignmentSubmissionRepository;
    private final RubricRepository rubricRepository;
    private final CommentRepository commentRepository;
    // 获取配置文件中的默认根目录
    @Value("${file.base-directory}")
    private String baseDirectory;

    @Autowired
    public AssignmentService(AssignmentRepository assignmentRepository, AssignmentResultRepository assignmentResultRepository, AssignmentSubmissionRepository assignmentSubmissionRepository, RubricRepository rubricRepository, CommentRepository commentRepository){
        this.assignmentRepository = assignmentRepository;
        this.assignmentResultRepository = assignmentResultRepository;
        this.assignmentSubmissionRepository = assignmentSubmissionRepository;
        this.rubricRepository = rubricRepository;
        this.commentRepository = commentRepository;
    }

    public Set<Assignment> findAssignmentsByModuleCode(String moduleCode){
        return assignmentRepository.findByModuleModuleCode(moduleCode);
    }

    // 返回学生提交的文件列表
    public List<AssignmentFileDTO> findFilesByAssIdAndStuId(Long assId, Long stuId){
        List<AssignmentSubmission> assignmentSubmissions =
                assignmentSubmissionRepository.findAssignmentSubmissionsByStudentIdAndAssignmentId(stuId, assId);

        List<AssignmentFileDTO> files = new ArrayList<>();
        // Convert all the submissions into DTOs
        for (AssignmentSubmission submission: assignmentSubmissions) {
            Path baseDir = Paths.get(this.baseDirectory);
            Path assignmentPath = Paths.get(submission.getAssignment().getPath());
            Path submissionPath = Paths.get(submission.getPath());
            Path targetPath = baseDir.resolve(assignmentPath).resolve(submissionPath);

            // fetch the file in the folder
            try(Stream<Path> stream = Files.walk(targetPath)) {
                stream.forEach(path -> {
                    // Hidden root directory
                    Path relativePath = baseDir.relativize(path);
                    if (Files.isRegularFile(path)){
                        AssignmentFileDTO target =
                                new AssignmentFileDTO(path.getFileName().toString(), relativePath.toString().replace("\\","/"));
                        target.setFileType(AssignmentFileDTO.FileType.FILE);
                        files.add(target);
                    }
                });
            } catch (Exception e) { }

        }
        return files;
    }


    public StudentAssInfoDTO findStudentAssInfo(Long assId,Long stuId){
        Assignment assignment = assignmentRepository.findAssignmentById(assId);
        AssignmentSubmission assignmentSubmission = assignmentSubmissionRepository.findAssignmentSubmissionByStudentId(stuId, assId);
        if (assignment != null && assignmentSubmission != null){
            LocalDateTime assDeadline = assignment.getEndDate();
            LocalDateTime submissionDate = assignmentSubmission.getSubmitTime();
            Long penalty = assignment.getPenalty();
            String category_offence = assignmentSubmission.getCategory_offence();
            StudentAssInfoDTO studentAssInfoDTO = new StudentAssInfoDTO(submissionDate, assDeadline , penalty, category_offence);
            return studentAssInfoDTO;
        }
        return null;
    }

    public List<AssignmentResultDTO> findAssignmentSubmission(Long assId, Long stuId) {
        List<AssignmentResultDTO> results = new ArrayList<>();
        List<Rubric> rubrics = rubricRepository.findRubricsByAssId(assId);
        // 遍历rubric获取对应的criterion
        for (Rubric rubric: rubrics){
            String content = rubric.getRubric();
            // 获取学生该rubric下属的小分列表
            List<AssignmentResult> studentResults = this.assignmentResultRepository.findFinalAssignment(assId, rubric.getId(), stuId);
            //  学生该rubric下属criteria的分数所对应自动生成的评论
            List<String> comments = new ArrayList<>();
            // 获取对应criterion的列表算出单项rubric总分
            List<Criterion> criteria = rubric.getCriteria();
            Long studentTotalMark = new Long(0);
            Long rubricValue = new Long(0);
            for (AssignmentResult studentResult: studentResults) {
                //根据rubricId算单项分
                studentTotalMark += studentResult.getMark();
                Long criterionId = studentResult.getCriterion().getId();
                Long mark = studentResult.getMark();
                Comment comment = commentRepository.findCommentByCriterionIdAndMark(criterionId, mark);
                if (comment != null){
                    comments.add(comment.getContent());
                }
            }
            for (Criterion criterion: criteria){
                rubricValue += criterion.getValue();
            }
            AssignmentResultDTO assDTO = new AssignmentResultDTO(rubric.getRubric(), studentTotalMark, rubricValue, comments);
            results.add(assDTO);
        }
        return results;
    }

    public Resource downloadAssignment(String path) throws FileNotFoundException {
        try {
            Path targetPath = Paths.get(this.baseDirectory).resolve(path).normalize();
            Resource resource = new UrlResource(targetPath.toUri());
            if (resource.exists() && resource.isReadable()){
                return resource;
            }
            else{
                throw new FileNotFoundException("File not found: " + path);
            }
        }catch (Exception e){
            throw new FileNotFoundException("File not found: " + path);
        }
    }

}

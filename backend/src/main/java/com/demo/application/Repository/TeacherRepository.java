package com.demo.application.Repository;

import com.demo.application.model.Module;
import com.demo.application.model.Teacher;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Set;

@Repository
public interface TeacherRepository extends JpaRepository<Teacher, Long> {
    Teacher findTeacherById(Long id);
    @Query("select t.modules from Teacher t where t.id = :teacherId")
    Set<Module> findModulesByTeacherId(@Param("teacherId") Long teacherId);
}

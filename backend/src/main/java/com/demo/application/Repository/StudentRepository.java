package com.demo.application.Repository;

import com.demo.application.model.Module;
import com.demo.application.model.Student;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Set;

@Repository
/* 注解后其实现是由Spring Data JPA自动创建的，
 因此不需要手动实现其中定义的方法，在服务类中只需要关注业务逻辑*/
/*
* 自定义查询方法只需要遵循命名约定
*  findBy 后跟实体的属性名。Spring Data JPA 会根据方法名自动生成查询
* */
//JpaRepository<Student, Long> 表示仓库将管理Student实体类的实例。第二个参数是实体类的ID属性的类型
public interface StudentRepository extends JpaRepository<Student, Long> {
    Student findStudentById(Long id);
    @Query("select s.modules from Student s WHERE s.id =:studentId")
    Set<Module> findModulesByStudentId(@Param("studentId")Long studentId);
}

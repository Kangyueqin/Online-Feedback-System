package com.demo.application.Repository;

import com.demo.application.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import javax.swing.text.html.Option;
import java.util.Optional;

@Repository
public interface UserRespository extends JpaRepository<User, Long>{
    User findUserById(Long id);
}

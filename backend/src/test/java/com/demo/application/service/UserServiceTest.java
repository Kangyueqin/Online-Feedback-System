package com.demo.application.service;

import com.demo.application.model.Role;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.test.context.junit4.SpringRunner;

import javax.annotation.Resource;
import javax.persistence.Column;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import java.util.ArrayList;
import java.util.List;

import static org.junit.Assert.*;

@SpringBootTest
@RunWith(SpringRunner.class)
public class UserServiceTest {

    @Resource
    private UserService userService;

    @Test
    public void getUserByCorrectId(){
        Long id = 201676887L;
        String password = "123";
        assertEquals(id, userService.getUserByID(id).getId());
        assertEquals(password, userService.getUserByID(new Long(201676886)).getPassword());
    }

    @Test
    public void getUserByNonExsitId(){
        Long id = 100000000L;
        assertNull(userService.getUserByID(id));
    }


    @Test
    public void loadUserByUsername() {
        List<GrantedAuthority> authorities = new ArrayList<>();
        authorities.add(new SimpleGrantedAuthority("Teacher"));
        User expectedUser = new User(String.valueOf(201676886), "123", true, true, true, true, authorities);
        assertEquals(expectedUser, userService.loadUserByUsername("201676886"));
    }


}
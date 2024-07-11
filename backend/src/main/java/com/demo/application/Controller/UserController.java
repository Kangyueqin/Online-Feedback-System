package com.demo.application.Controller;

import com.demo.application.model.User;
import com.demo.application.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Optional;

@RestController
@RequestMapping("/users")
public class UserController {
    private final UserService userService;

    @Autowired
    public UserController(UserService userService){
        this.userService = userService;
    }

    @GetMapping("/byId")
    public ResponseEntity<User> getUserById(@RequestParam  Long id){
        User user = userService.getUserByID(id);
        return ResponseEntity.ok(user);
    }

}

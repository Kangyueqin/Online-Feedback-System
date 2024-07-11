package com.demo.application.service;

import com.demo.application.Repository.UserRespository;
import com.demo.application.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class UserService implements UserDetailsService {
    public final UserRespository userRespository;

    @Autowired
    public UserService( UserRespository userRespository) {
        this.userRespository = userRespository;
    }

    public User getUserByID(Long id) {
        return userRespository.findUserById(id);
    }


    //实现UserDetailsService中的用户加载方法
    @Override
    public UserDetails loadUserByUsername(String id) throws UsernameNotFoundException {
        User user = userRespository.findUserById(Long.parseLong(id));
        if (user == null) throw new UsernameNotFoundException("Could not found with user: " + id);
        List<GrantedAuthority> userAuthorities = getAuthorities(user);
        org.springframework.security.core.userdetails.User userPermission = new org.springframework.security.core.userdetails.User(String.valueOf(user.getId()), user.getPassword(), true, true, true, true, userAuthorities);
        return userPermission;
    }

    public String getUserId(){
        return SecurityContextHolder.getContext().getAuthentication().getName(); }

    // 定义用户权限
    private List<GrantedAuthority> getAuthorities(User user) {
        List<GrantedAuthority> authorities = new ArrayList<>();
        authorities.add(new SimpleGrantedAuthority("" + user.getRole()));
        return authorities;
    }

}

package com.demo.application.Configuration;


import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.crypto.password.NoOpPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Configuration
@EnableWebSecurity
/*The prePostEnabled property determines
whether Spring Security can authorize @PreAuthorize,@PostAuthorize
 and so on before an interface. Set to true,
 it will intercept the interfaces with these annotations*/
@EnableGlobalMethodSecurity(prePostEnabled=true)
class WebSecurityConfig extends WebSecurityConfigurerAdapter {
    //Request interception configuration
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
                .csrf().disable() // Disable CSRF protection
                .authorizeRequests() // Configure the request for authorization
                .antMatchers("/teachers/**").hasAuthority("Teacher") // Only the teacher can access the resources in the /teacher path
                .antMatchers("/students/**").hasAuthority("Student") // Only the student  can access the resources in the /student path
                .anyRequest().authenticated()
                .and()
                .formLogin() // Use the form for login authentication
                .loginPage("/login").permitAll() // Customize the login page
                .failureHandler(new AuthenticationFailureHandler() {
                    @Override
                    public void onAuthenticationFailure(HttpServletRequest req, HttpServletResponse resp, AuthenticationException e) throws IOException, ServletException {
                        resp.setContentType("application/json;charset=utf-8");
                        resp.setStatus(401);
                        Map<String, Object> respData = new HashMap<>();
                        respData.put("message", "login fail");
                        resp.getWriter().write(new ObjectMapper().writeValueAsString(respData));
                        resp.getWriter().flush();
                    }
                })
                .successHandler(new AuthenticationSuccessHandler() {
                    @Override
                    public void onAuthenticationSuccess(HttpServletRequest req, HttpServletResponse resp, Authentication auth) throws IOException, ServletException {
                        resp.setContentType("application/json;charset=utf-8");
                        Map<String, Object> respData = new HashMap<>();
                        respData.put("message", "login successful");
                        respData.put("userName", auth.getName());
                        respData.put("userRole", auth.getAuthorities());
                        resp.getWriter().write(new ObjectMapper().writeValueAsString(respData));
                        resp.getWriter().flush();
                    }
                })
                .and()
                .logout()
                .permitAll()
                .logoutSuccessHandler(new LogoutSuccessHandler() {
                    @Override
                    public void onLogoutSuccess(HttpServletRequest req, HttpServletResponse resp, Authentication auth) throws IOException {
                        resp.setStatus(HttpServletResponse.SC_OK);
                        resp.setContentType("application/json");
                        resp.getWriter().println("{\"message\":\"Logged out successfully\"}");
                    }
                })
                .and()
                .cors() // 启用CORS配置
                .and()
                .csrf().disable() // 禁用CSRF保护
                .httpBasic(); // 启用HTTP基本认证


    }

    /**
     * Specify encryption mode
     */
    @Bean
    public PasswordEncoder passwordEncoder(){
        // return new BCryptPasswordEncoder();

        return NoOpPasswordEncoder.getInstance();
    }

}


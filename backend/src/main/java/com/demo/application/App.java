package com.demo.application;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

//开启自动化配置（项目中添加了spring-boot-starter-web的依赖，在开启了自动化配置后
//会自动进行Spring和Spring MVC的配置
//以下两条注释等效于@Spring BootApplication
@SpringBootApplication
//创建项目的入口类
public class App {
    public static void main(String[] args) {
        SpringApplication.run(App.class, args);
    }
}



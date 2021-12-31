package com.example.pratice.test;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class Controller {
    @GetMapping("/")
    public String hello(){
        return "<h1>hello spring boot</h1>";
    }

}

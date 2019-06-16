package com.erebos.myapp.rest;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import static org.springframework.http.HttpStatus.OK;

@RestController
public class DefaultController {

    @GetMapping("/")
    public ResponseEntity<String> base() {
        return new ResponseEntity<>("Swagger documentation <a href=\"/swagger-ui.html\">here</a>", OK);
    }

    @GetMapping("/healthcheck")
    public ResponseEntity<String> healthcheck() {
        return new ResponseEntity<>("Hello, I'm alive!", OK);
    }
}

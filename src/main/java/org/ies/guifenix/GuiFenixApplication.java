package org.ies.guifenix;

import javafx.application.Application;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class GuiFenixApplication {

    public static void main(String[] args) {
        Application.launch(FxApplication.class, args);
    }

}

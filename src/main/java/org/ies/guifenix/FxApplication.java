package org.ies.guifenix;

import javafx.application.Application;
import javafx.stage.Stage;
import org.ies.guifenix.config.FxmlView;
import org.ies.guifenix.config.StageManager;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.context.ConfigurableApplicationContext;


public class FxApplication extends Application {


    private static Stage stage;

    private ConfigurableApplicationContext applicationContext;
    private StageManager stageManager;

    @Override
    public void init() {
        applicationContext = new SpringApplicationBuilder(GuiFenixApplication.class).run();
    }

    @Override
    public void stop() {
        applicationContext.close();
        stage.close();
    }

    @Override
    public void start(Stage primaryStage) {
        stage = primaryStage;
        stageManager = applicationContext.getBean(StageManager.class, primaryStage);
        showHomeScene();
    }

    private void showHomeScene() {
        stageManager.switchScene(FxmlView.HOME);
    }

}

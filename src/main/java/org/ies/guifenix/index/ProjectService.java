package org.ies.guifenix.index;

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.nio.file.Path;
import java.util.List;

@AllArgsConstructor
@Service
public class ProjectService {

    private final ProjectRepository projectRepository;

    public List<Project> getAllProjects() {
        return projectRepository.findAll();
    }
    public void saveProject(String projectName, String path) {
        Project newProject = new Project();
        newProject.setName(projectName);
        newProject.setDbPath(Path.of(path));
        projectRepository.save(newProject);
    }

    public void updateUser(Project projectUpdate) {
        projectRepository.save(projectUpdate);
    }

    public void deleteUse (Project project) {
        projectRepository.delete(project);
    }

}

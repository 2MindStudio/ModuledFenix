package org.ies.guifenix.index;

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@AllArgsConstructor
@Service
public class ProjectService {

    private final ProjectRepository projectRepository;

    public List<Project> getAllProjects() {
        return projectRepository.findAll();
    }
    public void saveProject(String projectName) {
        Project newProject = new Project();
        newProject.setName(projectName);
        projectRepository.save(newProject);
    }

    public void updateUser(Project projectUpdate) {
        projectRepository.save(projectUpdate);
    }

    public void deleteUse (Project project) {
        projectRepository.delete(project);
    }

}

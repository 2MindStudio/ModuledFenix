package org.ies.fornix.fenixserver.repositories;

import org.ies.fornix.fenixserver.models.Game;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface GameRepository extends JpaRepository<Game, Integer> {
    List<Game> findByTitleContainingIgnoreCase(String title);
    List<Game> findByDevId(Integer devId);
    List<Game> findByTagsId(Integer tagId);
}
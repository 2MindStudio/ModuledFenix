package org.ies.fornix.fenixserver.repositories;

import org.ies.fornix.fenixserver.models.Teaser;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TeaserRepository extends JpaRepository<Teaser, Integer> {
    List<Teaser> findByGameId(Integer gameId);
    List<Teaser> findByGameIdAndType(Integer gameId, String type);
}
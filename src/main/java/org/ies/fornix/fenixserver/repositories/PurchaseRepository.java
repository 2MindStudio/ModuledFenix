package org.ies.fornix.fenixserver.repositories;

import org.ies.fornix.fenixserver.models.Purchase;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PurchaseRepository extends JpaRepository<Purchase, Integer> {
    List<Purchase> findByClientId(Integer clientId);
    boolean existsByClientIdAndGameId(Integer clientId, Integer gameId);
}
package org.ies.fornix.fenixserver.repositories;

import org.ies.fornix.fenixserver.models.Wishlist;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface WishlistRepository extends JpaRepository<Wishlist, Integer> {
    List<Wishlist> findByClientId(Integer clientId);
    boolean existsByClientIdAndGameId(Integer clientId, Integer gameId);
}
package org.ies.fornix.fenixserver.dto.wishlist;

import lombok.Data;

@Data
public class WishlistCreateDTO {
    private Integer clientId;
    private Integer gameId;
}
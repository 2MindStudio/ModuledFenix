package org.ies.fornix.fenixserver.dto.purchase;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;

@Data
public class PurchaseResponseDTO {
    private Integer id;
    private LocalDate paymentDate;
    private Integer clientId;
    private Integer gameId;
    private String gameTitle;
    private BigDecimal price;
}
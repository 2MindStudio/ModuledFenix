package org.ies.fornix.fenixserver.dto.client;

import lombok.Data;

@Data
public class ClientRegisterDTO {
    private String username;
    private String nickname;
    private String email;
    private String password;
}
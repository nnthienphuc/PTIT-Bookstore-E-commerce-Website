package com.nnthienphuc.intelligentbookstoreecommercewebsite.model;

import lombok.*;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter

public class MailInfo {
    String from;
    String to;
    String cc;
    String bcc;
    String subject;
    String body;
    String files;
}
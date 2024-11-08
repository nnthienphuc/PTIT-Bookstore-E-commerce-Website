package com.nnthienphuc.intelligentbookstoreecommercewebsite.model;

import lombok.Getter;
import lombok.Setter;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
public class MailInfo {
    String from = "BooleanVape";
    String to;
    String[] cc;
    String[] bcc;
    String subject;
    String body;
    List<File> files = new ArrayList<>();

    public MailInfo(String to, String subject, String body) {
        this.to = to;
        this.subject = subject;
        this.body = body;
    }

    public MailInfo() {
    }
}
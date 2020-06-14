package com.example.CollegeNotes.MailClasses;

import javax.mail.MessagingException;

public interface MailServicesClass {
    public void send(String toAddress,String fromAddress,String subject,String content) throws MessagingException;
}

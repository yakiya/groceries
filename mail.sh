#!/usr/bin/python
# coding: UTF-8
# author: Walker
# e-mail: walkerIVI@gmail.com
# modify: 2016/04/25

import smtplib
import os
import datetime
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

class Mail():

    def Send(self, subject, content, _from, _to, _cc='', _bcc='', _file=''):
        msg = MIMEMultipart()
        msg['to'] = _to
        msg['cc'] = _cc
        msg['from'] = _from
        msg['subject'] = subject
        
        # HTML Content 
        msgcontent = MIMEText(content, 'html', 'utf-8')
        msg.attach(msgcontent)
        
        # Attachment
        if _file:
            fileList = _file.split(',')
            for n in fileList:
                attach = MIMEText(open(n, 'rb').read(), 'base64')
                attach['Content-Type'] = 'application/octet-stream'
                attach['Content-Disposition'] = 'attachment; filename="%s"'%(n)
                msg.attach(attach)

        _From = _from
        _To = []

        for i in _to.split(','): 
            _To.append(i)
        if _cc:
            for i in _cc.split(','): 
                _To.append(i)
        if _bcc:
            for i in _bcc.split(','):
                _To.append(i)

        # Send Mail
        try:
            server = smtplib.SMTP('10.180.5.108', 26)
            server.starttls()
            #server.login('b2','gaofushuai000!!$$')
            server.login('b4','45cjtHFS$')
            #server = smtplib.SMTP('127.0.0.1', 25)
            server.sendmail(_From, _To, msg.as_string())
            server.quit()
            print '%s - Send Mail success'%(datetime.datetime.today().strftime('%Y-%m-%d %H:%M:%S'))
        except Exception, e:
            print str(e)

if __name__ == '__main__':

    mail = Mail()
    subject = 'Test'
    content = 'This is a Test!!'
    _from = 'b4@iv66.net'
    _to = 'walker@iv66.net,walkerIVI@gmail.com'

    #mail.Send(subject, content, _from, _to, _file='FB.csv')
    mail.Send(subject, content, _from, _to)


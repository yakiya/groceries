#!/usr/bin/python
# coding: UTF-8
import zipfile
import smtplib
import os
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from datetime import datetime, timedelta, date
today = date.today()
receive = "xavi.m@"
class Mail():
    def Send(self, _to, _cc,_bcc, _from, _subject, content,_file):
        msg = MIMEMultipart()
        msg['to'] = _to
        msg['cc'] = _cc
        msg['bcc'] = _bcc
        msg['from'] = _from
        msg['subject'] = _subject

        msgcontent = MIMEText(content, 'html', 'utf-8')

        msg.attach(msgcontent)

        _From = _from
        _To = []
        for i in _to.split(','):
            _To.append(i)
        if _cc != '':
            for i in _cc.split(','):
                _To.append(i)
        _To.append(i)
        if _bcc != '':
            for i in _bcc.split(','):
                _To.append(i)
        _To.append(i)

        if _file:
            fileList = _file.split(',')
            for n in fileList:
                attach = MIMEText(open(n, 'rb').read(), 'base64','utf-8')
                attach['Content-Type'] = 'application/octet-stream'
                attach['Content-Disposition'] = 'attachment; filename="%s"' % (n)
                msg.attach(attach)

        try:
            server = smtplib.SMTP('127.0.0.1', 25)
            server.sendmail(_From, _To, msg.as_string())
            server.quit()
            print("Send Mail success!!")
        except Exception as e:
            print(str(e))

certwarn = open('/etc/xavi/A03/cert/fkd_warn.txt')
certwarn = certwarn.read()
print(type(certwarn))
print(certwarn)
if certwarn == '':
    print ("no overdate domains.")
else:
    certwarn= "<br />".join(certwarn.split("\n"))
    mail = Mail()
    file = ''
    subject = 'FKDB_域名证书到期通知'
    content = '''
        <font face="Arial" size="2" color="black">
        
            <br>
            {}
            <br>
            Best Regards,<br>
            <br>
            B2  <br>
            SA/部門/<br>
        </font>
        <font face="微软雅黑" size="2" color="gray">
        *******************************************************************************************************************************************<br>
        该邮件为机密文件，如您不是指定收件人，请将邮件删除。谢谢！<br>
        Notice: This transmittal or attachments may be confidential. If you are not the intended receipt, you are hereby notified that you have received this transmittal  in error; any review, dissemination or copy is strictly prohibited. If you have received this transmittal in error, please notify us immediately by reply and immediately delete this message and all its attachments. Thank you.<br>
        *******************************************************************************************************************************************<br>
        </front>'''.format(certwarn)
    mail.Send('{0}'.format(receive), 'better@', '','b4@',subject ,content ,file)


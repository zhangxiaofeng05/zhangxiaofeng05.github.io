# Spring Boot发送邮件


>本文环境
jdk 1.8
maven 3.6.1
Spring Boot 2.1.6

# 引入依赖
pom.xml
```
<dependency>
	<groupId>org.springframework.boot</groupId>
	<artifactId>spring-boot-starter-mail</artifactId>
</dependency>
```
# 在application.properties中添加邮件配置(以QQ邮箱为例)
```
spring.mail.host=smtp.qq.com
spring.mail.port=587
spring.mail.username=xxx@qq.com
spring.mail.password=授权码
spring.mail.properties.mail.smtp.auth=true
spring.mail.properties.mail.smtp.starttls.enable=true
spring.mail.properties.mail.smtp.starttls.required=true
spring.mail.default-encoding=UTF-8


mail.fromMail.addr=xxx@qq.com #发送来源，和账户相同
```
 - QQ邮箱的服务器端口  
接收邮件服务器：imap.qq.com，使用SSL，端口号993  
发送邮件服务器：smtp.qq.com，使用SSL，端口号465或587  
[QQ邮箱帮助中心](https://service.mail.qq.com/cgi-bin/help?subtype=1&&id=28&&no=331)

# 编写Service接口
```
public interface MailService {
	public void sendSimpleMail(String to,String subject,String content);
	
	public void sendHtmlMail(String to, String subject, String content);
	
	public void sendAttachmentsMail(String to, String subject, String content, String filePath);
}
}
```
# 编写Service的实现类
```
import java.io.File;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;


@Component
public class MailServiceImpl implements MailService{
	
	private final Logger logger =  LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Value("${mail.fromMail.addr}")
	private String from;

	@Override
	public void sendSimpleMail(String to, String subject, String content) {
		SimpleMailMessage message = new SimpleMailMessage();
		message.setFrom(from);
		message.setTo(to);
		message.setSubject(subject);
		message.setText(content);
		
		try {
			mailSender.send(message);
			logger.info("简单邮件已经发送");
		} catch (Exception e) {
			logger.error("发送简单邮件时发生异常!",e);
		}
	}
	
	@Override
	public void sendHtmlMail(String to, String subject, String content) {
		MimeMessage message = mailSender.createMimeMessage();

	    try {
	        //true表示需要创建一个multipart message
	        MimeMessageHelper helper = new MimeMessageHelper(message, true);
	        helper.setFrom(from);
	        helper.setTo(to);
	        helper.setSubject(subject);
	        helper.setText(content, true);

	        mailSender.send(message);
	        logger.info("html邮件发送成功");
	    } catch (MessagingException e) {
	        logger.error("发送html邮件时发生异常！", e);
	    }
	}
	
	@Override
	public void sendAttachmentsMail(String to, String subject, String content, String filePath) {
		MimeMessage message = mailSender.createMimeMessage();
		try {
	        MimeMessageHelper helper = new MimeMessageHelper(message, true);
	        helper.setFrom(from);
	        helper.setTo(to);
	        helper.setSubject(subject);
	        helper.setText(content, true);

	        FileSystemResource file = new FileSystemResource(new File(filePath));
	        String fileName = filePath.substring(filePath.lastIndexOf(File.separator));
	        helper.addAttachment(fileName, file);

	        mailSender.send(message);
	        logger.info("带附件的邮件已经发送。");
	    } catch (MessagingException e) {
	        logger.error("发送带附件的邮件时发生异常！", e);
	    }
	}

}
```
# 编写测试类
```
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import com.boot.service.MailService;
@RunWith(SpringRunner.class)
@SpringBootTest
public class MailTest {
	
	@Autowired
	private MailService mailService;
	
	@Test
	public void testSimple() {
		mailService.sendSimpleMail("xxx@163.com", "test simple mail", "hello this is simple mail");
	}
	
	@Test
	public void testHtmlMail() throws Exception {
	    String content="<html>\n" +
	            "<body>\n" +
	            "    <h3>hello world ! 这是一封Html邮件!</h3>\n" +
	            "</body>\n" +
	            "</html>";
	    mailService.sendHtmlMail("xxx@163.com","test simple mail",content);
	}
	
	@Test
	public void sendAttachmentsMail() {
	    String filePath="D:\\testMail.txt";
	    mailService.sendAttachmentsMail("xxx@163.com", "主题：带附件的邮件", "有附件，请查收！", filePath);
	}
}
```
至此，邮件发送成功!

# 参考
http://www.ityouknow.com/springboot/2017/05/06/spring-boot-mail.html

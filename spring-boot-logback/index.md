# Spring Boot打印日志


>本文环境
jdk 1.8
maven 3.6.1
Spring Boot 2.1.6

# SLF4J
## 为什么要介绍SLF4J？
SLF4J是一个接口，log4j和logback是它的实现。
SLF4J官网：https://www.slf4j.org
## 官网示例
 - 引入jar包
slf4j-api-1.7.26.jar
slf4j-simple-1.7.26.jar
 - 编写测试类(Java Project)
```
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class HelloWorld {
  public static void main(String[] args) {
    Logger logger = LoggerFactory.getLogger(HelloWorld.class);
    logger.info("Hello World");
  }
}
```
有什么问题，去官网查看示例！

# Spring Boot中使用日志(logback)
## 编写测试类
```
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@RunWith(SpringRunner.class)
@SpringBootTest
public class LogbackTest {
	//记录器
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Test
	public void logTest() {
		//日志的级别
		//从上到下---由低到高
		//日志会在设置的级别和高级别生效，Spring Boot默认info
		logger.trace("这是trace日志...");
		logger.debug("这是debug日志...");
		//可以在logback-spring.xml或者在application.xml配置日志级别
		logger.info("这是info日志...");
		logger.warn("这是warn日志...");
		logger.error("这是error日志...");
	}
}
```
## 设置日志的格式
 - resources/logback-spring.xml
```
<?xml version="1.0" encoding="UTF-8"?>
<configuration debug="false" scan="true" scanPeriod="60 seconds">
   
	<!--定义日志文件的存储地址 勿在 LogBack 的配置中使用相对路径 -->
	<!-- 
	<property name="LOG_PATH" value="/data/log/process/springboot-demo" />
	 -->
	<springProperty name="LOG_PATH" source="logging.path"  defaultValue="../logs" />
	<!-- 控制台输出 -->
	<appender name="STDOUT" class="ch.qos.logback.core.ConsoleAppender">
		<encoder class="ch.qos.logback.classic.encoder.PatternLayoutEncoder">
			<!--格式化输出：%d表示日期，%thread表示线程名，%-5level：级别从左显示5个字符宽度%msg：日志消息，%n是换行符 -->
			<pattern>%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger{50} - %msg%n</pattern>
		</encoder>
	</appender>
	
	<!-- 按照每天生成日志文件 -->
	<appender name="FILE" class="ch.qos.logback.core.rolling.RollingFileAppender">
		<rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
			<!--日志文件输出的文件名 -->
			<FileNamePattern>${LOG_PATH}/log.log.%d{yyyy-MM-dd}</FileNamePattern>
			<!--日志文件保留天数 -->
			<!-- <MaxHistory>30</MaxHistory> -->
		</rollingPolicy>
		<encoder class="ch.qos.logback.classic.encoder.PatternLayoutEncoder">
			<!--格式化输出：%d表示日期，%thread表示线程名，%-5level：级别从左显示5个字符宽度%msg：日志消息，%n是换行符 -->
			<pattern>%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger{50} - %msg%n</pattern>
		</encoder>
	</appender>

	<!-- 日志输出级别 -->
	<root level="INFO">
		<appender-ref ref="FILE" />
		<appender-ref ref="STDOUT" />
	</root>
</configuration>  
```
## 配置文件的加载顺序
application.properties或者application.yml文件作为Spring Boot的默认配置文件
 - file：.config/
 - file: ./
 - classpath: /config/
 - classpath: /
以上是按照`优先级从高到低`的顺序，所有位置的文件都会被加载，高优先级配置内容会覆盖低优先级配置内容
可以通过配置spring.config.location来改变默认配置

## application基本配置
```
#log
logging.config=classpath:logback-spring.xml
logging.path=D:/log
```
## 官网日志配置详情
https://docs.spring.io/spring-boot/docs/2.1.6.RELEASE/reference/html/boot-features-logging.html

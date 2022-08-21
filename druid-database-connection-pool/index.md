# Druid数据库连接池


阿里巴巴数据库事业部出品，为监控而生的数据库连接池。
托管于GitHub,项目地址
https://github.com/alibaba/druid
Druid是一个JDBC组件库，包括数据库连接池、SQL Parser等组件。DruidDataSource是最好的数据库连接池。
# Springboot使用
`最新信息去GitHub`
## Maven
```
<dependency>
   <groupId>com.alibaba</groupId>
   <artifactId>druid-spring-boot-starter</artifactId>
   <version>1.1.17</version>
</dependency>
```
## Gradle
```
compile 'com.alibaba:druid-spring-boot-starter:1.1.17'
```
# 配置
Github上有说明，下面是一下常用配置
application.properties
```
#mysql
spring.datasource.platform=mysql
spring.datasource.url=jdbc:mysql://localhost:3306/database?serverTimezone=GMT%2B8&useUnicode=true&characterEncoding=utf8
spring.datasource.username=root
spring.datasource.password=154704
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
#druid
spring.datasource.type=com.alibaba.druid.pool.DruidDataSource
# Advanced configuration...
spring.datasource.max-active=500
spring.datasource.min-idle=2
spring.datasource.initial-size=6
```

# 开启监测
DruidConfiguration
监测地址：http://localhost:8080/druid/index.html
```
import javax.sql.DataSource;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.alibaba.druid.pool.DruidDataSource;
import com.alibaba.druid.support.http.StatViewServlet;

@Configuration
public class DruidConfiguration {

	@ConfigurationProperties("spring.datasource")
	@Bean
	public DataSource druidDataSource() {
		return new DruidDataSource();
	}
	
	 @Bean
	 public ServletRegistrationBean<StatViewServlet> druidStatViewServlet() {
	  ServletRegistrationBean<StatViewServlet> registrationBean = new ServletRegistrationBean<>(new StatViewServlet(),  "/druid/*");
	  registrationBean.addInitParameter("allow", "127.0.0.1");// IP白名单 (没有配置或者为空，则允许所有访问)
	  registrationBean.addInitParameter("deny", "");// IP黑名单 (存在共同时，deny优先于allow)
	  registrationBean.addInitParameter("loginUsername", "root");
	  registrationBean.addInitParameter("loginPassword", "123456");
	  registrationBean.addInitParameter("resetEnable", "false");
	  return registrationBean;
	 }
}
```

# 测试类
```
import java.sql.Connection;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@RunWith(SpringRunner.class)
@SpringBootTest
public class SpringbootApplicationTests {

	@Autowired
	DataSource dataSource;
	
	@Test
	public void contextLoads() {
	}
	
	@Test
	public void test1() throws Exception {
		System.out.println(dataSource.getClass());
		Connection connection = dataSource.getConnection();
		System.out.println(connection.getClass());
		connection.close();
	}

}
```

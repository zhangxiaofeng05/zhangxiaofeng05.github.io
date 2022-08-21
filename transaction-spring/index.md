# 数据库隔离级别和传播行为


# 事务五个隔离级别

 - DEFAULT 

使用数据库设置的隔离级别 ( 默认 ) ，由 DBA 默认的设置来决定隔离级别 .

 - READ_UNCOMMITTED 

会出现脏读、不可重复读、幻读 ( 隔离级别最低，并发性能高 )

 - READ_COMMITTED  
 
会出现不可重复读、幻读问题（锁定正在读取的行）

 - REPEATABLE_READ

会出幻读（锁定所读取的所有行）

 - SERIALIZABLE 
 
保证所有的情况不会发生（锁表）

# spring中七个事务传播行为
在TransactionDefinition接口中定义了七个事务传播行为。

 - PROPAGATION_REQUIRED(默认的spring事务传播级别)
 
如果存在一个事务，则支持当前事务。如果没有事务则开启一个新的事务。

 - PROPAGATION_SUPPORTS 

如果存在一个事务，支持当前事务。如果没有事务，则非事务的执行。但是对于事务同步的事务管理器，PROPAGATION_SUPPORTS与不使用事务有少许不同。

 - PROPAGATION_MANDATORY
 
如果已经存在一个事务，支持当前事务。如果没有一个活动的事务，则抛出异常。

 - PROPAGATION_REQUIRES_NEW
 
总是开启一个新的事务。如果一个事务已经存在，则将这个存在的事务挂起。

 - PROPAGATION_NOT_SUPPORTED

总是非事务地执行，并挂起任何存在的事务。
 
 - PROPAGATION_NEVER 

总是非事务地执行，如果存在一个活动事务，则抛出异常

 - PROPAGATION_NESTED

如果一个活动的事务存在，则运行在一个嵌套的事务中. 如果没有活动事务, 则按TransactionDefinition.PROPAGATION_REQUIRED 属性执行 

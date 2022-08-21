# 悲观锁和乐观锁


悲观锁和乐观锁：处理的是同一张表的同一行记录
# 悲观锁
`如果使用了(加了一个行锁)，如果事务没有被释放，就会造成其他事务处于等待。`

使用数据库提供的锁机制实现悲观锁。

如果数据库不支持设置的锁机制，JPA会使用该数据库提供的合适的锁机制来完成，而不会报错。

使用entityManage.find(class,id,LockModeType);加悲观锁，相当于发送SELECT ... FOR UPDATE

使用entityManage.lock(object,LockModeType);加悲观锁，相当于发送SELECT id FROM ... FOR UPDATE

# 乐观锁(性能好)
添加一个私有字段version，不由程序员维护，由JPA自己维护
```
@Version
private long version;
```

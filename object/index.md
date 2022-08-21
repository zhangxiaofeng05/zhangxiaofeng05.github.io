# Object类


# 特点
   1. 是Java中唯一一个没有父类的类
   2. java中所有的类不是object类的直接子类，就是其间接子类
   3. 定义在object类中的所有方法，在任何类中都可以直接调用，而不需要声明object类的对象。
   4. 是java中所有类的超类（基类 ，父类）
   5. object类中只有无参构造

# 方法 
 - 常用方法
  1. public boolean equals（object obj）
```
public boolean equals(Object obj) {
        return (this == obj);
    }
```
指示其他某个对象是否与此对象“相等”。
(ps:==判断是否引用地址相同)
  2. public String tostring（)  
返回对象的字符串表示形式。 
  3. public int hashCode()  
返回此对象的一个哈希码值。

---
 - 不常用方法
 1. protected Object clone()  
创建并返回此对象的一个副本。
 2. protected void finalize()  
当垃圾回收器确定不存在对该对象的更多引用时，由对象的垃圾回收器调用此方法。子类重写 finalize 方法，以配置系统资源或执行其他清除。 
 3. public final Class<?> getClass()  
返回此 Object 的运行时类。
 4. public final void notify()  
唤醒在此对象监视器上等待的单个线程。
 5. public final void notifyAll()  
唤醒在此对象监视器上等待的所有线程。
 6. public final void wait()  
在其他线程调用此对象的 notify() 方法或 notifyAll() 方法前，导致当前线程等待。
 7. public final void wait(long timeout)  
在其他线程调用此对象的 notify() 方法或 notifyAll() 方法，或者超过指定的时间量前，导致当前线程等待。
 8. public final void wait(long timeout,int nanos)  
在其他线程调用此对象的 notify() 方法或 notifyAll() 方法，或者其他某个线程中断当前线程，或者已超过某个实际时间量前，导致当前线程等待。

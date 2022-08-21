# Java中的线程


# 进程和线程概念
`进程`(Process)是计算机中的程序关于某数据集合上的一次运行活动，是系统进行资源分配和调度的基本单位，是操作系统结构的基础。进程是线程的容器。

`线程`(thread)是操作系统能够进行运算调度的最小单位。它被包含在进程之中，是进程中的实际运作单位。一个进程中可以并发多个线程，每条线程并行执行不同的任务。

同一进程中的多条线程将共享该进程中的全部系统资源，如虚拟地址空间，文件描述符和信号处理等等。但同一进程中的多个线程有各自的调用栈（call stack），自己的寄存器环境（register context），自己的线程本地存储（thread-local storage）。
一个进程可以有很多线程，每条线程并行执行不同的任务。

# 线程
在 Java程序中，有两种方法创建线程：
一继承Thread重写run方法
二是通过实现Runnable接口，实现run方法

线程总体分两类：用户线程和守候线程。
当所有用户线程执行完毕的时候，JVM自动关闭。但是守候线程却不独立于JVM，守候线程一般是由操作系统或者用户自己创建的。

## 继承Thread
```
public class ThreadOne extends Thread{

    private String name;

    public ThreadOne() {
    }

    public ThreadOne(String name) {
        this.name = name;
    }

    @Override
    public void run() {
        for(int i=1;i<=10;i++){
            System.out.println(name+"----"+i);
        }
    }
}

```
```
public class ThreadTest {

    public static void main(String[] args) {
        ThreadOne threadOne1 = new ThreadOne("地瓜");
        ThreadOne threadOne2 = new ThreadOne("土豆");
        threadOne1.start();
        threadOne2.start();
    }
}

```
## 实现Runnable接口
```
public class ThreadTwo implements Runnable {

    private String name;

    public ThreadTwo() {
    }

    public ThreadTwo(String name) {
        this.name = name;
    }

    @Override
    public void run() {
        for(int i=1;i<=10;i++){
            System.out.println(name+"-------"+i);
        }
    }
}

```
```
public class ThreadTest {

    public static void main(String[] args) {
        Thread t1 = new Thread(new ThreadTwo("地瓜"));
        Thread t2 = new Thread(new ThreadTwo("土豆"));
        t1.start();
        t2.start();
    }
}

```
# 线程的转换
![](/mypng/1.png)
新建状态：线程对象已经创建
就绪状态：执行了start
运行状态：线程调度程序从可运行池中选择一个线程作为当前线程时线程所处的状态。这也是线程进入运行状态的唯一一种方式。
阻塞：线程仍旧是活的，但是当前没有条件运行。
死亡态：当线程的run()方法完成时就认为它死去。这个线程对象也许是活的，但是，它已经不是一个单独执行的线程。线程一旦死亡，就不能复生。如果在一个死去的线程上调用start()方法，会抛出java.lang.IllegalThreadStateException异常。


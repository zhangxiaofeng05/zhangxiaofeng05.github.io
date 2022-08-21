# 创建型模式-单例模式


# 维基百科
## 单例模式
单例模式，也叫单子模式，是一种常用的软件设计模式。在应用这个模式时，单例对象的类必须保证只有一个实例存在。许多时候整个系统只需要拥有一个的全局对象，这样有利于我们协调系统整体的行为。比如在某个服务器程序中，该服务器的配置信息存放在一个文件中，这些配置数据由一个单例对象统一读取，然后服务进程中的其他对象再通过这个单例对象获取这些配置信息。这种方式简化了在复杂环境下的配置管理。

实现单例模式的思路是：一个类能返回对象一个引用(永远是同一个)和一个获得该实例的方法（必须是静态方法，通常使用getInstance这个名称）；当我们调用这个方法时，如果类持有的引用不为空就返回这个引用，如果类保持的引用为空就创建该类的实例并将实例的引用赋予该类保持的引用；同时我们还将该类的构造函数定义为私有方法，这样其他处的代码就无法通过调用该类的构造函数来实例化该类的对象，只有通过该类提供的静态方法来得到该类的唯一实例。

单例模式在多线程的应用场合下必须小心使用。如果当唯一实例尚未创建时，有两个线程同时调用创建方法，那么它们同时没有检测到唯一实例的存在，从而同时各自创建了一个实例，这样就有两个实例被构造出来，从而违反了单例模式中实例唯一的原则。 解决这个问题的办法是为指示类是否已经实例化的变量提供一个互斥锁(虽然这样会降低效率)。

## 构建方式
通常单例模式在Java语言中，有两种构建方式：
 - 懒汉方式。指全局的单例实例在第一次被使用时构建。
 - 饿汉方式。指全局的单例实例在类装载时构建。

## Java
在Java语言中，单例模式(饿汉模式)应用的例子如下述代码所示：
```
public class Singleton {
  private static final Singleton INSTANCE = new Singleton();

  // Private constructor suppresses
  // default public constructor
  private Singleton() {};

  public static Singleton getInstance() {
      return INSTANCE;
  }
}
```
在Java编程语言中，单例模式(懒汉模式)应用的例子如下述代码所示 (此种方法只能用在JDK5及以后版本(注意 INSTANCE 被声明为 volatile)，之前的版本使用“双重检查锁”会发生非预期行为)：
```
public class Singleton {
    private static volatile Singleton INSTANCE = null;

    // Private constructor suppresses
    // default public constructor
    private Singleton() {};

    //Thread safe and performance  promote
    public static  Singleton getInstance() {
        if(INSTANCE == null){
             synchronized(Singleton.class){
                 // When more than two threads run into the first null check same time,
                 // to avoid instanced more than one time, it needs to be checked again.
                 if(INSTANCE == null){
                     INSTANCE = new Singleton();
                  }
              }
        }
        return INSTANCE;
    }
}
```

# 例子
Singleton
```
public class Singleton {
    private static Singleton sing;

    public Singleton() {
    }

    public static Singleton getInstance(){
        if(sing==null){
            sing=new Singleton();
        }
        return sing;
    }
}
```
Test
```
public class Test {
    public static void main(String[] args) {
        Singleton s1=Singleton.getInstance();
        Singleton s2=Singleton.getInstance();

        System.out.println(s1);
        System.out.println(s2);
    }
}
```
运行结果：
```
Singleton@677327b6
Singleton@677327b6
```


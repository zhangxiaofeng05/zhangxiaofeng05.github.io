# 结构型模式-代理模式


# 维基百科
## 代理模式
代理模式（英语：Proxy Pattern）是程序设计中的一种设计模式。

所谓的代理者是指一个类别可以作为其它东西的接口。代理者可以作任何东西的接口：网络连接、存储器中的大对象、文件或其它昂贵或无法复制的资源。

著名的代理模式例子为引用计数（英语：reference counting）指针对象。

当一个复杂对象的多份副本须存在时，代理模式可以结合享元模式以减少存储器用量。典型作法是创建一个复杂对象及多个代理者，每个代理者会引用到原本的复杂对象。而作用在代理者的运算会转送到原本对象。一旦所有的代理者都不存在时，复杂对象会被移除。

## Java
以下Java示例解释"虚拟代理"模式。ProxyImage 类别用来访问远程方法。
```
import java.util.*;

interface Image {
    public void displayImage();
}

//on System A
class RealImage implements Image {
    private String filename;
    public RealImage(String filename) {
        this.filename = filename;
        loadImageFromDisk();
    }

    private void loadImageFromDisk() {
        System.out.println("Loading   " + filename);
    }

    public void displayImage() {
        System.out.println("Displaying " + filename);
    }
}

//on System B
class ProxyImage implements Image {
    private String filename;
    private Image image;

    public ProxyImage(String filename) {
        this.filename = filename;
    }
    public void displayImage() {
        if(image == null)
              image = new RealImage(filename);
        image.displayImage();
    }
}

class ProxyExample {
    public static void main(String[] args) {
        Image image1 = new ProxyImage("HiRes_10MB_Photo1");
        Image image2 = new ProxyImage("HiRes_10MB_Photo2");     

        image1.displayImage(); // loading necessary
        image2.displayImage(); // loading necessary
    }
}
```
程序的输出为：
```
Loading    HiRes_10MB_Photo1
Displaying HiRes_10MB_Photo1
Loading    HiRes_10MB_Photo2
Displaying HiRes_10MB_Photo2
```

# 例子
接口
```
public interface Object {
    void action();
}
```
接口的实现类
```
public class ObjectImpl implements Object {
    @Override
    public void action() {
        System.out.println("===========");
        System.out.println("这是被代理的类");
        System.out.println("===========");
    }
}
```
代理类
```
public class ProxyObject implements Object{
    Object obj;

    public ProxyObject(){
        System.out.println("这是代理类");
        obj = new ObjectImpl();
    }

    @Override
    public void action() {
        System.out.println("代理开始");
        obj.action();
        System.out.println("代理结束");
    }
}
```
Test
```
public class Test {
    public static void main(String[] args) {
        Object obj = new ProxyObject();
        obj.action();
    }
}
```
运行结果：
```
这是代理类
代理开始
===========
这是被代理的类
===========
代理结束
```


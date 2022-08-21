# 结构型模式-适配器模式


# 维基百科
## 适配器模式
在设计模式中，适配器模式（英语：adapter pattern）有时候也称包装样式或者包装(wrapper)。将一个类的接口转接成用户所期待的。一个适配使得因接口不兼容而不能在一起工作的类能在一起工作，做法是将类自己的接口包裹在一个已存在的类中。

## 结构
有两种类型的适配器模式：

 - 对象适配器模式

在这种适配器模式中，适配器容纳一个它包裹的类的实例。在这种情况下，适配器调用被包裹对象的物理实体。

 - 类适配器模式

这种适配器模式下，适配器继承自已实现的类（一般多重继承）。

# 例子
 - Target

定义Client使用的与特定领域相关的接口。

```
public interface Target {
    void adapteeMethod();
    void adapterMethod();
}
```

 - Adaptee

定义一个已经存在的接口，这个接口需要适配。

```
public class Adaptee {
    public void adapteeMethod(){
        System.out.println("Adaptee method");
    }
}
```

 - Adapter

对Adaptee的接口与Target接口进行适配

```
public class Adapter implements Target{

    private Adaptee adaptee;

    public Adapter(Adaptee adaptee){
        this.adaptee=adaptee;
    }

    @Override
    public void adapteeMethod() {
        adaptee.adapteeMethod();
    }

    @Override
    public void adapterMethod() {
        System.out.println("Adapter method");
    }
}
```

 - Client

与符合Target接口的对象协同。

```
public class Test {
    public static void main(String[] args) {
        Target target = new Adapter(new Adaptee());
        target.adapteeMethod();
        target.adapterMethod();
    }
}
```

运行结果：
```
Adaptee method
Adapter method
```


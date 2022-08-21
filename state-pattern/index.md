# 行为型模式-状态模式


# 百度百科
## 状态模式
(State Pattern)是设计模式的一种，属于行为模式。
允许一个对象在其内部状态改变时改变它的行为。对象看起来似乎修改了它的类
## 定义
(源于Design Pattern)：当一个对象的内在状态改变时允许改变其行为，这个对象看起来像是改变了其类。

状态模式主要解决的是当控制一个对象状态的条件表达式过于复杂时的情况。把状态的判断逻辑转移到表示不同状态的一系列类中，可以把复杂的判断逻辑简化。
## 意图
允许一个对象在其内部状态改变时改变它的行为
## 适用场景

 1. 一个对象的行为取决于它的状态，并且它必须在运行时刻根据状态改变它的行为。
 2. 一个操作中含有庞大的多分支结构，并且这些分支决定于对象的状态。

# 例子
State
定义一个接口以封装与Context的一个特定状态相关的行为。
```
public interface Weather {
    String getWeather();
}
```
Context
定义客户感兴趣的接口。
维护一个ConcreteState子类的实例，这个实例定义当前状态。
```
public class Context {
    private Weather weather;

    public Weather getWeather() {
        return weather;
    }

    public void setWeather(Weather weather) {
        this.weather = weather;
    }

    public String weatherMessage(){
        return weather.getWeather();
    }
}
```
ConcreteStatesubclasses
每一子类实现一个与Context的一个状态相关的行为。
```
public class Rain implements Weather {
    @Override
    public String getWeather() {
        return "下雨";
    }
}
```
```
public class Sunshine implements Weather {
    @Override
    public String getWeather() {
        return "阳光";
    }
}
```
Test
```
public class Test {
    public static void main(String[] args) {
        Context ctx1 = new Context();
        ctx1.setWeather(new Sunshine());
        System.out.println(ctx1.weatherMessage());

        System.out.println("=================");

        Context ctx2 = new Context();
        ctx2.setWeather(new Rain());
        System.out.println(ctx2.weatherMessage());
    }
}
```
运行结果：
```
阳光
=================
下雨
```


# 行为型模式-观察者模式


# 维基百科
## 观察者模式
观察者模式是软件设计模式的一种。在此种模式中，一个目标对象管理所有相依于它的观察者对象，并且在它本身的状态改变时主动发出通知。这通常透过呼叫各观察者所提供的方法来实现。此种模式通常被用来实时事件处理系统。

## 参与类别
参与本模式的各类别列出如下。成员函式以模拟的方式列出。

**抽象目标类别**

此抽象类别提供一个界面让观察者进行添附与解附作业。此类别内有个不公开的观察者串炼，并透过下列函式(方法)进行作业

 - 添附(Attach)：新增观察者到串炼内，以追踪目标对象的变化。
 - 解附(Detach)：将已经存在的观察者从串炼中移除。
 - 通知(Notify)：利用观察者所提供的更新函式来通知此目标已经产生变化。

添附函式包涵了一个观察者对象参数。也许是观察者类别的虚拟函式(即更新函式)，或是在非面向对象的设定中所使用的函式指标(更广泛来讲，函式子或是函式对象)。

**目标类别**

此类别提供了观察者欲追踪的状态。也利用其源类别(例如前述的抽象目标类别)所提供的方法,来通知所有的观察者其状态已经更新。此类别拥有以下函式

 - 取得状态(GetState)：回传该目标对象的状态。

**抽象观察者界面**

抽象观察者类别是一个必须被实做的抽象类别。这个类别定义了所有观察者都拥有的更新用界面，此界面是用来接收目标类别所发出的更新通知。此类别含有以下函式

 - 更新(Update)：会被实做的一个抽象(虚拟)函式。

**观察者类别**

这个类别含有指向目标类别的参考(reference)，以接收来自目标类别的更新状态。此类别含有以下函式

 - 更新(Update)：是前述抽象函式的实做。当这个函式被目标对象呼叫时，观察者对象将会呼叫目标对象的取得状态函式，来其所拥有的更新目标对象资讯。

每个观察者类别都要实做它自己的更新函式，以应对状态更新的情形。

当目标对象改变时，会通过呼叫它自己的通知函式来将通知送给每一个观察者对象，这个通知函式则会去呼叫已经添附在串炼内的观察者更新函式。通知与更新函式可能会有一些参数，好指明是目前目标对象内的何种改变。这么作将可增进观察者的效率(只更新那些改变部分的状态)。

## 用途
 - 当抽象个体有两个互相依赖的层面时。封装这些层面在单独的对象内将可允许程序员单独地去变更与重复使用这些对象，而不会产生两者之间交互的问题。
 - 当其中一个对象的变更会影响其他对象，却又不知道多少对象必须被同时变更时。
 - 当对象应该有能力通知其他对象，又不应该知道其他对象的实做细节时。

观察者模式通常与 MVC 范式有关系。在 MVC 中，观察者模式被用来降低 model 与 view 的耦合程度。一般而言， model 的改变会触发通知其他身为观察者的 model 。而这些 model 实际上是 view 。 Java Swing 就是个范例，示意了 model 预期会透过 PropertyChangeNotification 架构以送出改变的通知给其他 view 。 Model 类别是 Java bean 类别的一员，并拥有与上述目标类别同样的行为。 View 类别则系结了一些 GUI 中的可视元素，并拥有与上述观察者类别同样的行为。当应用程序在执行时。使用者将因 view 做出相应的更新而看见 model 所产生的变更。

# 例子
Subject（目标）
目标知道它的观察者。可以有任意多个观察者观察同一个目标。
提供注册和删除观察者对象的接口。
```
import java.util.ArrayList;
import java.util.List;

public abstract class Citizen {
    List pols;
    private String help = "normal";

    public String getHelp() {
        return help;
    }

    public void setHelp(String help) {
        this.help = help;
    }
    abstract void sendMessage(String help);

    public void setPoliceman(){
        this.pols = new ArrayList();
    }
    public void register(Policeman pol){
        this.pols.add(pol);
    }
    public void unRegister(Policeman pol){
        this.pols.remove(pol);
    }
}
```
Observer（观察者）
为那些在目标发生改变时需获得通知的对象定义一个更新接口。
```
public interface Policeman {
    void action(Citizen ci);
}
```
ConcreteSubject（具体目标）
将有关状态存入各ConcreteObserver对象。
当它的状态发生改变时,向它的各个观察者发出通知。
```
public class HuangPuCitizen extends Citizen {
    public HuangPuCitizen(Policeman pol){
        setPoliceman();
        register(pol);
    }

    @Override
    void sendMessage(String help) {
        setHelp(help);
        for(int i=0;i<pols.size();i++){
            Policeman pol = (Policeman) pols.get(i);
            //通知警察行动
            pol.action(this);
        }
    }
}
```
```
public class TianHeCitizen extends Citizen {
    public TianHeCitizen(Policeman pol){
        setPoliceman();
        register(pol);
    }

    @Override
    void sendMessage(String help) {
        setHelp(help);
        for(int i=0;i<pols.size();i++){
            Policeman pol = (Policeman) pols.get(i);
            //通知警察行动
            pol.action(this);
        }
    }
}
```
ConcreteObserver（具体观察者）
维护一个指向ConcreteSubject对象的引用。
存储有关状态，这些状态应与目标的状态保持一致。
实现Observer的更新接口并使自身状态与目标的状态保持一致
```
public class HuangPuPoliceman implements Policeman {
    @Override
    public void action(Citizen ci) {
        String help = ci.getHelp();
        if (help.equals("normal")){
            System.out.println("一切正常，不用出动");
        }
        if(help.equals("unnormal")){
            System.out.println("有犯罪行为，黄埔警察出动");
        }
    }
}
```
```
public class TianHePoliceman implements Policeman {
    @Override
    public void action(Citizen ci) {
        String help = ci.getHelp();
        if (help.equals("normal")){
            System.out.println("一切正常，不用出动");
        }
        if(help.equals("unnormal")){
            System.out.println("有犯罪行为，天河警察出动");
        }
    }
}
```
Test
```
public class Test {
    public static void main(String[] args) {
        Policeman hpPol = new HuangPuPoliceman();
        Policeman thPol = new TianHePoliceman();

        Citizen citizen = new HuangPuCitizen(hpPol);
        citizen.sendMessage("unnormal");
        citizen.sendMessage("normal");
        System.out.println("======================");
        Citizen citizen1 = new TianHeCitizen(thPol);
        citizen1.sendMessage("normal");
        citizen1.sendMessage("unnormal");
    }
}
```
运行结果：
```
有犯罪行为，黄埔警察出动
一切正常，不用出动
======================
一切正常，不用出动
有犯罪行为，天河警察出动
```


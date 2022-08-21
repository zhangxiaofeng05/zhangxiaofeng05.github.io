# 行为型模式-备忘录模式


# 百度百科
## 备忘录模式
备忘录模式是一种软件设计模式：在不破坏封闭的前提下，捕获一个对象的内部状态，并在该对象之外保存这个状态。这样以后就可将该对象恢复到原先保存的状态。

## 基本介绍
备忘录模式（Memento Pattern）又叫做快照模式（Snapshot Pattern）或Token模式，是GoF的23种设计模式之一，属于行为模式。

`定义`：在不破坏封闭的前提下，捕获一个对象的内部状态，并在该对象之外保存这个状态。这样以后就可将该对象恢复到原先保存的状态。

`涉及角色：`

 1. Originator(发起人)：负责创建一个备忘录Memento，用以记录当前时刻自身的内部状态，并可使用备忘录恢复内部状态。Originator可以根据需要决定Memento存储自己的哪些内部状态。
 2. Memento(备忘录)：负责存储Originator对象的内部状态，并可以防止Originator以外的其他对象访问备忘录。备忘录有两个接口：Caretaker只能看到备忘录的窄接口，他只能将备忘录传递给其他对象。Originator却可看到备忘录的宽接口，允许它访问返回到先前状态所需要的所有数据。
 3. Caretaker(管理者):负责备忘录Memento，不能对Memento的内容进行访问或者操作。

`备忘录模式的优点和缺点`

 一、 备忘录模式的优点
  1. 有时一些发起人对象的内部信息必须保存在发起人对象以外的地方，但是必须要由发起人对象自己读取，这时，
使用备忘录模式可以把复杂的发起人内部信息对其他的对象屏蔽起来，从而可以恰当地保持封装的边界。
  2. 本模式简化了发起人类。发起人不再需要管理和保存其内部状态的一个个版本，客户端可以自行管理他们所需
要的这些状态的版本。

 二、 备忘录模式的缺点：
  1. 如果发起人角色的状态需要完整地存储到备忘录对象中，那么在资源消耗上面备忘录对象会很昂贵。
  2. 当负责人角色将一个备忘录 存储起来的时候，负责人可能并不知道这个状态会占用多大的存储空间，从而无法提醒用户一个操作是否很昂贵。
  3. 当发起人角色的状态改变的时候，有可能这个协议无效。如果状态改变的成功率不高的话，不如采取“假如”协议模式。

# 例子
Memento
备忘录存储原发器对象的内部状态。
```
public class Memento {
    private String state;

    public Memento(String state) {
        this.state = state;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }
}
```

Originator
原发器创建一个备忘录,用以记录当前时刻的内部状态。
使用备忘录恢复内部状态
```
public class Originator {
    private String state;

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public Memento createMemento(){
        return new Memento(state);
    }
    public void setMemento(Memento memento){
        state=memento.getState();
    }
    public void showState(){
        System.out.println(state);
    }
}
```

Caretaker
负责保存好备忘录。
不能对备忘录的内部进行操作或检查。
```
public class Caretaker {
    private Memento memento;

    public Memento getMemento() {
        return memento;
    }

    public void setMemento(Memento memento) {
        this.memento = memento;
    }
}
```

Test
```
public class Test {
    public static void main(String[] args) {
        Originator org = new Originator();
        org.setState("开会中");

        Caretaker ctk = new Caretaker();
        ctk.setMemento(org.createMemento());//将数据封装在Caretaker

        org.setState("睡觉中");
        org.showState();

        org.setMemento(ctk.getMemento());
        org.showState();
    }
}
```

运行结果
```
睡觉中
开会中
```

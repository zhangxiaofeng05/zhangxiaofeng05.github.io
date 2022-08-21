# 行为型模式-中介者模式


# 维基百科
## 中介者模式
在软件工程领域，中介者模式定义了一个中介者对象，该对象封装了系统中对象间的交互方式。 由于它可以在运行时改变程序的行为，这种模式是一种行为型模式 。

通常程序由大量的类组成，这些类中包含程序的逻辑和运算。 然而，当开发者将更多的类加入到程序中之后，类间交互关系可能变得更为复杂，这会使得代码变得更加难以阅读和维护，尤其是在重构的时候。 此外，程序将会变得难以修改，因为对其所做的任何修改都有可能影响到其它几个类中的代码。

在中介者模式中，对象间的通信过程被封装在一个中介者（调解人）对象之中。 对象之间不再直接交互，而是通过调解人进行交互。 这么做可以减少可交互对象间的依赖，从而降低耦合。

## 概述
中介者模式是23个周知模式（ 即GoF设计模式）中的一个，GoF设计模式旨在提供重复出现的设计问题的解决方案，以编写灵活和可复用的面向对象软件。也就是说，使对象更加易于实现、修改、测试和复用。

`中介者设计模式可以解决什么问题？`

 - 避免一组相互交互的对象之间出现紧耦合。
 - 能够独立地改变一组对象之间的交互关系而不影响其他对象。

使用直接逐个访问并更新彼此的方式进行对象间的交互灵活性低，因为这种方式使对象彼此间紧密耦合，导致不可能单独修改类间交互关系本身，而不影响关系中进行交互的类。并且这种方式会令对象变得无法复用，并且难以测试。

由于紧耦合的对象过多了解其他对象的内部细节，这种对象难以实现、修改、测试以及复用。

`中介者模式如何解决上述问题？`

 - 定义一个独立的中介者(调解员)的对象，封装一组对象之间的交互关系。
 - 对象将自己的交互委托给中介者执行，避免直接与其他对象进行交互。

对象利用中介者对象与其他对象进行间接交互，中介者对象负责控制和协调交互关系，这么做可使得对象间松耦合。这些对象只访问中介者，不了解其他对象的细节。

## 定义
中介者模式是为了“定义一个封装了对象间交互关系的对象”。这种方式避免了显式调用其他类，促进了类间的松耦合，并且使得类间交互关系本身可以单独修改。客户类可以使用中介者向其他客户类发送信息，并且通过中介者引发的事件收到信息。

## Java
在以下示例中，一个中介者对象控制了三个互相交互的按钮的状态，为此它有设置状态的三个方法：book(), view() 和 search()。 当相应的按钮被激活时，对应的方法通过execute()方法被调用。

于是这里在交互中每个交互的参与者（本例中即按钮）将自己的行为提交给中介者并且由中介者将这些行为转给对应的参与者。
```
import java.awt.Font;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;

//Colleague interface
interface Command {
    void execute();
}

//Abstract Mediator
interface Mediator {
    void book();
    void view();
    void search();
    void registerView(BtnView v);
    void registerSearch(BtnSearch s);
    void registerBook(BtnBook b);
    void registerDisplay(LblDisplay d);
}

//Concrete mediator
class ParticipantMediator implements Mediator {

    BtnView btnView;
    BtnSearch btnSearch;
    BtnBook btnBook;
    LblDisplay show;

    //....
    public void registerView(BtnView v) {
        btnView = v;
    }

    public void registerSearch(BtnSearch s) {
        btnSearch = s;
    }

    public void registerBook(BtnBook b) {
        btnBook = b;
    }

    public void registerDisplay(LblDisplay d) {
        show = d;
    }

    public void book() {
        btnBook.setEnabled(false);
        btnView.setEnabled(true);
        btnSearch.setEnabled(true);
        show.setText("booking...");
    }

    public void view() {
        btnView.setEnabled(false);
        btnSearch.setEnabled(true);
        btnBook.setEnabled(true);
        show.setText("viewing...");
    }

    public void search() {
        btnSearch.setEnabled(false);
        btnView.setEnabled(true);
        btnBook.setEnabled(true);
        show.setText("searching...");
    }

}

//A concrete colleague
class BtnView extends JButton implements Command {

    Mediator med;

    BtnView(ActionListener al, Mediator m) {
        super("View");
        addActionListener(al);
        med = m;
        med.registerView(this);
    }

    public void execute() {
        med.view();
    }

}

//A concrete colleague
class BtnSearch extends JButton implements Command {

    Mediator med;

    BtnSearch(ActionListener al, Mediator m) {
        super("Search");
        addActionListener(al);
        med = m;
        med.registerSearch(this);
    }

    public void execute() {
        med.search();
    }

}

//A concrete colleague
class BtnBook extends JButton implements Command {

    Mediator med;

    BtnBook(ActionListener al, Mediator m) {
        super("Book");
        addActionListener(al);
        med = m;
        med.registerBook(this);
    }

    public void execute() {
        med.book();
    }

}

class LblDisplay extends JLabel {

    Mediator med;

    LblDisplay(Mediator m) {
        super("Just start...");
        med = m;
        med.registerDisplay(this);
        setFont(new Font("Arial", Font.BOLD, 24));
    }

}

class MediatorDemo extends JFrame implements ActionListener {

    Mediator med = new ParticipantMediator();

    MediatorDemo() {
        JPanel p = new JPanel();
        p.add(new BtnView(this, med));
        p.add(new BtnBook(this, med));
        p.add(new BtnSearch(this, med));
        getContentPane().add(new LblDisplay(med), "North");
        getContentPane().add(p, "South");
        setSize(400, 200);
        setVisible(true);
    }

    public void actionPerformed(ActionEvent ae) {
        Command comd = (Command) ae.getSource();
        comd.execute();
    }

    public static void main(String[] args) {
        new MediatorDemo();
    }

}
```

# 例子
Colleagueclass
```
public class Colleague {
    public void action(){

    }
}
```
```
public class ColleagueA extends Colleague{
    @Override
    public void action() {
        System.out.println("普通员工努力工作");
    }
}
```
```
public class ColleagueB extends Colleague {
    @Override
    public void action() {
        System.out.println("前台注意了");
    }
}
```
Mediator
```
public abstract class Mediator {
    public abstract void notice(String content);
}
```
ConcreteMediator
```
public class ConcreateMedator extends Mediator {
    private ColleagueA ca;
    private ColleagueB cb;

    public ConcreateMedator() {
        ca=new ColleagueA();
        cb=new ColleagueB();
    }

    @Override
    public void notice(String content) {
        if(content.equals("boss")){
            ca.action();
        }
        if(content.equals("client")){
            cb.action();
        }
    }
}
```
Test
```
public class Test {
    public static void main(String[] args) {
        Mediator med = new ConcreateMedator();
        med.notice("boss");
        med.notice("client");
    }
}
```
运行结果：
```
普通员工努力工作
前台注意了
```


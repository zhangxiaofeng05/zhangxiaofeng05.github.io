# 行为型模式-命令模式


# 维基百科
## 命令模式
在面向对象编程的范畴中，命令模式（英语：Command pattern）是一种设计模式，它尝试以对象来代表实际行动。命令对象可以把行动(action) 及其参数封装起来，于是这些行动可以被：

 - 重复多次
 - 取消（如果该对象有实现的话）
 - 取消后又再重做

这些都是现代大型应用程序所必须的功能，即“撤销”及“重复”。除此之外，可以用命令模式来实现的功能例子还有：

 - 交易行为
 - 进度列
 - 向导
 - 用户界面按钮及功能表项目
 - 线程 pool
 - 宏收录

## Java
```
import java.util.List;
import java.util.ArrayList;

/* The Command interface */
public interface Command {
   void execute();
}

/* The Invoker class */
public class Switch {
   private List<Command> history = new ArrayList<Command>();

   public Switch() {
   }

   public void storeAndExecute(Command cmd) {
      this.history.add(cmd); // optional
      cmd.execute();        
   }
}

/* The Receiver class */
public class Light {
   public Light() {
   }

   public void turnOn() {
      System.out.println("The light is on");
   }

   public void turnOff() {
      System.out.println("The light is off");
   }
}

/* The Command for turning on the light - ConcreteCommand #1 */
public class FlipUpCommand implements Command {
   private Light theLight;

   public FlipUpCommand(Light light) {
      this.theLight = light;
   }

   public void execute(){
      theLight.turnOn();
   }
}

/* The Command for turning off the light - ConcreteCommand #2 */
public class FlipDownCommand implements Command {
   private Light theLight;

   public FlipDownCommand(Light light) {
      this.theLight = light;
   }

   public void execute() {
      theLight.turnOff();
   }
}

/* The test class or client */
public class PressSwitch {
   public static void main(String[] args){
      Light lamp = new Light();
      Command switchUp = new FlipUpCommand(lamp);
      Command switchDown = new FlipDownCommand(lamp);

      Switch mySwitch = new Switch();

      try {
         if ("ON".equalsIgnoreCase(args[0])) {
            mySwitch.storeAndExecute(switchUp);
         }
         else if ("OFF".equalsIgnoreCase(args[0])) {
            mySwitch.storeAndExecute(switchDown);
         }
         else {
            System.out.println("Argument \"ON\" or \"OFF\" is required.");
         }
      } catch (Exception e) {
         System.out.println("Arguments required.");
      }
   }
}
```

# 例子
Receiver
知道如何实现与执行一个请求相关的操作。任何类都可能作为一个接收者。
```
public class Receiver {
    public void receive(){
        System.out.println("This is Receive class!");
    }
}
```
Command
声明执行操作的接口。
```
public abstract class Command {
    protected Receiver receiver;

    public Command(Receiver receiver) {
        this.receiver = receiver;
    }

    public abstract void execute();
}
```
ConcreteCommand
将一个接收者对象绑定于一个动作。
调用接收者相应的操作，以实现Execute。
```
public class CommandImpl extends Command {
    public CommandImpl(Receiver receiver) {
        super(receiver);
    }

    @Override
    public void execute() {
        receiver.receive();
    }
}
```
Invoker
要求该命令执行这个请求。
```
public class Invoker {
    private Command command;

    public void setCommand(Command command) {
        this.command = command;
    }

    public void execute(){
        command.execute();
    }
}
```
Client
创建一个具体命令对象并设定它的接收者。
```
public class Test {
    public static void main(String[] args) {
        Receiver rec = new Receiver();
        Command cmd = new CommandImpl(rec);
        Invoker i = new Invoker();
        i.setCommand(cmd);
        i.execute();
    }
}
```

运行结果：
```
This is Receive class!
```


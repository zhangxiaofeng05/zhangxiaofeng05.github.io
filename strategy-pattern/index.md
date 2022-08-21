# 行为型模式-策略模式


# 维基百科
## 策略模式
策略模式作为一种软件设计模式，指对象有某个行为，但是在不同的场景中，该行为有不同的实现算法。比如每个人都要“交个人所得税”，但是“在美国交个人所得税”和“在中国交个人所得税”就有不同的算税方法。

策略模式：

 - 定义了一族算法（业务规则）；
 - 封装了每个算法；
 - 这族的算法可互换代替（interchangeable）。

## Java
```
//StrategyExample test application

class StrategyExample {

    public static void main(String[] args) {

        Context context;

        // Three contexts following different strategies
        context = new Context(new FirstStrategy());
        context.execute();

        context = new Context(new SecondStrategy());
        context.execute();

        context = new Context(new ThirdStrategy());
        context.execute();

    }

}

// The classes that implement a concrete strategy should implement this

// The context class uses this to call the concrete strategy
interface Strategy {

    void execute();

}

// Implements the algorithm using the strategy interface
class FirstStrategy implements Strategy {

    public void execute() {
        System.out.println("Called FirstStrategy.execute()");
    }

}

class SecondStrategy implements Strategy {

    public void execute() {
        System.out.println("Called SecondStrategy.execute()");
    }

}

class ThirdStrategy implements Strategy {

    public void execute() {
        System.out.println("Called ThirdStrategy.execute()");
    }

}

// Configured with a ConcreteStrategy object and maintains a reference to a Strategy object
class Context {

    Strategy strategy;

    // Constructor
    public Context(Strategy strategy) {
        this.strategy = strategy;
    }

    public void execute() {
        this.strategy.execute();
    }

}
```
运行结果：
```
Called FirstStrategy.execute()
Called SecondStrategy.execute()
Called ThirdStrategy.execute()
```


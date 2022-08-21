# 行为型模式-模板方法


# 维基百科
## 模板方法
模板方法模型是一种行为设计模型。模板方法是一个定义在父类别的方法，在模板方法中会呼叫多个定义在父类别的其他方法，而这些方法有可能只是抽象方法并没有实作，模板方法仅决定这些抽象方法的执行顺序，这些抽象方法的实作由子类别负责，并且子类别不允许覆写模板方法。
## 用法
模板方法模式多用在：

 - 某些类别的算法中，实做了相同的方法，造成程式码的重复。
 - 控制子类别必须遵守的一些事项。
 - ...

## Java
```
/**
  * An abstract class that is common to several games in
  * which players play against the others, but only one is
  * playing at a given time.
  */

 abstract class Game {

     private int playersCount;

     abstract void initializeGame();

     abstract void makePlay(int player);

     abstract boolean endOfGame();

     abstract void printWinner();

     /* A template method : */
     final void playOneGame(int playersCount) {
         this.playersCount = playersCount;
         initializeGame();
         int j = 0;
         while (!endOfGame()){
             makePlay(j);
             j = (j + 1) % playersCount;
         }
         printWinner();
     }
 }

//Now we can extend this class in order to implement actual games:

 class Monopoly extends Game {

     /* Implementation of necessary concrete methods */

     void initializeGame() {
         // ...
     }

     void makePlay(int player) {
         // ...
     }

     boolean endOfGame() {
         // ...
     }

     void printWinner() {
         // ...
     }

     /* Specific declarations for the Monopoly game. */

     // ...

 }

 class Chess extends Game {

     /* Implementation of necessary concrete methods */

     void initializeGame() {
         // ...
     }

     void makePlay(int player) {
         // ...
     }

     boolean endOfGame() {
         // ...
     }

     void printWinner() {
         // ...
     }

     /* Specific declarations for the chess game. */

     // ...

 }

 public class Player {
     public static void main(String[] args) {
         Game chessGame = new Chess();
         chessGame.initializeGame();
         chessGame.playOneGame(1); //call template method
     }
 }
```

# 例子
AbstractClass
定义抽象的原语操作（primitiveoperation），具体的子类将重定义它们以实现一个算法的各步骤。
实现一个模板方法,定义一个算法的骨架。
该模板方法不仅调用原语操作，也调用定义在AbstractClass或其他对象中的操作。
```
public abstract class Template {
    public abstract void print();
    public void update(){
        System.out.println("开始打印---");
        for (int i=0;i<10;i++){
            print();
        }
    }
}
```
ConcreteClass
实现原语操作以完成算法中与特定子类相关的步骤。
```
public class TemplateConcrete extends Template {
    @Override
    public void print() {
        System.out.println("这是子类的实现");
    }
}
```
Test
```
public class Test {
    public static void main(String[] args) {
        Template temp = new TemplateConcrete();
        temp.update();
    }
}
```
运行结果：
```
开始打印---
这是子类的实现
这是子类的实现
这是子类的实现
这是子类的实现
这是子类的实现
这是子类的实现
这是子类的实现
这是子类的实现
这是子类的实现
这是子类的实现
```


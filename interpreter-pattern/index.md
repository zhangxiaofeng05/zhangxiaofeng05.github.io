# 行为型模式-解释器模式


# 百度百科
## Interpreter模式
Interpreter(解释器)模式是一种特殊的设计模式，它建立一个解释器（Interpreter），对于特定的计算机程序设计语言，用来解释预先定义的文法。简单地说，Interpreter模式是一种简单的语法解释器构架。

Interpreter模式，即解释器模式。

解释器模式属于行为模式，Gof是这样定义的：给定一个语言，定义它的文法的一种表示，并定义一个解释器，这个解释器使用该表示来解释语言中的句子。

解释器模式需要解决的是，如果一种特定类型的问题发生的频率足够高，那么可能就值得将该问题的各个实例表述为一个简单语言中的句子。这样就可以构建一个解释器，该解释器通过解释这些句子来解决该问题。

实例应用：正则表达式

# 例子
AbstractExpression(抽象表达式)
声明一个抽象的解释操作，这个接口为抽象语法树中所有的节点所共享。
```
public abstract class Expression {
    abstract void interpret(Context ctx);
}
```

TerminalExpression(终结符表达式)
实现与文法中的终结符相关联的解释操作。
一个句子中的每个终结符需要该类的一个实例。
```
public class SimpleExpression extends Expression {
    @Override
    void interpret(Context ctx) {
        System.out.println("这是普通解析器");
    }
}
```

NonterminalExpression(非终结符表达式)
为文法中的非终结符实现解释(Interpret)操作。
```
public class AdvanceExpression extends Expression {
    @Override
    void interpret(Context ctx) {
        System.out.println("这是高级解析器");
    }
}
```

Context（上下文）
包含解释器之外的一些全局信息。
```
import java.util.ArrayList;
import java.util.List;

public class Context {
    private String content;
    private List list = new ArrayList();

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public void add(Expression eps){
        list.add(eps);
    }
    public List getList(){
        return list;
    }
}
```

Client（客户）
构建(或被给定)表示该文法定义的语言中某个特定的句子的抽象语法树。
该抽象语法树由NonterminalExpression和TerminalExpression的实例装配而成。调用解释操作。
```
public class Test {
    public static void main(String[] args) {
        Context ctx = new Context();
        ctx.add(new SimpleExpression());
        ctx.add(new AdvanceExpression());
        ctx.add(new SimpleExpression());
        for(Object eps: ctx.getList()){
            ((Expression)eps).interpret(ctx);
        }
    }
}
```

运行结果
```
这是普通解析器
这是高级解析器
这是普通解析器
```

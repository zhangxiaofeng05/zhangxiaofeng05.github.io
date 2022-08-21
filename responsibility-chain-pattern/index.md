# 行为型模式-责任链模式


# 维基百科
## 责任链模式
责任链模式在面向对象程式设计里是一种软件设计模式，它包含了一些命令对象和一系列的处理对象。每一个处理对象决定它能处理哪些命令对象，它也知道如何将它不能处理的命令对象传递给该链中的下一个处理对象。该模式还描述了往该处理链的末尾添加新的处理对象的方法。

## Java
以下的日志类(logging)例子演示了该模式。 每一个logging handler首先决定是否需要在该层做处理，然后将控制传递到下一个logging handler。程序的输出是:
```
Writing to debug output: Entering function y.
Writing to debug output: Step1 completed.
Sending via e-mail:      Step1 completed.
Writing to debug output: An error has occurred.
Sending via e-mail:      An error has occurred.
Writing to stderr:       An error has occurred.
```
注意：该例子不是日志类的推荐实现方式。

同时，需要注意的是，通常在责任链模式的实现中，如果在某一层已经处理了这个logger，那么这个logger就不会传递下去。在我们这个例子中，消息会一直传递到最底层不管它是否已经被处理。

```
abstract class Logger
{
    public static int ERR = 3;
    public static int NOTICE = 5;
    public static int DEBUG = 7;
    protected int mask;

    // The next element in the chain of responsibility
    protected Logger next;
    public Logger setNext( Logger l)
    {
        next = l;
        return this;
    }

    public final void message( String msg, int priority )
    {
        if ( priority <= mask )
        {
            writeMessage( msg );
            if ( next != null )
            {
                next.message( msg, priority );
            }
        }
    }

    protected abstract void writeMessage( String msg );

}

class StdoutLogger extends Logger
{

    public StdoutLogger( int mask ) { this.mask = mask; }

    protected void writeMessage( String msg )
    {
        System.out.println( "Writting to stdout: " + msg );
    }
}


class EmailLogger extends Logger
{

    public EmailLogger( int mask ) { this.mask = mask; }

    protected void writeMessage( String msg )
    {
        System.out.println( "Sending via email: " + msg );
    }
}

class StderrLogger extends Logger
{

    public StderrLogger( int mask ) { this.mask = mask; }

    protected void writeMessage( String msg )
    {
        System.out.println( "Sending to stderr: " + msg );
    }
}

public class ChainOfResponsibilityExample
{
    public static void main( String[] args )
    {
        // Build the chain of responsibility
        Logger l = new StdoutLogger( Logger.DEBUG).setNext(
                            new EmailLogger( Logger.NOTICE ).setNext(
                            new StderrLogger( Logger.ERR ) ) );

        // Handled by StdoutLogger
        l.message( "Entering function y.", Logger.DEBUG );

        // Handled by StdoutLogger and EmailLogger
        l.message( "Step1 completed.", Logger.NOTICE );

        // Handled by all three loggers
        l.message( "An error has occurred.", Logger.ERR );
    }
}
```

# 例子
```
public interface Request {
}
```
```
public class DimissionRequest implements Request {
}
```
```
public class AddMoneyRequest implements Request {
}
```
```
public class LeaveRequest implements Request {
}
```

Handler
```
public interface RequestHandle {
    void handleRequest(Request request);
}
```
ConcreteHandler
```
public class HRRequestHandle implements RequestHandle {
    @Override
    public void handleRequest(Request request) {
        if (request instanceof DimissionRequest){
            System.out.println("要离职，人事审批!");
        }
        System.out.println("请求完毕");
    }
}
```
```
public class PMRequestHandle implements RequestHandle {
    RequestHandle rh;

    public PMRequestHandle(RequestHandle rh) {
        this.rh = rh;
    }

    @Override
    public void handleRequest(Request request) {
        if(request instanceof AddMoneyRequest){
            System.out.println("要加薪，项目经理审批!");
        }else {
            rh.handleRequest(request);
        }
    }
}
```
```
public class TLRequestHandle implements RequestHandle {
    RequestHandle rh;

    public TLRequestHandle(RequestHandle rh) {
        this.rh = rh;
    }

    @Override
    public void handleRequest(Request request) {
        if(request instanceof LeaveRequest){
            System.out.println("要请假，项目组长审批!");
        }else {
            rh.handleRequest(request);
        }
    }
}
```
Client
```
public class Test {
    public static void main(String[] args) {
        RequestHandle hr = new HRRequestHandle();
        RequestHandle pm = new PMRequestHandle(hr);
        RequestHandle tl = new TLRequestHandle(pm);

        //处理离职请求
        Request request = new DimissionRequest();
        tl.handleRequest(request);

        System.out.println("=================");
        //处理加薪请求
        request = new AddMoneyRequest();
        tl.handleRequest(request);

        System.out.println("==================");
        //处理请假请求
        request = new LeaveRequest();
        tl.handleRequest(request);
    }
}
```

运行结果：
```
要离职，人事审批!
请求完毕
=================
要加薪，项目经理审批!
==================
要请假，项目组长审批!
```


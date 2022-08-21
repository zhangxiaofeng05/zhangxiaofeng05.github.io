# java异常


![](/mypng/2.png)

# 异常类型
 - 检查性异常
最具代表的检查性异常是用户错误或问题引起的异常，这是程序员无法预见的。例如要打开一个不存在文件时，一个异常就发生了，这些异常在编译时不能被简单地忽略。
 - 运行时异常
运行时异常是可能被程序员避免的异常。与检查性异常相反，运行时异常可以在编译时被忽略(Throw)。
 - 错误
错误不是异常，而是脱离程序员控制的问题。错误在代码中通常被忽略。例如，当栈溢出时，一个错误就发生了，它们在编译也检查不到的。

# 异常类Exception
## 构造方法
 - public Exception()  
构建一个新的异常，以 null作为其详细信息。 
 - public Exception(String message)  
使用指定的详细消息构造新的异常。 
 - public Exception(String message, Throwable cause)  
构造一个新的异常与指定的详细信息和原因。
 - public Exception(Throwable cause)  
构造一个新的异常与指定原因。
 - protected Exception(String message, Throwable cause,boolean enableSuppression,boolean writableStackTrace)  
构造一个新的异常，其中包含指定的详细消息，启用或禁用抑制功能，启用或禁用可写栈跟踪。

## 常用方法
 - public String getMessage()  
返回关于发生的异常的详细信息。这个消息在Throwable 类的构造函数中初始化了。
 - public Throwable getCause()  
返回一个Throwable 对象代表异常原因。
 - public String toString()  
使用getMessage()的结果返回类的串级名字。
 - public void **printStackTrace**()  
打印toString()结果和栈层次到System.err，即错误输出流。
 - public StackTraceElement [] getStackTrace()  
返回一个包含堆栈层次的数组。下标为0的元素代表栈顶，最后一个元素代表方法调用堆栈的栈底。
 - public Throwable fillInStackTrace()  
用当前的调用栈层次填充Throwable 对象栈层次，添加到栈层次任何先前信息中。

# 处理异常
## try-catch
```
public class MyException extends Exception{
    public static void main(String[] args) {
        try {
            int i=1/0;
        }catch (ArithmeticException e){
            e.printStackTrace();
        }
        catch (Exception e){
            e.printStackTrace();
            System.out.println("这是总异常");
        }finally {
            System.out.println("无论有没有异常，都会执行。比如用于关闭数据库的连接");
        }
    }
}

```
## throws
```
public class MyException extends Exception{
    public static void main(String[] args) {
        MyException myException = new MyException();
        try {
            myException.show();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void show() throws Exception{//抛出去，谁调用谁处理
        int i=1/0;
    }
}
```
## 注意事项
throws在方法名后边
catch 不能独立于 try 存在。
在 try/catch 后面添加 finally 块并非强制性要求的。
try 代码后不能既没 catch 块也没 finally 块。
try, catch, finally 块之间不能添加任何代码。

# 自定义异常
```
public class MyException extends Exception{
    public static void main(String[] args) {
        MyException myException = new MyException();
        try {
            System.out.println(myException.devide(4,2));
            System.out.println("------正常运行一个");
            int devide = myException.devide(1, 0);
            System.out.println("1/0="+devide);

        }catch (MyException e){
            System.out.println("这是我定义的异常");
        }

    }

    public int devide(int a,int b) throws MyException {
        if (b==0){
            throw new MyException();
        }else {
            return a/b;
        }
    }
}
```
运行结果
```
2
------正常运行一个
这是我定义的异常
```

参考：https://www.runoob.com/java/java-exceptions.html

# java接口回调


回调一般用于层间协作，上层将本层函数安装在下层，这个函数就是回调，而下层在一定条件下触发回调。例如作为一个驱动，是一个底层，他在收到一个数据时，除了完成本层的处理工作外，还将进行回调，将这个数据交给上层应用层来做进一步处理，这在分层的数据通信中很普遍。


例如老板A对员工B说，我现在交给你一个任务，并且我把我的电话号码给你，你一旦完成任务就给我打电话。

1.创建一个回调接口
```
/**
 * 一个回调接口
 */
public interface CallBack {
    public void doEvent();
}
```
2.创建回调接口的实现类，此例中，员工干完活后还要干什么事情是老板说了算的。
```
/**
 * 回调接口的实现类
 */
public class Boss implements CallBack{

    @Override
    public void doEvent() {
        System.out.println("打电话给老板，告知已完成工作了");
    }
}
```
3.创建控制类，也就是本例中的员工对象，他要持有老板的地址(即回调接口)
```
/**
 * 控制类，也就是本例中的员工对象，他要持有老板的地址(即回调接口)
 */
public class Employee {
    CallBack callBack;
    public Employee(CallBack callBack){
        this.callBack=callBack;
    }

    public void doWork(){
        System.out.println("玩命干活中");
        callBack.doEvent();
    }
}
```
4.测试类
```
/**
 * 测试类
 */
public class TestMain {
    public static void main(String[] args) {
        Employee employee = new Employee(new Boss());
        employee.doWork();
    }
}
```

运行结果：
```
玩命干活中
打电话给老板，告知已完成工作了
```

参考：
https://www.cnblogs.com/xujian2014/p/5088072.html

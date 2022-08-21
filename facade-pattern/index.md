# 结构型模式-外观模式


# 维基百科
## 外观模式
外观模式（Facade pattern），是软件工程中常用的一种软件设计模式，它为子系统中的一组接口提供一个统一的高层接口，使得子系统更容易使用。

## Java
这是一个抽象的示例。一个客户“you”通过外观接口“computer”获取计算机内部复杂的系统信息。
```
/* Complex parts */

class CPU {
	public void freeze() { ... }
	public void jump(long position) { ... }
	public void execute() { ... }
}

class Memory {
	public void load(long position, byte[] data) {
		...
	}
}

class HardDrive {
	public byte[] read(long lba, int size) {
		...
	}
}

/* Façade */

class Computer {
	public void startComputer() {
		cpu.freeze();
		memory.load(BOOT_ADDRESS, hardDrive.read(BOOT_SECTOR, SECTOR_SIZE));
		cpu.jump(BOOT_ADDRESS);
		cpu.execute();
	}
}

/* Client */

class You {
	public static void main(String[] args) {
		Computer facade = new Computer();
		facade.startComputer();
	}
}
```

# 例子
抽象类
```
public interface ServiceA {
    public void methodA();
}
```
```
public interface ServiceB {
    public void methodB();
}
```
```
public interface ServiceC {
    public void methodC();
}
```
实现类
```
public class ServiceAImpl implements ServiceA {
    @Override
    public void methodA() {
        System.out.println("这是服务A");
    }
}
```
```
public class ServiceBImpl implements ServiceB {
    @Override
    public void methodB() {
        System.out.println("这是服务B");
    }
}
```
```
public class ServiceCImpl implements ServiceC {
    @Override
    public void methodC() {
        System.out.println("这是服务C");
    }
}
```
外观类
```
public class Facade {
    ServiceA sa;
    ServiceB sb;
    ServiceC sc;

    public Facade() {
        sa = new ServiceAImpl();
        sb = new ServiceBImpl();
        sc = new ServiceCImpl();
    }

    public void methodA(){
        sa.methodA();
        sb.methodB();
    }

    public void methodB(){
        sb.methodB();
        sc.methodC();
    }

    public void methodC(){
        sc.methodC();
        sa.methodA();
    }
}
```
Test
```
public class Test {
    public static void main(String[] args) {
        ServiceA sa = new ServiceAImpl();
        ServiceB sb = new ServiceBImpl();

        sa.methodA();
        sb.methodB();
        System.out.println("=========");
        //facade
        Facade facade = new Facade();
        facade.methodA();
        facade.methodB();
    }
}
```
运行结果：
```
这是服务A
这是服务B
=========
这是服务A
这是服务B
这是服务B
这是服务C
```


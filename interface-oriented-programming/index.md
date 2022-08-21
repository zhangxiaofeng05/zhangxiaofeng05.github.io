# 什么是面向接口编程


# 面向接口编程
要正确地使用Java语言进行面向对象的编程，从而提高程序的复用性，增加程序的可维护性、可扩展性，就必须是面向接口的编程。面向接口的编程就意味着：开发系统时，主体构架使用接口，接口构成系统的骨架。这样就可以通过更换实现接口的类来更换系统的实现。

# 示例
```
public interface Person {
	public void show();
}
```
```
public class Man implements Person{

	@Override
	public void show() {
		System.out.println("Man...的show方法执行了。。。。");
	}
	
}
```
```
public class Woman implements Person{

	@Override
	public void show() {
		System.out.println("Woman...中的show方法执行了。。。。");
	}
	
}
```
```
public class MainTest {
	
	public void show(Person person) {
		person.show();
	}
	
	public static void main(String[] args) {
		Person man = new Man();//选择Persion，而不是Man man = new Man();
		Person woman = new Woman();//选择Persion，而不是Woman woman = new Woman();
		
		man.show();
		woman.show();
		
		System.out.println("-----------------");
		
		MainTest test = new MainTest();
		test.show(man);
		test.show(woman);
				
		System.out.println(man instanceof Woman);
		System.out.println(man instanceof Person);
		System.out.println(woman instanceof Person);
	}
}

```
执行结果：
```
Man...的show方法执行了。。。。
Woman...中的show方法执行了。。。。
-----------------
Man...的show方法执行了。。。。
Woman...中的show方法执行了。。。。
false
true
true
```
通过更换实现接口的类来更换系统的实现。

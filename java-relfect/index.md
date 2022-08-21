# 反射


# java.lang.Class<T> 
创建一个类，通过编译(javac.exe),生成对应的.class文件。之后使用java.exe加载(JVM的类加载器完成)，  此.class文件加载到内存以后，就是一个运行时类，存在缓冲区。那么这个运行时类本身就是一个Class的实例!
一个运行时类只加载一次。

## 举例
```
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

public class RelfectTest{
    public static void main(String[] args) throws IllegalAccessException, InstantiationException, NoSuchFieldException, NoSuchMethodException, InvocationTargetException {
        Class<Person> personClass = Person.class;
        //通过反射创建对象
        Person person = personClass.newInstance();
        System.out.println(person);
        //通过反射赋值-------public属性
        Field name = personClass.getField("name");
        name.set(person,"土豆");
        System.out.println(person);
        //通过反射赋值------private或者默认(不写)属性
        Field age = personClass.getDeclaredField("age");
        age.setAccessible(true);
        age.set(person,18);
        System.out.println(person);
        //通过反射调用指定方法--没有参数
        Method show = personClass.getMethod("show");
        show.invoke(person);
        //通过反射调用指定方法--有参数
        Method say = personClass.getMethod("say", String.class);
        say.invoke(person,"welcome");
    }
}
class Person{
    public String name;
    private int age;

    public Person() {
    }

    public Person(String name, int age) {
        this.name = name;
        this.age = age;
    }

    @Override
    public String toString() {
        return name+"----"+age;
    }

    public void show(){
        System.out.println("Person类的show...");
    }

    public void say(String word){
        System.out.println(name+" "+word);
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }
}
```
## 拓展
Person类
```
package com.cherry;

public class Person{
    public String name;
    private int age;
    int id;

    public Person() {
    }

    public Person(String name, int age) {
        this.name = name;
        this.age = age;
    }

    @Override
    public String toString() {
        return name+"----"+age;
    }

    public void show() throws Exception{
        System.out.println("Person类的show...");
    }

    public void say(String word){
        System.out.println(name+" "+word);
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }
}
```
jdbc.properties
```
username=root
password=1234
```

测试类
```
package com.cherry;

import org.junit.Test;

import java.io.IOException;
import java.io.InputStream;
import java.lang.annotation.Annotation;
import java.lang.reflect.*;
import java.util.Arrays;
import java.util.Properties;

public class RelfectionTest {
    /**
     * 类加载器，加载配置文件
     */
    @Test
    public void test1() throws IOException {
        ClassLoader classLoader = this.getClass().getClassLoader();
        InputStream inputStream = classLoader.getResourceAsStream("com\\cherry\\jdbc.properties");
        Properties properties = new Properties();
        properties.load(inputStream);
        String username = properties.getProperty("username");
        System.out.println("username="+username);
        String password = properties.getProperty("password");
        System.out.println("password="+password);
    }

    /**
     * 测试同一个实例
     */
    @Test
    public void test2() throws ClassNotFoundException, IllegalAccessException, InstantiationException {
        Class<Person> personClass1 = Person.class;

        String className="com.cherry.Person";
        Class<?> personClass2 = Class.forName(className);

        ClassLoader classLoader = this.getClass().getClassLoader();
        Class<?> personClass3 = classLoader.loadClass(className);
        System.out.println(personClass1==personClass2); //true
        System.out.println(personClass1==personClass3); //true

        Person person1 = personClass1.newInstance();
        Person person2 = (Person) personClass2.newInstance();
        System.out.println(person1==person2); //false

    }

    /**
     * newInstance()是调用了无参构造
     * @throws ClassNotFoundException
     * @throws IllegalAccessException
     * @throws InstantiationException
     */
    @Test
    public void test3() throws ClassNotFoundException, IllegalAccessException, InstantiationException {
        String className="com.cherry.Person";
        Class<?> personClass = Class.forName(className);
        Object o = personClass.newInstance();
        Person person = (Person) o;
        System.out.println(person);
    }

    @Test
    public void test4(){
        Class<Person> personClass = Person.class;
        //getFields---获取此类和父类的public属性
        Field[] fields = personClass.getFields();
        for(Field f: fields){
            System.out.println(f.getName());
        }
        System.out.println("----------");
        //getDeclaredFields---获取此类声明的属性
        Field[] fields1 = personClass.getDeclaredFields();
        for(Field f: fields1){
            System.out.println(f.getName());
        }
        System.out.println("-----------");
        /**
         * 权限修饰符  变量类型  变量名
         */
        Field[] fields2 = personClass.getDeclaredFields();
        for(Field f: fields2){
            int modifiers = f.getModifiers();
            String s = Modifier.toString(modifiers);
            System.out.print(s+"--");
            Class<?> type = f.getType();
            System.out.print(type.getName()+"--");
            System.out.println(f.getName());
        }
    }

    /**
     * 注解 权限修饰符 返回值类型 方法名 形参列表 异常
     */
    @Test
    public void test5(){
        Class<Person> personClass = Person.class;
        Method[] declaredMethods = personClass.getDeclaredMethods();
        for(Method m:declaredMethods){
            //1.注解
            Annotation[] annotations = m.getAnnotations();
            for(Annotation a:annotations){
                System.out.println(a);
            }
            //2.权限修饰符
            int modifiers = m.getModifiers();
            System.out.print(Modifier.toString(modifiers)+"--");
            //3.返回值类型
            Class<?> returnType = m.getReturnType();
            System.out.print(returnType.getName()+"--");
            //4.方法名
            String name = m.getName();
            System.out.print(name+"--");
            //5.形参列表
            Parameter[] parameters = m.getParameters();
            System.out.print(Arrays.asList(parameters)+"--");
            //6.异常
            Class<?>[] exceptionTypes = m.getExceptionTypes();
            System.out.print(Arrays.asList(exceptionTypes));
            System.out.println("-----------");
        }
    }

    @Test
    public void test6(){
        Class<Person> personClass = Person.class;
        //获取运行时类的构造器
        Constructor<?>[] declaredConstructors = personClass.getDeclaredConstructors();
        for(Constructor c:declaredConstructors){
            System.out.println(c);
        }
        System.out.println("------------");
        //获取运行是类的父类
        Class<? super Person> superclass = personClass.getSuperclass();
        System.out.println(superclass);
        System.out.println("--------------");
        //获取带泛型的父类
        Type genericSuperclass = personClass.getGenericSuperclass();
        System.out.println(genericSuperclass);
        System.out.println("------------");
        //获取父类的泛型
//        ParameterizedType parm = (ParameterizedType) genericSuperclass;
//        Type[] ars = parm.getActualTypeArguments();
//        System.out.println(Arrays.asList(ars));
    }

    @Test
    public void test7(){
        //获取所在的包
        Class<Person> personClass = Person.class;
        Package aPackage = personClass.getPackage();
        System.out.println(aPackage);
    }

    @Test
    public void test8() throws ClassNotFoundException, NoSuchMethodException, IllegalAccessException, InstantiationException, InvocationTargetException {
        String className="com.cherry.Person";
        Class<?> personClass = Class.forName(className);
        Constructor<?> constructor = personClass.getDeclaredConstructor(String.class, int.class);
        Object o = constructor.newInstance("地瓜", 18);
        Person person = (Person) o;
        System.out.println(person);
    }
}
```
# 代理
## 静态代理
```
package com.proxy;
//静态代理模式
//接口
interface ClothFactory{
    public void productCloth();
}
//被代理类
class NickClothFactory implements ClothFactory{

    @Override
    public void productCloth() {
        System.out.println("Nick在生产衣服");
    }
}
//代理类
class ProxyFactory implements ClothFactory{

    ClothFactory clothFactory;

    public ProxyFactory(ClothFactory clothFactory) {
        this.clothFactory = clothFactory;
    }


    @Override
    public void productCloth() {
        System.out.println("代理类执行了。。。");
        clothFactory.productCloth();
    }
}

public class StaticProxy {
    public static void main(String[] args) {
        NickClothFactory nick = new NickClothFactory();//创建被代理类的对象
        ProxyFactory proxy = new ProxyFactory(nick);//创建代理类的对象
        proxy.productCloth();
    }
}
```
## 动态代理
```
package com.proxy;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;

/**
 * 动态代理的使用
 */
interface Subject{
    void action();
}
//被代理类
class RealSubject implements Subject{

    @Override
    public void action() {
        System.out.println("被代理类的action。。。");
    }
}
class MyInvocationHandler implements InvocationHandler{
    Object obj;//实现了接口的被代理类的对象的声明
    //1.给被代理的对象实例化2.返回一个代理类的对象
    public Object blind(Object obj){
        this.obj=obj;
        return Proxy.newProxyInstance(obj.getClass().getClassLoader(),obj.getClass().getInterfaces(),this);
    }
    //当通过代理类的对象发起对被重写的方法的调用时，都会转换为对如下的invoke方法的调用
    @Override
    public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
        Object invoke = method.invoke(obj, args);
        return invoke;
    }
}
public class MovingProxy {
    public static void main(String[] args) {
        //1.被代理类的对象
        RealSubject real = new RealSubject();
        //2.创建一个实现了InvocationHandler接口的类的对象
        MyInvocationHandler handler = new MyInvocationHandler();
        //3.调用blind()方法，动态的返回一个同样实现了real所在类实现的接口的代理类的对象
        Object blind = handler.blind(real);
        Subject sub = (Subject)blind;

        sub.action();//转到对InvocationHandler接口的实现类的invoke()方法的调用

        NickClothFactory nick = new NickClothFactory();
        ClothFactory clothFactory = (ClothFactory) handler.blind(nick);
        clothFactory.productCloth();
    }
}
```
## 动态代理和aop
```
package com.aop;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;

interface Human{
    void info();
    void fly();
}
//被代理类
class SuperMan implements Human{

    @Override
    public void info() {
        System.out.println("SuperMan---info...");
    }

    @Override
    public void fly() {
        System.out.println("SuperMan---fly...");
    }
}
class HumanUtil{
    public void method1(){
        System.out.println("=======方法一========");
    }
    public void method2(){
        System.out.println("=======方法二========");
    }
}

class MyInvocationHandler implements InvocationHandler{
    Object obj;

    public void setObject(Object obj){
        this.obj=obj;
    }

    @Override
    public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
        HumanUtil h = new HumanUtil();

        h.method1();
        Object invoke = method.invoke(obj, args);
        h.method2();

        return invoke;
    }
}
class MyProxy{
    //动态的创建一个代理类的对象
    public static Object getProjectInstance(Object obj){
        MyInvocationHandler handler = new MyInvocationHandler();
        handler.setObject(obj);
        return Proxy.newProxyInstance(obj.getClass().getClassLoader(),obj.getClass().getInterfaces(),handler);
    }
}
public class AopTest {
    public static void main(String[] args) {
        SuperMan superMan = new SuperMan();
        Object o = MyProxy.getProjectInstance(superMan);
        Human human = (Human) o;

        human.info();
        System.out.println();
        human.fly();
    }
}
```
运行结果：
```
=======方法一========
SuperMan---info...
=======方法二========

=======方法一========
SuperMan---fly...
=======方法二========
```

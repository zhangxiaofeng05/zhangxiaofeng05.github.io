# 创建型模式-工厂方法


# 维基百科
## 工厂方法
工厂方法模式（英语：Factory method pattern）是一种实现了“工厂”概念的面向对象设计模式。就像其他创建型模式一样，它也是处理在不指定对象具体类型的情况下创建对象的问题。工厂方法模式的实质是“定义一个创建对象的接口，但让实现这个接口的类来决定实例化哪个类。工厂方法让类的实例化推迟到子类中进行。”
创建一个对象常常需要复杂的过程，所以不适合包含在一个复合对象中。创建对象可能会导致大量的重复代码，可能会需要复合对象访问不到的信息，也可能提供不了足够级别的抽象，还可能并不是复合对象概念的一部分。工厂方法模式通过定义一个单独的创建对象的方法来解决这些问题。由子类实现这个方法来创建具体类型的对象。
对象创建中的有些过程包括决定创建哪个对象、管理对象的生命周期，以及管理特定对象的创建和销毁的概念。
## 工厂
在面向对象程序设计中，工厂通常是一个用来创建其他对象的对象。工厂是构造方法的抽象，用来实现不同的分配方案。

工厂对象通常包含一个或多个方法，用来创建这个工厂所能创建的各种类型的对象。这些方法可能接收参数，用来指定对象创建的方式，最后返回创建的对象。
有时，特定类型对象的控制过程比简单地创建一个对象更复杂。在这种情况下，工厂对象就派上用场了。工厂对象可能会动态地创建产品类的对象，或者从对象池中返回一个对象，或者对所创建的对象进行复杂的配置，或者应用其他的操作。
这些类型的对象很有用。几个不同的设计模式都应用了工厂的概念，并可以使用在很多语言中。例如，在《设计模式》一书中，像工厂方法模式、抽象工厂模式、生成器模式，甚至是单例模式都应用了工厂的概念。

## 代码举例
例如，有一个Button类表示按钮，另有它的两个子类WinButton和MacButton分别代表Windows和Mac风格的按钮，那么这几个类和用于创建它们的工厂类在Java中可以如下实现
```
//Button
class Button{/* ...*/}
class WinButton extends Button{/* ...*/}
class MacButton extends Button{/* ...*/}

//他们的工厂类
interface ButtonFactory{
    abstract Button createButton();
}
class WinButtonFactory implements ButtonFactory{
    Button createButton(){
        return new WinButton();
    }
}
class MacButtonFactory implements ButtonFactory{
    Button createButton(){
        return new MacButton();
    }
}
```

## 简单工厂
普通的工厂方法模式通常伴随着对象的具体类型与工厂具体类型的一一对应，客户端代码根据需要选择合适的具体类型工厂使用。然而，这种选择可能包含复杂的逻辑。这时，可以创建一个单一的工厂类，用以包含这种选择逻辑，根据参数的不同选择实现不同的具体对象。这个工厂类不需要由每个具体产品实现一个自己的具体的工厂类，所以可以将工厂方法设置为静态方法。 而且，工厂方法封装了对象的创建过程。如果创建过程非常复杂（比如依赖于配置文件或用户输入），工厂方法就非常有用了。 比如，一个程序要读取图像文件。程序支持多种图像格式，每种格式都有一个对应的ImageReader类用来读取图像。程序每次读取图像时，需要基于文件信息创建合适类型的ImageReader。这个选择逻辑可以包装在一个简单工厂中：
```
public class ImageReaderFactory {
    public static ImageReader imageReaderFactoryMethod(InputStream is) {
        ImageReader product = null;

        int imageType = determineImageType(is);
        switch (imageType) {
            case ImageReaderFactory.GIF:
                product = new GifReader(is);
            case ImageReaderFactory.JPEG:
                product = new JpegReader(is);
            //...
        }
        return product;
    }
}
```
## 适用性
下列情况可以考虑使用工厂方法模式：

 - 创建对象需要大量重复的代码。
 - 创建对象需要访问某些信息，而这些信息不应该包含在复合类中。
 - 创建对象的生命周期必须集中管理，以保证在整个程序中具有一致的行为。

工厂方法模式常见于工具包和框架中，在这些库中可能需要创建客户端代码实现的具体类型的对象。

平行的类层次结构中，常常需要一个层次结构中的对象能够根据需要创建另一个层次结构中的对象。

工厂方法模式可以用于测试驱动开发，从而允许将类放在测试中。举例来说，Foo这个类创建了一个Dangerous对象，但是Dangerous对象不能放在自动的单元测试中（可能它需要访问产品数据库，而这个数据库不是随时能够访问到的）。所以，就可以把Dangerous对象的创建交由Foo类的一个方法（虚函数）createDangerous完成。为了测试，再创建一个Foo的一个子类TestFoo，重写createDangerous方法，在方法中创建并返回一个FakeDangerous（Dangerous的子类），而这是一个模拟对象。这样，单元测试就可以使用TestFoo来测试Foo的功能，从而避免了使用Dangerous对象带来的副作用。

## 局限性
使用工厂方法有三个局限，第一个与代码重构有关，另外两个与类的扩展有关。

 - 第一个局限是，重构已经存在的类会破坏客户端代码。例如，Complex类是一个标准的类，客户端使用构造方法将其实例化。可能会有很多这样的客户端代码：

```
Complex c = new Complex(-1, 0);
```
一旦Complex的编写者意识到Complex的实例化应该使用工厂方法实现，他会将Complex的构造方法设为私有。而此时使用它的构造方法的客户端代码就都失效了。

 - 第二个局限是，因为工厂方法所实例化的类具有私有的构造方法，所以这些类就不能扩展了。因为任何子类都必须调用父类的构造方法，但父类的私有构造方法是不能被子类调用的。

 - 第三个局限是，如果确实扩展了工厂方法所实例化的类（例如将构造方法设为保护的，虽然有风险但也是可行的），子类必须具有所有工厂方法的一套实现。例如，在上述Complex的例子中，如果Complex有了一个子类StrangeComplex，那么StrangeComplex必须提供属于它自己的所有工厂方法，否则

```
StrangeComplex.fromPolar(1, pi);
```
将会返回一个Complex（父类）的实例，而不是所希望的子类实例。但有些语言的反射特性可以避免这个问题。
通过修改底层编程语言，使工厂方法称为第一类的类成员，可以缓解这三个问题。


# 例子
 1. Product
定义工厂方法所创建的对象的接口。
```
public interface Work {
    void doWork();
}
```

 2. ConcreteProduct
实现Product接口。
```
public class StudentWork implements Work {
    @Override
    public void doWork() {
        System.out.println("学生写作业");
    }
}
```
```
public class TeachWork implements Work {
    @Override
    public void doWork() {
        System.out.println("老师审批作业");
    }
}
```

 3. Creator
声明工厂方法，该方法返回一个Product类型的对象
Creator也可以定义一个工厂方法的缺省实现，它返回一个缺省的ConcreteProduct对象。
可以调用工厂方法以创建一个Product对象。
```
public interface IWorkFactory {
    Work getWork();
}
```

 4. ConcreteCreator
重定义工厂方法以返回一个ConcreteProduct实例。
```
public class StudentFactory implements IWorkFactory{
    @Override
    public Work getWork() {
        return new StudentWork();
    }
}
```
```
public class TeacherFactory implements IWorkFactory {
    @Override
    public Work getWork() {
        return new TeachWork();
    }
}
```
 5. Test
```
public class Test {
    public static void main(String[] args) {
        IWorkFactory studentFactory = new StudentFactory();
        studentFactory.getWork().doWork();

        IWorkFactory teacherFactory = new TeacherFactory();
        teacherFactory.getWork().doWork();
    }
}
```

 6. Result
```
学生写作业
老师审批作业
```

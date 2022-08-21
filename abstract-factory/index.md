# 创建型模式-抽象工厂


# 维基百科
## 抽象工厂
抽象工厂模式（英语：Abstract factory pattern）是一种软件开发设计模式。抽象工厂模式提供了一种方式，可以将一组具有同一主题的单独的工厂封装起来。在正常使用中，客户端程序需要创建抽象工厂的具体实现，然后使用抽象工厂作为接口来创建这一主题的具体对象。客户端程序不需要知道（或关心）它从这些内部的工厂方法中获得对象的具体类型，因为客户端程序仅使用这些对象的通用接口。抽象工厂模式将一组对象的实现细节与他们的一般使用分离开来。
举个例子来说，比如一个抽象工厂类叫做DocumentCreator（文档创建器），此类提供创建若干种产品的接口，包括createLetter()（创建信件）和createResume()（创建简历）。其中，createLetter()返回一个Letter（信件），createResume()返回一个Resume（简历）。系统中还有一些DocumentCreator的具体实现类，包括FancyDocumentCreator和ModernDocumentCreator。这两个类对DocumentCreator的两个方法分别有不同的实现，用来创建不同的“信件”和“简历”（用FancyDocumentCreator的实例可以创建FancyLetter和FancyResume，用ModernDocumentCreator的实例可以创建ModernLetter和ModernResume）。这些具体的“信件”和“简历”类均继承自抽象类，即Letter和Resume类。客户端需要创建“信件”或“简历”时，先要得到一个合适的DocumentCreator实例，然后调用它的方法。一个工厂中创建的每个对象都是同一个主题的（“fancy”或者“modern”）。客户端程序只需要知道得到的对象是“信件”或者“简历”，而不需要知道具体的主题，因此客户端程序从抽象工厂DocumentCreator中得到了Letter或Resume类的引用，而不是具体类的对象引用。
“工厂”是创建产品（对象）的地方，其目的是将产品的创建与产品的使用分离。抽象工厂模式的目的，是将若干抽象产品的接口与不同主题产品的具体实现分离开。这样就能在增加新的具体工厂的时候，不用修改引用抽象工厂的客户端代码。

使用抽象工厂模式，能够在具体工厂变化的时候，不用修改使用工厂的客户端代码，甚至是在运行时。然而，使用这种模式或者相似的设计模式，可能给编写代码带来不必要的复杂性和额外的工作。正确使用设计模式能够抵消这样的“额外工作”

## 定义
抽象工厂模式的实质是“提供接口，创建一系列相关或独立的对象，而不指定这些对象的具体类。

## 使用
具体的工厂决定了创建对象的具体类型，而且工厂就是对象实际创建的地方（比如在C++中，用“new”操作符创建对象）。然而，抽象工厂只返回一个指向创建的对象的抽象引用（或指针）。
这样，客户端程序调用抽象工厂引用的方法，由具体工厂完成对象创建，然后客户端程序得到的是抽象产品的引用。如此使客户端代码与对象的创建分离开来。
因为工厂仅仅返回一个抽象产品的引用（或指针），所以客户端程序不知道（也不会牵绊于）工厂创建对象的具体类型。然而，工厂知道具体对象的类型；例如，工厂可能从配置文件中读取某种类型。这时，客户端没有必要指定具体类型，因为已经在配置文件中指定了。通常，这意味着：

 - 客户端代码不知道任何具体类型，也就没必要引入任何相关的头文件或类定义。客户端代码仅仅处理抽象类型。工厂确实创建了具体类型的对象，但是客户端代码仅使用这些对象的抽象接口来访问它们。

 - 如果要增加一个具体类型，只需要修改客户端代码使用另一个工厂即可，而且这个修改通常只是一个文件中的一行代码。不同的工厂创建不同的具体类型的对象，但是和以前一样返回一个抽象类型的引用（或指针），因此客户端代码的其他部分不需要任何改动。这样比修改客户端代码创建新类型的对象简单多了。如果是后者的话，需要修改代码中每一个创建这种对象的地方（而且需要注意的是，这些地方都知道对象的具体类型，而且需要引入具体类型的头文件或类定义）。如果所有的工厂对象都存储在全局的单例对象中，所有的客户端代码到这个单例中访问需要的工厂，那么，更换工厂就非常简单了，仅仅需要更改这个单例对象即可。

## 代码举例
假设我们有两种产品接口 Button 和 Border ，每一种产品都支持多种系列，比如 Mac 系列和 Windows 系列。这样每个系列的产品分别是 MacButton, WinButton, MacBorder, WinBorder 。为了可以在运行时刻创建一个系列的产品族，我们可以为每个系列的产品族创建一个工厂 MacFactory 和 WinFactory 。每个工厂都有两个方法 CreateButton 和 CreateBorder 并返回对应的产品，可以将这两个方法抽象成一个接口 AbstractFactory 。这样在运行时刻我们可以选择创建需要的产品系列。
```
public interface Button {}
public interface Border {}

//实现抽象类
public class MacButton implements Button {}
public class MacBorder implements Border {}

public class WinButton implements Button {}
public class WinBorder implements Border {}

//接着实现工厂
public class MacFactory {
	public static Button createButton() {
	    return new MacButton();
	}
	public static Border createBorder() {
	    return new MacBorder();
	}
}

public class WinFactory {
	public static Button createButton() {
	    return new WinButton();
	}
	public static Border createBorder() {
	    return new WinBorder();
	}
}
```

## 适用性
在以下情况可以考虑使用抽象工厂模式：
 - 一个系统要独立于它的产品的创建、组合和表示时。
 - 一个系统要由多个产品系列中的一个来配置时。
 - 需要强调一系列相关的产品对象的设计以便进行联合使用时。
 - 提供一个产品类库，而只想显示它们的接口而不是实现时。

## 优点
 1. 具体产品从客户代码中被分离出来
 2. 容易改变产品的系列
 3. 将一个系列的产品族统一到一起创建

## 缺点
在产品族中扩展新的产品是很困难的，它需要修改抽象工厂的接口

# 例子
```
public interface ICat {
    void eat();
}
```
```
public interface IDog {
    void eat();
}
```
```
public interface IAnimalFactory {
    ICat createCat();
    IDog createDog();
}
```

```
public class BlackCat implements ICat {
    @Override
    public void eat() {
        System.out.println("黑猫在吃。。");
    }
}
```
```
public class BlackDog implements IDog {
    @Override
    public void eat() {
        System.out.println("黑狗在吃。。");
    }
}
```
```
public class BlackAnimalFactory implements IAnimalFactory {
    @Override
    public ICat createCat() {
        return new BlackCat();
    }

    @Override
    public IDog createDog() {
        return new BlackDog();
    }
}
```

```
public class WhiteCat implements ICat {
    @Override
    public void eat() {
        System.out.println("白猫在吃。。");
    }
}
```
```
public class WhiteDog implements IDog {
    @Override
    public void eat() {
        System.out.println("白狗在吃。。");
    }
}
```
```
public class WhiteAnimalFactory implements IAnimalFactory {
    @Override
    public ICat createCat() {
        return new WhiteCat();
    }

    @Override
    public IDog createDog() {
        return new WhiteDog();
    }
}
```
测试类
```
public class Test {
    public static void main(String[] args) {
        IAnimalFactory blackAnimalFactory = new BlackAnimalFactory();
        ICat blackCat = blackAnimalFactory.createCat();
        blackCat.eat();
        IDog blackDog = blackAnimalFactory.createDog();
        blackDog.eat();

        IAnimalFactory whiteAnimalFactory = new WhiteAnimalFactory();
        ICat whiteCat = whiteAnimalFactory.createCat();
        whiteCat.eat();
        IDog whiteDog = whiteAnimalFactory.createDog();
        whiteDog.eat();
    }
}
```
结果：
```
黑猫在吃。。
黑狗在吃。。
白猫在吃。。
白狗在吃。。
```

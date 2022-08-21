# 结构型模式-装饰模式


# 维基百科
## 修饰模式
修饰模式，是面向对象编程领域中，一种动态地往一个类中添加新的行为的设计模式。就功能而言，修饰模式相比生成子类更为灵活，这样可以给某个对象而不是整个类添加一些功能。
## 介绍
通过使用修饰模式，可以在运行时扩充一个类的功能。原理是：增加一个修饰类包裹原来的类，包裹的方式一般是通过在将原来的对象作为修饰类的构造函数的参数。装饰类实现新的功能，但是，在不需要用到新功能的地方，它可以直接调用原来的类中的方法。修饰类必须和原来的类有相同的接口。

修饰模式是类继承的另外一种选择。类继承在编译时候增加行为，而装饰模式是在运行时增加行为。

当有几个相互独立的功能需要扩充时，这个区别就变得很重要。在有些面向对象的编程语言中，类不能在运行时被创建，通常在设计的时候也不能预测到有哪几种功能组合。这就意味着要为每一种组合创建一个新类。相反，修饰模式是面向运行时候的对象实例的,这样就可以在运行时根据需要进行组合。一个修饰模式的示例是JAVA里的Java I/O Streams的实现。
## 动机
例如，一个窗口系统中的窗口，允许这个窗口内容滚动，我们希望给它添加水平或垂直滚动条。假设窗口通过“Window”类实例来表示，并且假设它没有添加滚动条功能。我们可以创建一个子类“ScrollingWindow”来提供，或者我们可以创建一个ScrollingWindowDecorator来为已存在的Window对象添加这个功能。在这点上，只要是解决方案就可以了。 现在我们假设希望选择给我们的窗口添加边框，同样，我们的原始Window类不支持。ScrollingWindow子类现在会造成一个问题，因为它会有效的创建一种新的窗口。如果我们想要给所有窗口添加边框，我们必须创建WindowWithBorder和ScrollingWindowWithBorder子类。显然，这个问题由于被添加类而变得更糟了。对于修饰模式，我们简单的创建一个新类BorderedWindowDecorator，在运行时，我们能够使用ScrollingWindowDecorator或BorderedWindowDecorator或两者结合来修饰已存在的窗口。 一个修饰能够被应用的另一个好例子是当有需要根据某套规则或者几个平行的规则集（不同的用户凭据等）限制访问对象的属性或方法时。

一个对象的属性或方法按照某组规则或几个并行规则(不同用户证书等)需要限制访问时，在这种情况下，不是在原始对象中实现访问控制而是在他的使用中不变或不知道任何限制，并且他被包装在一个访问控制修饰对象中，这个对象能够对允许的原始对象的接口子集服务。
## 应用
Java IO 流为典型的装饰模式。
## Java
这个JAVA示例使用window/scrolling情境。
```
// The Window interface class
public interface Window {
	public void draw(); // Draws the Window
	public String getDescription(); // Returns a description of the Window
}
```
```
// implementation of a simple Window without any scrollbars
public class SimpleWindow implements Window {
	public void draw() {
		// Draw window
	}

	public String getDescription() {
		return "simple window";
	}
}
```
以下类包含所有Window类的decorator，以及修饰类本身。
```
// abstract decorator class - note that it implements Window
public abstract class WindowDecorator implements Window {
    protected Window decoratedWindow; // the Window being decorated

    public WindowDecorator (Window decoratedWindow) {
        this.decoratedWindow = decoratedWindow;
    }

    @Override
    public void draw() {
        decoratedWindow.draw();
    }

    @Override
    public String getDescription() {
        return decoratedWindow.getDescription();
    }
}
```
```
// The first concrete decorator which adds vertical scrollbar functionality
public class VerticalScrollBar extends WindowDecorator {
	public VerticalScrollBar(Window windowToBeDecorated) {
		super(windowToBeDecorated);
	}

	@Override
	public void draw() {
		super.draw();
		drawVerticalScrollBar();
	}

	private void drawVerticalScrollBar() {
		// Draw the vertical scrollbar
	}

	@Override
	public String getDescription() {
		return super.getDescription() + ", including vertical scrollbars";
	}
}
```
```
// The second concrete decorator which adds horizontal scrollbar functionality
public class HorizontalScrollBar extends WindowDecorator {
	public HorizontalScrollBar (Window windowToBeDecorated) {
		super(windowToBeDecorated);
	}

	@Override
	public void draw() {
		super.draw();
		drawHorizontalScrollBar();
	}

	private void drawHorizontalScrollBar() {
		// Draw the horizontal scrollbar
	}

	@Override
	public String getDescription() {
		return super.getDescription() + ", including horizontal scrollbars";
	}
}
```
以下是一个测试程序，它创建了一个包含多重装饰的Window实例(如,包含了垂直的和水平的滚动条),然后输出它的描述：
```
public class Main {
	// for print descriptions of the window subclasses
	static void printInfo(Window w) {
		System.out.println("description:"+w.getDescription());
	}
	public static void main(String[] args) {
		// original SimpleWindow
		SimpleWindow sw = new SimpleWindow();
		printInfo(sw);
		// HorizontalScrollBar  mixed Window
		HorizontalScrollBar hbw = new HorizontalScrollBar(sw);
		printInfo(hbw);
		// VerticalScrollBar mixed Window
		VerticalScrollBar vbw = new VerticalScrollBar(hbw);
		printInfo(vbw);
	}
}
```
以下是SimpleWindow及添加了组件HorizontalScrollBar和VerticalScrollBar后的Window测试结果：
```
description:simple window
description:simple window, including horizontal scrollbars
description:simple window, including horizontal scrollbars, including vertical scrollbars
```


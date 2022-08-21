# 行为型模式-迭代器模式


# 维基百科
## 迭代器模式
在 面向对象编程里，迭代器模式是一种设计模式，是一种最简单也最常见的设计模式。它可以让用户透过特定的接口巡访容器中的每一个元素而不用了解底层的实现。

此外，也可以实现特定目的版本的迭代器。

## 接口
《设计模式》建议合理的接口该要有：
```
public interface Iterator
{
    public Object First();
    public Object Next();
    public boolean isDone();
    public Object CurrentItem();
}
```

## Java
```
interface Iterator{
    Object First();
    Object Next();
    boolean IsDone();
    Object CurrentItem();
}

abstract class Aggregate{
    abstract Iterator CreateIterator();
}

class ConcreteIterator implements Iterator{
    private List<Object> list = new ArrayList<Object>();
    private int curr=0;
    public ConcreteIterator(List<Object> list){
        this.list = list;
    }

    public Object First(){
        return list.get(0);
    }

    public Object Next(){
        Object ret = null;
        curr++;
        if(curr < list.size()){
            ret = list.get(curr);
        }
        return ret;
    }

    public boolean IsDone(){
        return curr>=list.size()?true:false;
    }

    public Object CurrentItem(){
        return list.get(curr);
    }
}

class ConcreteAggregate extends Aggregate{
    private List<Object> list = new ArrayList<Object>();
    public ConcreteAggregate(List<Object> list){
        this.list = list;
    }
    public Iterator CreateIterator(){
        return new ConcreteIterator(list);
    }
}

class client{
    public static void main(String[] args){
    List<Object> list = new ArrayList<Object>();
    list.add("miner");
    list.add("any");
    Aggregate agg = new ConcreteAggregate(list);
    Iterator iterator = agg.CreateIterator();
    iterator.First();
    while(!iterator.IsDone()){
        System.out.println(iterator.CurrentItem());
        iterator.Next();
        }
    }
}
```

# 例子
Aggregate
聚合定义创建相应迭代器对象的接口。
```
public interface List {
    Iterator iterator();
    Object get(int index);
    int getSize();
    void add(Object obj);
}
```
Iterator
迭代器定义访问和遍历元素的接口。
```
public interface Iterator {
    Object next();
    void first();
    void last();
    boolean hasNext();
}
```
ConcreteIterator
具有迭代器实现迭代器接口。
对该聚合遍历时跟踪当前位置。
```
public class IteratorImpl implements Iterator {
    private List list;
    private int index;

    public IteratorImpl(List list) {
        this.list = list;
        index=0;
    }

    @Override
    public Object next() {
        Object obj = list.get(index);
        index++;
        return obj;
    }

    @Override
    public void first() {
        index=0;
    }

    @Override
    public void last() {
        index=list.getSize();
    }

    @Override
    public boolean hasNext() {
        return index<list.getSize();
    }
}
```
ConcreteAggregate
具体聚合实现创建相应迭代器的接口，该操作返回ConcreteIterator的一个适当的实例
```
public class ListImpl implements List {
    private Object[] list;
    private int index;
    private int size;

    public ListImpl() {
        index=0;
        size=0;
        list = new Object[100];
    }

    @Override
    public Iterator iterator() {
        return new IteratorImpl(this);
    }

    @Override
    public Object get(int index) {
        return list[index];
    }

    @Override
    public int getSize() {
        return this.size;
    }

    @Override
    public void add(Object obj) {
        list[index++]=obj;
        size++;
    }
}
```
Test
```
public class Test {
    public static void main(String[] args) {
        List list = new ListImpl();
        list.add("a");
        list.add("b");
        list.add("c");
        //第一种迭代方式
        Iterator it = list.iterator();
        while (it.hasNext()){
            System.out.println(it.next());
        }
        System.out.println("=============");
        //第二种迭代方式
        for(int i=0;i<list.getSize();i++){
            System.out.println(list.get(i));
        }
    }
}
```

运行结果：
```
a
b
c
=============
a
b
c
```


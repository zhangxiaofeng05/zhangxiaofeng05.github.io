# 创建型模式-原型模式


# 维基百科
## 原型模式
原型模式是创建型模式的一种，其特点在于通过“复制”一个已经存在的实例来返回新的实例,而不是新建实例。被复制的实例就是我们所称的“原型”，这个原型是可定制的。

原型模式多用于创建复杂的或者耗时的实例，因为这种情况下，复制一个已经存在的实例使程序运行更高效；或者创建值相等，只是命名不一样的同类数据。

## Java
```
/** Prototype Class **/
public class Cookie implements Cloneable {

   public Object clone() throws CloneNotSupportedException
   {
       //In an actual implementation of this pattern you would now attach references to
       //the expensive to produce parts from the copies that are held inside the prototype.
       return (Cookie) super.clone();
   }
}

/** Concrete Prototypes to clone **/
public class CoconutCookie extends Cookie { }

/** Client Class**/
public class CookieMachine
{

  private Cookie cookie;//cookie必须是可复制的

    public CookieMachine(Cookie cookie) {
        this.cookie = cookie;
    }

   public Cookie makeCookie()
   {
       try
       {
           return (Cookie) cookie.clone();
       } catch (CloneNotSupportedException e)
       {
           e.printStackTrace();
       }
       return null;
   }


    public static void main(String args[]){
        Cookie tempCookie =  null;
        Cookie prot = new CoconutCookie();
        CookieMachine cm = new CookieMachine(prot); //设置原型
        for(int i=0; i<100; i++)
            tempCookie = cm.makeCookie();//通过复制原型返回多个cookie
    }
}
```

# 例子

 - Prototype

声明一个克隆自身的接口

```
public class Prototype implements Cloneable{
    private String name;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public Object clone() {
        try {
            return super.clone();
        } catch (CloneNotSupportedException e) {
            e.printStackTrace();
            return null;
        }
    }
}
```

 - ConcretePrototype

实现一个克隆自身的操作。

```
public class ConcreatePrototype extends Prototype {
    public ConcreatePrototype(String name){
        setName(name);
    }
}
```

 - Client

让一个原型克隆自身从而创建一个新的对象。

```
public class Test {
    public static void main(String[] args) {
        Prototype pro = new ConcreatePrototype("prototype");
        Prototype pro2 = (Prototype) pro.clone();

        System.out.println(pro.getName());
        System.out.println(pro2.getName());

        System.out.println(pro);
        System.out.println(pro2);
    }
}
```

运行结果：

```
prototype
prototype
ConcreatePrototype@677327b6
ConcreatePrototype@14ae5a5
```


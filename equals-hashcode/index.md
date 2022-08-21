# ==和equals和hashCode


# ==和equals
## ==
 - 基本类型：比较的是值是否相同；
 - 引用类型：比较的是内存地址是否相同(是否是同一对象)；
## equals
Object类中的equals方法
```
public boolean equals(Object obj) {
    return (this == obj);
}
```
String类重写了equals方法
```
public boolean equals(Object anObject) {
    if (this == anObject) {
        return true;
    }
    if (anObject instanceof String) {
        String anotherString = (String)anObject;
        int n = value.length;
        if (n == anotherString.value.length) {
            char v1[] = value;
            char v2[] = anotherString.value;
            int i = 0;
            while (n-- != 0) {
                if (v1[i] != v2[i])
                    return false;
                i++;
            }
            return true;
        }
    }
    return false;
}
```
举例：
```
public class StringTest {
    public static void main(String[] args) {
        String aa="String";
        String bb="String";
        String cc=new String("String");
        String dd=new String("String");
        System.out.println(aa==bb); //true
        System.out.println(aa==cc); //false
        System.out.println(aa.equals(bb)); //true
        System.out.println(aa.equals(cc)); //true
        System.out.println(cc==dd); //false
        System.out.println(cc.equals(dd)); //true
    }
}
```
解读：aa、bb是放在常量池中，aa和bb是同一个引用，cc是在堆内存中，dd也是在堆内存中，但是每new一个对象，新开辟一个空间，所以不是同一个引用。equals比较的是字符串内容，所以equals比较都是true

对上述程序进行修改
```
public class StringTest {
    public static void main(String[] args) {
        String aa="String";
        String bb="String";
        String cc=new String("String");

        cc=cc.intern();
        String dd=new String("String");
        dd=dd.intern();
        System.out.println(aa==bb); //true
        System.out.println(aa==cc); //true
        System.out.println(aa.equals(bb)); //true
        System.out.println(aa.equals(cc)); //true
        System.out.println(cc==dd); //true
        System.out.println(cc.equals(dd)); //true
    }
}

```
解读：intern()方法，检查字符串池里是否存在"String"这么一个字符串，如果存在，就返回池里的字符串；如果不存在，该方法会 把"String"添加到字符串池中，然后再返回它的引用。
# 自定义类
```
public class StringTest {
    public static void main(String[] args) {
        Person potato1 = new Person("土豆", 18);
        Person potato2 = new Person("土豆", 18);
        System.out.println(potato1==potato2); //false
        System.out.println(potato1.equals(potato2)); //false
    }
}
class Person{
    String name;
    Integer age;

    public Person() {
    }

    public Person(String name, Integer age) {
        this.name = name;
        this.age = age;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }
}
```
一个Person类new了两个对象，==和equals都是false。原因：==比较的是内存地址，每次new都会开辟新空间，所以false；equals其实是调用基类Object中的equals方法，本质还是比较内存地址，所以false

## 重写equals方法
```
public class StringTest {
    public static void main(String[] args) {
        Person potato1 = new Person("土豆", 18);
        Person potato2 = new Person("土豆", 18);
        System.out.println(potato1==potato2); //false
        System.out.println(potato1.equals(potato2)); //true
    }
}
class Person{
    String name;
    Integer age;

    public Person() {
    }

    public Person(String name, Integer age) {
        this.name = name;
        this.age = age;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    @Override
    public boolean equals(Object obj) {
        //同一个对象，肯定相等，提高效率
        if (this==obj)
            return true;
        //判断该对象是否是该类的一个对象
        if (!(obj instanceof Person)){
            return false;
        }
        //向下转型
        Person p = (Person) obj;
        return this.name.equals(p.name) && this.age==p.age;
    }
}
```
现在==比较还是false，经过重写equals，equals比较为true

## hashCode
```
import java.util.HashSet;

public class StringTest {
    public static void main(String[] args) {
        Person potato1 = new Person("土豆", 18);
        Person potato2 = new Person("土豆", 18);
        Person person = new Person("地瓜",18);

        HashSet<Person> set = new HashSet<>();
        set.add(potato1);
        set.add(potato2);
        set.add(person);
        System.out.println(set);
    }
}
class Person{
    String name;
    Integer age;

    public Person() {
    }

    public Person(String name, Integer age) {
        this.name = name;
        this.age = age;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    @Override
    public boolean equals(Object obj) {
        //同一个对象，肯定相等，提高效率
        if (this==obj)
            return true;
        //判断该对象是否是该类的一个对象
        if (!(obj instanceof Person)){
            return false;
        }
        //向下转型
        Person p = (Person) obj;
        return this.name.equals(p.name) && this.age==p.age;
    }

    @Override
    public String toString() {
        return name+"---"+age;
    }
}
```
输出结果：
```
[土豆---18, 地瓜---18, 土豆---18]
```
有重复的，去重就要重写hashCode方法
```
import java.util.HashSet;

public class StringTest {
    public static void main(String[] args) {
        Person potato1 = new Person("土豆", 18);
        Person potato2 = new Person("土豆", 18);
        Person person = new Person("地瓜",18);

        HashSet<Person> set = new HashSet<>();
        set.add(potato1);
        set.add(potato2);
        set.add(person);
        System.out.println(set);
    }
}
class Person{
    String name;
    Integer age;

    public Person() {
    }

    public Person(String name, Integer age) {
        this.name = name;
        this.age = age;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    @Override
    public boolean equals(Object obj) {
        //同一个对象，肯定相等，提高效率
        if (this==obj)
            return true;
        //判断该对象是否是该类的一个对象
        if (!(obj instanceof Person)){
            return false;
        }
        //向下转型
        Person p = (Person) obj;
        return this.name.equals(p.name) && this.age==p.age;
    }

    @Override
    public String toString() {
        return name+"---"+age;
    }

    @Override
    public int hashCode() {
        int hashCode = name.toUpperCase().hashCode();
        return hashCode^age;
    }
}
```
运行结果：
```
[地瓜---18, 土豆---18]
```


参考：
https://www.cnblogs.com/skywang12345/p/3324958.html
https://www.cnblogs.com/smyhvae/p/3929585.html

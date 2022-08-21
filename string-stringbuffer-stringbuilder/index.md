# String、StringBuffer、StringBuilder的区别


## 长度是否可变

 - String 是被 final 修饰的，他的长度是不可变的，就算调用 String 的concat 方法，那也是把字符串拼接起来并重新创建一个对象，把拼接后的 String 的值赋给新创建的对象
 - StringBuffer 和 StringBuilder修改本身

## 执行效率
三者在执行速度方面的比较：StringBuilder > StringBuffer > String

## 应用场景
 - 如果要操作少量的数据用 = String
 - 单线程操作字符串缓冲区 下操作大量数据 = StringBuilder
 - 多线程操作字符串缓冲区 下操作大量数据 = StringBuffer

## 线程安全
StringBuilder 类在 Java 5 中被提出，它和 StringBuffer 之间的最大不同在于 StringBuilder 的方法不是线程安全的（不能同步访问），StringBuffer是线程安全的。只是StringBuffer 中的方法大都采用了 `synchronized` 关键字进行修饰，因此是线程安全的，而 StringBuilder 没有这个修饰，可以被认为是线程不安全的。

### 参考
https://www.cnblogs.com/AmyZheng/p/9415064.html

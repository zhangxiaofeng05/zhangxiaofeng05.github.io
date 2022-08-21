# java IO流


![](/mypng/3.png)

# 从控制台输入输出
```
import java.util.Scanner;

public class IoTest {
    public static void main(String args[]){
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        System.out.println(n);

        String s = sc.next();
        System.out.println(s);

        String line = sc.nextLine();
        System.out.println(line);//从控制台输出
    }
}
```

# 字节流
## FileOutputStream
```
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.OutputStream;

public class IoTest {
    public static void main(String args[]){
        File file = new File("aa.txt");
        try {
            //FileOutputStream(File,boolean) 是否把内容追加
            OutputStream out = new FileOutputStream(file);
            String str = "Hello World";
            byte[] b=str.getBytes();
            out.write(b);
            out.close();

        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
```
## FileInputStream
```
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;

public class IoTest {
    public static void main(String args[]){
        try {
            File file = new File("E:"+File.separator+"tt.txt");
            InputStream is = new FileInputStream(file);
//            byte[] bytes = new byte[1024];
            //也可以这样
            byte[] bytes = new byte[(int) file.length()];
            is.read(bytes);
            System.out.println(new String(bytes));
            //关闭流
            is.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
```

## BufferedOutputStream
```
import java.io.*;

public class IoTest {
    public static void main(String args[]){
        File file = new File("aa.txt");
        try {
            OutputStream out = new FileOutputStream(file);
            BufferedOutputStream bos = new BufferedOutputStream(out);
            byte[] bytes = "土豆，土豆，呼叫土豆".getBytes();
            bos.write(bytes);

            //刷新缓存
            bos.flush();

            bos.close();
            out.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
```

## BufferedInputStream
```
import java.io.*;

public class IoTest {
    public static void main(String args[]){
        try {
            File file = new File("E:"+File.separator+"tt.txt");
            InputStream is = new FileInputStream(file);
            BufferedInputStream bis = new BufferedInputStream(is);
            byte[] bytes = new byte[(int) file.length()];
            bis.read(bytes);

            System.out.println(new String(bytes));

            bis.close();
            is.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
```

# 字符流
## FileWriter
```
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;

public class IoTest {
    public static void main(String args[]){
        try {
            File file = new File("aa.txt");
            Writer writer = new FileWriter(file);
            writer.write("土豆。。。\n");
            writer.write("地瓜，对不起");

            writer.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
```
## FileReader
```
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;

public class IoTest {
    public static void main(String args[]){
        try {
            File file = new File("aa.txt");
            Reader reader = new FileReader(file);
            char[] chars = new char[1024];
            reader.read(chars);
            System.out.println(new String(chars));

            reader.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
```

# 转换流(字节流转字符流)
## OutputStreamWriter
```
import java.io.*;

public class IoTest {
    public static void main(String args[]){
        File file = new File("aa.txt");
        try {
            OutputStream out = new FileOutputStream(file);
            OutputStreamWriter osw = new OutputStreamWriter(out);
            osw.write("这是字节流转成了字符流");
            String encoding = osw.getEncoding();
            System.out.println("文件的编码："+encoding); //文件的编码：UTF8
            osw.close();
            out.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
```

## InputStreamReader
```
import java.io.*;

public class IoTest {
    public static void main(String args[]){
        try {
            File file = new File("aa.txt");
            InputStream is = new FileInputStream(file);
            InputStreamReader isr = new InputStreamReader(is,"utf-8");//指定编码
            char[] chars = new char[1024];
            isr.read(chars);
            System.out.println(chars);

            System.out.println("编码："+isr.getEncoding());

            isr.close();
            isr.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
```

# 字符缓冲流(高效流)
## BufferedWriter
```
import java.io.*;

public class IoTest {
    public static void main(String args[]){
        File file = new File("aa.txt");
        try {
            OutputStream out = new FileOutputStream(file);
            OutputStreamWriter osw = new OutputStreamWriter(out);
            BufferedWriter bw = new BufferedWriter(osw);
            bw.write("hello 这是字符缓冲流");
            bw.newLine();
            bw.write("下一行");

            bw.close();
            osw.close();
            out.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
```

## BufferedReader
```
import java.io.*;

public class IoTest {
    public static void main(String args[]){
        try {
            File file = new File("aa.txt");
            InputStream is = new FileInputStream(file);
            InputStreamReader isr = new InputStreamReader(is,"utf-8");
            BufferedReader br = new BufferedReader(isr);
            String str;

            while ((str=br.readLine())!=null){
                System.out.println(str);
            }

            br.close();
            isr.close();
            is.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
```

# 字节流与字符流的区别
 1. 字节流在操作的时候本身是不会用到缓冲区（内存）的，是与文件本身直接操作的，而字符流在操作的时候是使用到缓冲区的

 2. 字节流在操作文件时，即使不关闭资源（close方法），文件也能输出，但是如果字符流不使用close方法的话，则不会输出任何内容，说明字符流用的是缓冲区，并且可以使用flush方法强制进行刷新缓冲区，这时才能在不close的情况下输出内容

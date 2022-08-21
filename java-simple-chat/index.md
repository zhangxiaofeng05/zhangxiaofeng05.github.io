# TCP、UDP简单聊天


# TCP

客户端套接字：Socket
服务端套接字：ServerSocket
TCP（传输控制协议）一种基于连接的通信协议。可靠传输

## Server
```
package com.tcp;

import java.io.*;
import java.net.ServerSocket;
import java.net.Socket;

/**
 * 服务器端
 */
public class Server {
    public static void main(String[] args) {
        ServerSocket serverSocket = null;
        try {
            serverSocket = new ServerSocket(12345);
            System.out.println("服务启动："+serverSocket.getInetAddress().getHostAddress()+":"+serverSocket.getLocalPort());
            Socket accept = serverSocket.accept();
            System.out.println("客户端："+accept.getInetAddress().getHostAddress()+":"+accept.getLocalPort());
            BufferedReader sis = new BufferedReader(new InputStreamReader(System.in));
            BufferedReader is = new BufferedReader(new InputStreamReader(accept.getInputStream()));
            PrintWriter os = new PrintWriter(new OutputStreamWriter(accept.getOutputStream()));
            while (true){
                String line;
                if ((line=is.readLine())!=null){
                    System.out.println("收到客户端："+line);
                    if (line.equals("bye")){
                        break;
                    }else {
                        os.println(sis.readLine());
                        os.flush();
                    }
                }
            }
            is.close();
            os.close();
            accept.close();
        } catch (IOException e) {
            e.printStackTrace();
        }finally {
            try {
                serverSocket.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}
```

## Client
```
package com.tcp;

import java.io.*;
import java.net.Socket;

/**
 * 客户端
 */
public class Client {
    public static void main(String[] args) {
        try {
            Socket socket = new Socket("127.0.0.1",12345);
            BufferedReader sis = new BufferedReader(new InputStreamReader(System.in));
            BufferedReader is = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            PrintWriter os = new PrintWriter(new OutputStreamWriter(socket.getOutputStream()));
            String line;
            while (true){
                if ((line=sis.readLine())!=null){
                    if ("bye".equals(line)){
                        System.exit(0);
                    }
                    os.println(line);
                    os.flush();
                }
                String readLine = is.readLine();
                System.out.println("收到服务端："+readLine);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
```

# UDP
UDP采用Datagram（数据报）传输，数据包是一种尽力而为的传送数据的方式，它只是 把数据的目的地记录在数据包中，然后就直接放在网络上，系统不保证数据是否能安全到达，或者什么时候可以送到，它并不保证传送质量。

Datagram（数据报）是网络层数据单元在介质上传输信息的一种逻辑分组格式，它是一种在网络中传播的、独立的、自身包含地址信息的消息，它能够到达目的地、到达时间、到达时内容是否会变化是不能准确知道的。它的通信双方不需要建立连接，对于一些不需要很高质量的应用程序来说，数据报通信是一个非常好的选择。还有就是对实时性很高的情况，比如在实时音频和视频应用中，数据包的丢失和位置是静态的，是可以被人们所忍受的，这时就可以利用UDP协议传输。

DatagramSocket（数据报套接字）工作包含了3个信息类：DatagramPacket、DatagramSocket和MulticastSocket。DatagramPacket对象描绘了数据报地址信息，DatagramSocket表示客户程序和服务程序报套接字，MulticastSocket描绘了能够进行多点传输的数据报套接字。

## Server
```
package com.udp;

import java.net.DatagramPacket;
import java.net.DatagramSocket;

public class Server {
    public static void main(String[] args) {
        try {
            DatagramSocket socket = new DatagramSocket(12345);
            byte[] bytes = new byte[1024];
            DatagramPacket receivePacket = new DatagramPacket(bytes, bytes.length);
            System.out.println("开始接收包。。。");

            while (true){
                socket.receive(receivePacket);
                String name = receivePacket.getAddress().toString();
                System.out.println("来自主机："+name+"\n端口："+receivePacket.getPort());
                String s = new String(receivePacket.getData(),0,receivePacket.getLength());
                System.out.println("接收到数据："+s);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
```

## Client
```
package com.udp;

import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;

public class Client {
    public static void main(String[] args) {
        try {
            DatagramSocket socket = new DatagramSocket();

            InetAddress host = InetAddress.getByName("localhost");
            String msg = "hello, I'm client";
            DatagramPacket sendPacket = new DatagramPacket(msg.getBytes(),msg.length(),host,12345);
            socket.send(sendPacket);

        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
```

 DatagramSocket只允许数据报发送一个目的地址，MulticastSocket允许数据报以广播的形式发送到该端口的所有客户。

## MultiServer
```
package com.udp;

import java.net.DatagramPacket;
import java.net.InetAddress;
import java.net.MulticastSocket;

public class MultiServer {
    public static void main(String[] args) {
        try {
            MulticastSocket socket = new MulticastSocket(12345);
            InetAddress group = InetAddress.getByName("231.0.0.0");
            socket.joinGroup(group);
            //接收数据报
            for(int i=0;i<100;i++){
                byte[] bytes = new byte[256];
                DatagramPacket receivePacket = new DatagramPacket(bytes, bytes.length);
                socket.receive(receivePacket);

                byte[] bytes1 = new byte[receivePacket.getLength()];
                System.arraycopy(receivePacket.getData(),0,bytes1,0,receivePacket.getLength());
                System.out.println(new String(bytes1));
            }

            socket.leaveGroup(group);
            socket.close();
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
```

## MultiClient
```
package com.udp;

import java.net.DatagramPacket;
import java.net.InetAddress;
import java.net.MulticastSocket;

public class MultiClient {
    public static void main(String[] args) {
        try {
            MulticastSocket socket = new MulticastSocket();
            InetAddress group = InetAddress.getByName("231.0.0.0");

            byte[] bytes = new byte[0];
            DatagramPacket sendPacket = new DatagramPacket(bytes, 0, group, 12345);
            for(int i=0;i<5;i++){
                byte[] bytes1 = ("Data line "+i).getBytes();
                sendPacket.setData(bytes1);
                sendPacket.setLength(bytes1.length);
                socket.send(sendPacket);
            }
            socket.close();

        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
```


 参考：
 https://www.cnblogs.com/benjamin77/p/9147146.html
 https://blog.51cto.com/aku28907/1782137

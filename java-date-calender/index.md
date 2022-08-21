# Java中Date、SimpleDateFormat、Calendar


## jdk1.8

```
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * Java 语言的Date(日期)，Calendar(日历)，DateFormat(日期格式)组成了Java标准的一个基本但是非常重要的部分。
 */
public class StringTest {
    public static void main(String[] args) throws ParseException {
        Date currentTime = new Date();
        System.out.println(currentTime);
        //设置时间格式
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        System.out.println(simpleDateFormat.format(currentTime));

        SimpleDateFormat year = new SimpleDateFormat("yyyy");//获取年----其它类似
        System.out.println(year.format(currentTime));

        Date date = simpleDateFormat.parse("2019-1-23 12:00:00");//把字符串转换成日期
        System.out.println(simpleDateFormat.format(date));

        //计算时间差currentTime-date相差多少天
        Long days = (currentTime.getTime()-date.getTime())/(1000*60*60*24);//参数--毫秒
        System.out.println(days);

        System.out.println("---------------------------利用Calendar获取时间值比较方便");
//        Calendar转化为Date
        Calendar cal=Calendar.getInstance();
        Date date1=cal.getTime();

//        Date转化为Calendar
        Calendar cal2=Calendar.getInstance();
        cal2.setTime(date);
        //计算某个日期是那一年的第几天
        int d = cal2.get(Calendar.DAY_OF_YEAR);
        System.out.println(d);

        //一年的第几周等。。

    }
}
```

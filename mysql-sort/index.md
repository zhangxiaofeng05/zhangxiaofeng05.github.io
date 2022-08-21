# mysql高级排序


## 表和数据
```
CREATE TABLE `sqltest` (
  `id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `age` int(11) NOT NULL,
  `score` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `sqltest` VALUES (1,'土豆',18,100),(2,'地瓜',18,100),(3,'李斯',20,60),(4,'韩非',20,60),(5,'荀子',50,90),(6,'君莫笑',22,80),(7,'寒烟柔',21,80),(8,'包子',26,30),(9,'剑圣',30,0);
```

## 排名(row_number)

 - 按分数排序，拿到名次(成绩相同排名不并列)

SQL:
```
use sqltest;
select st.*,(@rownum:=@rownum+1) as rownum 
from sqltest st,(select @rownum:=0) potato 
order by score;
```

结果：
![](/mypng/4.png)

解释：设置一个伪列@rownum，从1开始计数，依次加1;`(select @rownum:=0) potato `,一定要起别名

注意：这是从小到大排；如果需要从大到小的话，`order by score desc`。

## 排名(Rank)

 - 按分数排序，拿到名次(成绩相同排名并列，有跳数,比如2个100，1个99，排名就是1,1,3)

SQL:
```
use sqltest;
select st.*,@rownum:=@rownum+1 as rownum,
@curnum:=(case when @prescore=st.score then @curnum else @rownum end) as ScoreRank,
@prescore:=st.score as prescore
from sqltest st,(select @rownum:=0,@curnum:=0,@prescore:=null) potato
order by st.score desc;
```

结果：
![](/mypng/5.png)

解释：设置一个伪列@rownum，@curnum就是当前的名次，@prescore记录前一个分数与当前行的分数进行比较，相等就用上一个的排名，不相等就用一直增加的那个数

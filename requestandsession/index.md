# request和Session


|区别|request|session|
|----|----|----|
|描述|一次请求(访问一个url)|一次对话(可以访问多个url)|
|作用|获取信息(表单,查询,cookie等信息)|记录变量(跟踪记录访问者动作)|
|作用端|浏览器|服务器|
|生命周期|提交以后即释放|关闭浏览器或者超出会话时间限制(`maxInactiveIntervalInSeconds`;The session timeout in seconds. By default, it is set to 1800 seconds (30 minutes).)|
|占用资源|比较少|相对较大|
|安全性|比较高|稍微低点|

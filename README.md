#具体内容可以查看我的简书

或者直接使用中有什么问题都可以留言我会抽空查看的

>首先我关于移动端的存储，其实有很多的解决方案，ios端>可以使phlist，UserDefaults，归档，当然还有很多人觉得>难用的CoreData，当然最重要的还有SQLite，SQLite设计>之初就是为了解决小型数据库使用的，轻，便，快。所以
>当然苹果中也可以使用SQLite，所以苹果公司就为我们封
>装了,CoreData这个api为了方便开发者的使用,但是有很多人却觉得不怎么好用，也可能是因为，对接触过数据库操作的人来说相应的查询等语句会更加的亲切好用。

>这里我就不讨论CoreData了，因为最近正在研究CoreData，因为苹果自己很多的应用使用的是CoreData，我觉得难用的东西一但会用了，就能够事半功倍了。

-----------------
不多这次就先说下SQLite--一个普遍的移动端数据持久化数据库。
>首先说下SQLite:
虽然苹果为我们提供了CoreData但我们也可以使用比较低层的SQLite.
在swift中如何使用呢？（swift3.0）
首先也要引入库libsqlite3.0.tbd由于swift中要使用oc先要引入头文件。所以这次我就用桥接文件直接把所有的引用放在桥接文件.h中

![SQLite](http://upload-images.jianshu.io/upload_images/2193807-2f6c83a1882541e5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

这样我们就能直接在swift使用SQLite了。在使用之前，基本的SQLite语法还是要了解的，这个只要百度，谷歌搜索就能找到很多，我在这里只是介绍一些比较常用的
```
//OpaquePointer: *db,数据库句柄，跟文件句柄FIFL类似，这里是sqlite3指针；
//sqlite3_stmt: *stmt,相当于ODBC的Command对象，用于保存编译好的SQL语句；
//sqlite3_open(): 打开数据库，没有数据库时创建；
//sqlite3_exec(): 执行非查询的SQL语句；
//sqlite3_step(): 在调用sqlite3_prepare后，使用这个函数在记录集中移动；
//sqlite3_close()：关闭数据库文件；
//sqlite3_column_text()：取text类型的数据；
//sqlite3_column_blob()：取blob类型的数据；
//sqlite3_column_int()：取int类型的数据
```




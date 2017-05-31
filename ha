hadoop dfs -mkdir /data1/databases/table

hadoop dfs -put table.txt  /data1/databases/table


CREATE EXTERNAL TABLE table(
id int COMMENT '自动编号',
) COMMENT '用户关注表'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
STORED AS TEXTFILE
LOCATION '/data1/databases/cmailbox_temp';




#--------常用命令--------------#

#查看目录
hadoop dfs -ls /

#创建目录
hadoop dfs -mkdir /home

#创建一个空文件
hadoop dfs -touchz /361way

#删除一个文件
hadoop dfs -rm /361way

#删除一个目录
hadoop dfs -rmr /home

#重命名
hadoop dfs -mv /hello1 /hello2

#查看文件
hadoop dfs -cat /hello

#将制定目录下的所有内容merge成一个文件，下载到本地
hadoop dfs -getmerge /hellodir wa


#使用du文件和目录大小
hadoop dfs -du /

#将目录拷贝到本地
hadoop dfs -copyToLocal  /home localdir

#查看dfs的情况
hadoop dfsadmin -report


#上传文件或目录到hdfs
hadoop dfs -put hello /
hadoop dfs -put hellodir/ /



#-------------显示命令---------------------#


•show tables;
•show databases;
•show partitions; 查看分区
•show functions;
•describe extended table_name dot col_name



#-------------数据库------------------#

#创建库
hive>create  database  if  not  exists  financials ;

#查询数据
hive>show  databases  like  " f . * " ;

#删除数据库：
hive> drop database if exists human_resources;

#使用数据库
hive> use my_db;

#--------------表--------------------#

http://www.cnblogs.com/1130136248wlxk/articles/5515365.html
http://www.cnblogs.com/1130136248wlxk/articles/5516343.html
字段类型
http://blog.csdn.net/wind520/article/details/39210067

字段类型

a.基本数据类型
TINYINT: 1个字节
SMALLINT: 2个字节
INT: 4个字节   
BIGINT: 8个字节
BOOLEAN: TRUE/FALSE  
FLOAT: 4个字节，单精度浮点型
DOUBLE: 8个字节，双精度浮点型
STRING       字符串

b.复杂数据类型
ARRAY: 有序字段
MAP: 无序字段
STRUCT: 一组命名的字段

4.表类型
hive表大致分为普通表、外部表、分区表三种。


CREATE TABLE test_db.pokes (foo INT, bar STRING COMMENT 'This is bar'); 




#表详情
hive> desc my_table;
hive> desc extended my_tables;

#创建表#

CREATE EXTERNAL TABLE my_table (

id INT,

ip STRING COMMENT '访问者IP',

avg_view_depth DECIMAL(5,1),

bounce_rate DECIMAL(6,5)

) COMMENT '表注释'

PARTITIONED BY (day STRING)  

ROW FORMAT DELIMITED

FIELDS TERMINATED BY ','

STORED AS textfile

LOCATION 'hdfs://cdh5/tmp/lxw1234/';

----
	【EXTERNAL】表示该表为外部表，如果不指定EXTERNAL关键字，则表示内部表

	【COMMENT】为表和列添加注释

	【PARTITIONED BY】表示该表为分区表，分区字段为day,类型为string

	【ROW FORMAT DELIMITED】指定表的分隔符，通常后面要与以下关键字连用：

	FIELDS TERMINATED BY ',' //指定每行中字段分隔符为逗号

	LINES TERMINATED BY '\n' //指定行分隔符

	COLLECTION ITEMS TERMINATED BY ',' //指定集合中元素之间的分隔符

	MAP KEYS TERMINATED BY ':' //指定数据中Map类型的Key与Value之间的分隔符

	举个例子：

	create table score(name string, score map<string,int>)

	ROW FORMAT DELIMITED

	FIELDS TERMINATED BY '\t'

	COLLECTION ITEMS TERMINATED BY ','

	MAP KEYS TERMINATED BY ':';

	要加载的文本数据为：

	biansutao '数学':80,'语文':89,'英语':95

	jobs '语文':60,'数学':80,'英语':99

	【STORED AS】指定表在HDFS上的文件存储格式，可选的文件存储格式有：

	TEXTFILE //文本，默认值

	SEQUENCEFILE // 二进制序列文件

	RCFILE //列式存储格式文件 Hive0.6以后开始支持

	ORC //列式存储格式文件，比RCFILE有更高的压缩比和读写效率，Hive0.11以后开始支持

	PARQUET //列出存储格式文件，Hive0.13以后开始支持

	【LOCATION】指定表在HDFS上的存储位置。
----

#----导入数据-----#

创建表
hive> create table tb_person(id int, name string);

创建表并创建分区字段ds
hive> create table tb_stu2(id int, name string) partitioned by(ds string) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' ;

/root/1.txt
1,zhangsan
2,lisi
3,wangwu

#将文件中的数据加载到表中
hive> load data local inpath '/root/1.txt' overwrite into table tb_person;

#加载本地数据，同时给定分区信息
hive> load data local inpath '/root/1.txt' overwrite into table tb_stu partition (ds='2008-08-15');


【外部表】
external关键字可以让用户创建一个外部 表，在建表的同时指定一个指向实际数据的路径(location)，hive创建内部表时，会将数据移动到数据仓库指向的路径；若创建外部表，仅记录数据 所在的路径，不对数据的位置做任何改变。在删除表的时候，内部表的元数据和数据会被一起删除，而外部表只删除元数据，不删除数据。
eg. 创建外部表：

create external table tb_record(col1 string, col2 string) row format delimited fields terminated by '\t' location '/user/hadoop/input'


【查询】

http://www.cnblogs.com/1130136248wlxk/articles/5515426.html
http://www.cnblogs.com/HondaHsu/p/4346354.html


#----------shell----------------#


Shell 变量

    首个字符必须为字母（a-z，A-Z）。
    中间不能有空格，可以使用下划线（_）。
    不能使用标点符号。
    不能使用bash里的关键字（可用help命令查看保留关键字）。

your_name="qinjx"
echo $your_name
echo ${your_name}

#只读变量
myUrl="http://www.w3cschool.cc"
readonly myUrl

#删除变量
unset variable_name

#拼接字符串 
your_name="qinjx"
greeting="hello, "$your_name" !"
greeting_1="hello, ${your_name} !"
echo $greeting $greeting_1

#获取字符串长度 
string="abcd"
echo ${#string} #输出 4

#提取子字符串 
string="runoob is a great site"
echo ${string:1:4} # 输出 unoo

#查找子字符串 
查找字符 "i 或 s" 的位置
string="runoob is a great company"
echo `expr index "$string" is`  # 输出 8


Shell 数组 (bash支持一维数组（不支持多维数组），并且没有限定数组的大小。)


在Shell中，用括号来表示数组，数组元素用"空格"符号分割开。定义数组的一般形式为： 


数组名=(值1 值2 ... 值n)

array_name=(
value0
value1
value2
value3
)

array_name[0]=value0

#读取数组 
valuen=${array_name[n]}
#使用@符号可以获取数组中的所有元素
echo ${array_name[@]}

#获取数组的长度

# 取得数组元素的个数
length=${#array_name[@]}
# 或者
length=${#array_name[*]}
# 取得数组单个元素的长度
lengthn=${#array_name[n]}

$ ./test.sh 1 2 3
echo "Shell 传递参数实例！"; 
echo "执行的文件名：$0"; 执行的文件名：./test.sh
echo "第一个参数为：$1"; 第一个参数为：1
echo "第二个参数为：$2"; 第二个参数为：2
echo "第三个参数为：$3"; 第三个参数为：3


$# 	传递到脚本的参数个数
$* 	以一个单字符串显示所有向脚本传递的参数。
	如"$*"用「"」括起来的情况、以"$1 $2 … $n"的形式输出所有参数。
$$ 	脚本运行的当前进程ID号
$! 	后台运行的最后一个进程的ID号
$@ 	与$*相同，但是使用时加引号，并在引号中返回每个参数。
	如"$@"用「"」括起来的情况、以"$1" "$2" … "$n" 的形式输出所有参数。
$- 	显示Shell使用的当前选项，与set命令功能相同。
$? 	显示最后命令的退出状态。0表示没有错误，其他任何值表明有错误。


echo "-- \$* 演示 ---"
for i in "$*"; do
    echo $i
done

echo "-- \$@ 演示 ---"
for i in "$@"; do
    echo $i
done


$ chmod +x test.sh 
$ ./test.sh 1 2 3
-- $* 演示 ---
1 2 3
-- $@ 演示 ---
1
2
3


关系运算符 (关系运算符只支持数字，不支持字符串，除非字符串的值是数字)

-eq 	检测两个数是否相等，相等返回 true。 					[ $a -eq $b ] 返回 false。
-ne 	检测两个数是否相等，不相等返回 true。 					[ $a -ne $b ] 返回 true。
-gt 	检测左边的数是否大于右边的，如果是，则返回 true。 		[ $a -gt $b ] 返回 false。
-lt 	检测左边的数是否小于右边的，如果是，则返回 true。 		[ $a -lt $b ] 返回 true。
-ge 	检测左边的数是否大等于右边的，如果是，则返回 true。 	[ $a -ge $b ] 返回 false。
-le 	检测左边的数是否小于等于右边的，如果是，则返回 true。 	[ $a -le $b ] 返回 true。

布尔运算符

! 	非运算，表达式为 true 则返回 false，否则返回 true。 	[ ! false ] 返回 true。
-o 	或运算，有一个表达式为 true 则返回 true。 				[ $a -lt 20 -o $b -gt 100 ] 返回 true。
-a 	与运算，两个表达式都为 true 才返回 true。 				[ $a -lt 20 -a $b -gt 100 ] 返回 false。

逻辑运算符

&& 	逻辑的 AND 	[[ $a -lt 100 && $b -gt 100 ]] 返回 false
|| 	逻辑的 OR 	[[ $a -lt 100 || $b -gt 100 ]] 返回 true

字符串运算符

= 	检测两个字符串是否相等，相等返回 true。 	[ $a = $b ] 返回 false。
!= 	检测两个字符串是否相等，不相等返回 true。 	[ $a != $b ] 返回 true。
-z 	检测字符串长度是否为0，为0返回 true。 		[ -z $a ] 返回 false。
-n 	检测字符串长度是否为0，不为0返回 true。 	[ -n $a ] 返回 true。
str 	检测字符串是否为空，不为空返回 true。 	[ $a ] 返回 true。

文件测试运算符

-b file 	检测文件是否是块设备文件，如果是，则返回 true。 	[ -b $file ] 返回 false。
-c file 	检测文件是否是字符设备文件，如果是，则返回 true。 	[ -c $file ] 返回 false。
-d file 	检测文件是否是目录，如果是，则返回 true。 	[ -d $file ] 返回 false。
-f file 	检测文件是否是普通文件（既不是目录，也不是设备文件），如果是，则返回 true。 	[ -f $file ] 返回 true。
-g file 	检测文件是否设置了 SGID 位，如果是，则返回 true。 	[ -g $file ] 返回 false。
-k file 	检测文件是否设置了粘着位(Sticky Bit)，如果是，则返回 true。 	[ -k $file ] 返回 false。
-p file 	检测文件是否是具名管道，如果是，则返回 true。 	[ -p $file ] 返回 false。
-u file 	检测文件是否设置了 SUID 位，如果是，则返回 true。 	[ -u $file ] 返回 false。
-r file 	检测文件是否可读，如果是，则返回 true。 	[ -r $file ] 返回 true。
-w file 	检测文件是否可写，如果是，则返回 true。 	[ -w $file ] 返回 true。
-x file 	检测文件是否可执行，如果是，则返回 true。 	[ -x $file ] 返回 true。
-s file 	检测文件是否为空（文件大小是否大于0），不为空返回 true。 	[ -s $file ] 返回 true。
-e file 	检测文件（包括目录）是否存在，如果是，则返回 true。 	[ -e $file ] 返回 true。

file="/var/www/runoob/test.sh"
if [ -r $file ]
then
   echo "文件可读"
else
   echo "文件不可读"
fi
if [ -w $file ]
then
   echo "文件可写"
else
   echo "文件不可写"
fi
if [ -x $file ]
then
   echo "文件可执行"
else
   echo "文件不可执行"
fi
if [ -f $file ]
then
   echo "文件为普通文件"
else
   echo "文件为特殊文件"
fi
if [ -d $file ]
then
   echo "文件是个目录"
else
   echo "文件不是个目录"
fi
if [ -s $file ]
then
   echo "文件不为空"
else
   echo "文件为空"
fi
if [ -e $file ]
then
   echo "文件存在"
else
   echo "文件不存在"
fi


Shell test命令

数值测试

-eq 	等于则为真
-ne 	不等于则为真
-gt 	大于则为真
-ge 	大于等于则为真
-lt 	小于则为真
-le 	小于等于则为真

num1=100
num2=100
if test $[num1] -eq $[num2]
then
    echo '两个数相等！'
else
    echo '两个数不相等！'
fi

字符串测试
= 	等于则为真
!= 	不相等则为真
-z 字符串 	字符串的长度为零则为真
-n 字符串 	字符串的长度不为零则为真

num1="runoob"
num2="runoob"
if test num1=num2
then
    echo '两个字符串相等!'
else
    echo '两个字符串不相等!'
fi

文件测试

-e 文件名 	如果文件存在则为真
-r 文件名 	如果文件存在且可读则为真
-w 文件名 	如果文件存在且可写则为真
-x 文件名 	如果文件存在且可执行则为真
-s 文件名 	如果文件存在且至少有一个字符则为真
-d 文件名 	如果文件存在且为目录则为真
-f 文件名 	如果文件存在且为普通文件则为真
-c 文件名 	如果文件存在且为字符型特殊文件则为真
-b 文件名 	如果文件存在且为块特殊文件则为真

cd /bin
if test -e ./bash
then
    echo '文件已存在!'
else
    echo '文件不存在!'
fi

【流程】

if condition1
then
    command1
elif condition2 
then 
    command2
else
    commandN
fi


num1=$[2*3]
num2=$[1+5]
if test $[num1] -eq $[num2]
then
    echo '两个数字相等!'
else
    echo '两个数字不相等!'
fi


for var in item1 item2 ... itemN
do
    command1
    command2
    ...
    commandN
done

for loop in 1 2 3 4 5
do
    echo "The value is: $loop"
done

echo '输入 1 到 4 之间的数字:'
echo '你输入的数字为:'
read aNum
case $aNum in
    1)  echo '你选择了 1'
    ;;
    2)  echo '你选择了 2'
    ;;
    3)  echo '你选择了 3'
    ;;
    4)  echo '你选择了 4'
    ;;
    *)  echo '你没有输入 1 到 4 之间的数字'
    ;;
esac

无限循环
while :
do
    echo -n "输入 1 到 5 之间的数字: "
    read aNum
    case $aNum in
        1|2|3|4|5) echo "你输入的数字为 $aNum!"
        ;;
        *) echo "你输入的数字不是 1 到 5 之间的!"
            continue
            echo "游戏结束"
        ;;
    esac
done


函数

demoFun(){
    echo "这是我的第一个 shell 函数!"
}
echo "-----函数开始执行-----"
demoFun
echo "-----函数执行完毕-----"

funWithParam(){
    echo "第一个参数为 $1 !"
    echo "第二个参数为 $2 !"
    echo "第十个参数为 $10 !"
    echo "第十个参数为 ${10} !"
    echo "第十一个参数为 ${11} !"
    echo "参数总数有 $# 个!"
    echo "作为一个字符串输出所有参数 $* !"
}
funWithParam 1 2 3 4 5 6 7 8 9 34 73

注意，$10 不能获取第十个参数，获取第十个参数需要${10}。当n>=10时，需要使用${n}来获取参数。

另外，还有几个特殊字符用来处理参数：
参数处理 	说明
$# 	传递到脚本的参数个数
$* 	以一个单字符串显示所有向脚本传递的参数
$$ 	脚本运行的当前进程ID号
$! 	后台运行的最后一个进程的ID号
$@ 	与$*相同，但是使用时加引号，并在引号中返回每个参数。
$- 	显示Shell使用的当前选项，与set命令功能相同。
$? 	显示最后命令的退出状态。0表示没有错误，其他任何值表明有错误。


重定向

command > file 	将输出重定向到 file。
command < file 	将输入重定向到 file。
command >> file 	将输出以追加的方式重定向到 file。
n > file 	将文件描述符为 n 的文件重定向到 file。
n >> file 	将文件描述符为 n 的文件以追加的方式重定向到 file。
n >& m 	将输出文件 m 和 n 合并。
n <& m 	将输入文件 m 和 n 合并。
<< tag 	将开始标记 tag 和结束标记 tag 之间的内容作为输入。

command > /dev/null 2>&1

注意：0 是标准输入（STDIN），1 是标准输出（STDOUT），2 是标准错误输出（STDERR）。

#Shell 文件包含

#使用 . 号来引用test1.sh 文件
. ./test1.sh

# 或者使用以下包含文件代码
# source ./test1.sh

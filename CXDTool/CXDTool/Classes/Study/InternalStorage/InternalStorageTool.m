//
//  InternalStorageTool.m
//  CXDTool
//
//  Created by 蔡晓东 on 2019/7/8.
//  Copyright © 2019 claudechoi. All rights reserved.
//

#import "InternalStorageTool.h"

@implementation InternalStorageTool
/**
 1.栈区(stack)  由编译器自动分配并释放，存放函数的参数值，局部变量等。栈是系统数据结构，对应线程/进程是唯一的。
 优点是快速高效，缺点时有限制，数据不灵活。［先进后出］
 
 栈空间分静态分配 和动态分配两种。
 静态分配是编译器完成的，比如自动变量(auto)的分配。
 动态分配由alloca函数完成。
 栈的动态分配无需释放(是自动的)，也就没有释放函数。
 为可移植的程序起见，栈的动态分配操作是不被鼓励的！
 
 2.堆区(heap)  由程序员分配和释放，如果程序员不释放，程序结束时，可能会由操作系统回收 ，比如在ios 中 alloc 都是存放在堆中。
 优点是灵活方便，数据适应面广泛，但是效率有一定降低。［顺序随意］
 堆是函数库内部数据结构，不一定唯一。
 不同堆分配的内存无法互相操作。
 堆空间的分配总是动态的
 虽然程序结束时所有的数据空间都会被释放回系统，但是精确的申请内存，释放内存匹配是良好程序的基本要素。
 
 3.全局区(静态区) (static)   全局变量和静态变量的存储是放在一起的，初始化的全局变量和静态变量存放在一块区域，未初始化的全局变量和静态变量在相邻的另一块区域，程序结束后有系统释放。
 注意：全局区又可分为未初始化全局区：
 .bss段和初始化全局区：data段。
 举例：int a;未初始化的。int a = 10;已初始化的。
 例子代码：
 int a = 10;  全局初始化区
 char *p;  全局未初始化区
 例子：
 main{
 int b; 栈区
 char s[] = "abc" 栈
 char *p1; 栈
 char *p2 = "123456";  123456\\\\0在常量区，p2在栈上。
 static int c =0； 全局（静态）初始化区
 
 w1 = (char *)malloc(10);
 w2 = (char *)malloc(20);
 分配得来得10和20字节的区域就在堆区。
 }
 
 4.文字常量区 存放常量字符串，程序结束后由系统释放
 
 5.程序代码区 存放函数的二进制代码
 
 二、申请后的系统响应
 
 
 栈：存储每一个函数在执行的时候都会向操作系统索要资源，栈区就是函数运行时的内存，栈区中的变量由编译器负责分配和释放，内存随着函数的运行分配，随着函数的结束而释放，由系统自动完成。
 注意：只要栈的剩余空间大于所申请空间，系统将为程序提供内存，否则将报异常提示栈溢出。
 
 堆：
 1.首先应该知道操作系统有一个记录空闲内存地址的链表。
 2.当系统收到程序的申请时，会遍历该链表，寻找第一个空间大于所申请空间的堆结点，然后将该结点从空闲结点链表中删除，并将该结点的空间分配给程序。
 3 .由于找到的堆结点的大小不一定正好等于申请的大小，系统会自动的将多余的那部分重新放入空闲链表中
 
 三、 申请大小的限制
 
 栈：栈是向低地址扩展的数据结构，是一块连续的内存的区域。是栈顶的地址和栈的最大容量是系统预先规定好的，栈的大小是2M（也有的说是1M，总之是一个编译时就确定的常数 ) ,如果申请的空间超过栈的剩余空间时，将提示overflow。因此，能从栈获得的空间较小。
 
 堆：堆是向高地址扩展的数据结构，是不连续的内存区域。这是由于系统是用链表来存储的空闲内存地址的，自然是不连续的，而链表的遍历方向是由低地址向高地址。堆的大小受限于计算机系统中有效的虚拟内存。由此可见，堆获得的空间比较灵活，也比较大。

 
 
 栈：由系统自动分配，速度较快，不会产生内存碎片
 堆：是由alloc分配的内存，速度比较慢，而且容易产生内存碎片，不过用起来最方便
 打个比喻来说：
 使用栈就象我们去饭馆里吃饭，只管点菜（发出申请）、付钱、和吃（使用），吃饱了就走，不必理会切菜、洗菜等准备工作和洗碗、刷锅等扫尾工作，他的好处是快捷，但是自由度小。
 使用堆就象是自己动手做喜欢吃的菜肴，比较麻烦，但是比较符合自己的口味，而且自由度大。
 
 作者：Liwjing
 链接：https://www.jianshu.com/p/f3c1b920e8eb
 来源：简书
 简书著作权归作者所有，任何形式的转载都请联系作者获得授权并注明出处。
 
 */
@end

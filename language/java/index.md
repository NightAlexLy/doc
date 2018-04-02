---
title: Java
---

## JDK1.7 新特性

　　OpenJDK中的[Coin](http://openjdk.java.net/projects/coin/) 项目目的是维护对Java语言所做的语言增强。          

- switch中使用字符串        
　　Java1.7之前，switch中的条件表达式的类型只能与整数型兼容的类型。           
　　　比如基本类型char、byte、short和int.还有这些基本类型对应的封装类。        
　　　另外还有一个枚举类           
　　问题：    
　　　1.如果表达式的值为null，会抛出NPE（NullPointerException）         
　　　2.如果case的值为null，编译是无法通过的。           
　　　3.如果case的值是相等的，编译也是无法通过的。比如“男”和“\u7537"       
　　新特性是在编译器层次实现的，而在Java虚拟机和字节代码这个层次上，还是只支持在switch语句中使用与整数类型兼容的类型。这样做的目的是为了减少这个特性所影响的范围，以降低实现的代价。      
　　OpenJDK中String比较实现。先会利用哈希函数将字符串转换为哈希值，利用hash值来swtich选择哪个条件，不过在哈希值里面回去用if判断传入的值和case的值是否相等。因为哈希函数在映射的时候可能存在冲突，多个字符串的哈希值可能是一样的。             
　　如果在switch中使用字符串作为表达式，建议考虑用枚举类型进行替换。           
- 数值字面量的改进      
  - 二进制整形字面量         
　　　Java1.7之前所支持的进制包括十进制、八进制和十六进制。十进制是默认使用的进制。八进制是用在整数字面量之前添加“0”来表示，而十六进制则是用在整数字面之前添加“0x”或“0X”来表达。而Java7中增加了一种可以在字面量中使用的进制，即二进制。二进制通过在数字前面添加“0b”或者“0B”来表示。              
  - 在数值字面量中使用下划线           
　　　数值字面中用下划线来分割。最基本的原则是下划线只能出现在数字中间。     
　　　比如：100_000_000  ,编译过程中将下划线删除。         
- 优化的异常处理
　　两个重要的改动：        
　　　1.支持在一个catch子句中同时捕获多个异常。
　　　2.在捕获并重新抛出异常时的异常类型更加精确。
   - 异常的基础知识
　　　Java基本的异常处理是围绕try-catch-finally、throws和throw这几个关键词展开的，             
　　　throws用来声明一个方法可能抛出的异常，对方法体中可能抛出的异常都要进行声明；                  
　　　throw用来在遇到错误的时候抛出一个具体的异常。                      
　　　try-catch-finally用来捕获异常并进行处理。         
   - 受检异常和非受检异常           
　　　受检异常（checked exception）和非受检异常（unchecked exception）。非受检异常指的是java.lang.RuntimeException和java.lang.Error类 及其子类，所有其他的异常都成为受检异常。两种类型的异常在作用上并没有差别。唯一的差别就在于使用受检异常时的合法性要在编译时刻由编译器来检查。            
  - 异常声明是API的一部分                
　　　对于API的设计者来说，谨慎考虑每个公开方法所声明的异常是很有必要的。        
  - 创建自已的异常             
     - 精心设计异常的层次结构            
　　　　在使用异常包装的时候，一个典型的做法就是为每个层次定义一个基本的异常类。           
     - 异常类中包含足够的信息                        
　　　　提供给用户更加具体的出错信息以及更加明确的解决方案                
     - 异常与错误提示                         
　　　　比如国际化的异常信息提示                      
  - 处理异常        
　　　　“消失的异常”：比如后抛出的异常把前面的异常覆盖。 这种问题的两种解决办法：一种是抛出try语句块中产生的原是异常。第二种是把所有的异常信息都记录起来。          
- try-with-resources语句
　　　使用try语句进行资源管理的新用法。原则：谁申请，谁释放。            
　　　开发人员只需要关心使用资源的业务逻辑即可。资源的申请是在try子句中进行的，而资源的释放则是自动完成的。          
　　　能够被try语句所管理的资源需要满足一个条件。那就是其Java类要实现java.lang.AutoCloseable接口，否则会出现编译错误。最常用的就是与I/O操作和数据库相关的接口。      
　　　try-with-resources还可以对多个资源进行管理。
- 优化边长参数的方法调用
　　　J2SE 5.0中引入的一个新特性就是允许在方法声明中使用可变长度的参数。一个方法的最后一个形式参数可以被指定为代表任意多个相同类型的参数。          
　　　如果参数传递的是不可具体化（non-reifiabe）的类型，如果List<String>这样的泛型类型，会产生警告信息。          
　　　可变长度的方法参数的实际值是通过数组来传递的，而数组中存储的是不可具体化的泛型对象，自身存在类型安全问题。                  
　　　Java 7 引入一个新的注解**@SafeVarargs**。如果开发人员确信某个使用了可变长度参数的方法，在与泛型类一起使用时不会出现类型安全问题，就可以用这个注解进行声明。           
## Java语言的动态性
　　　Java语言是一种静态类型（指在编译时进行类型检查）的编程语言。Java必须对每个变量的类型都要显示声明。          
　　　4个部分：             
　　　　　1.Java 6中引入的脚本语言支持API            
　　　　　2.运行时检查程序内部接口和直接调用方法的反射API            
　　　　　3.运行时实现接口的动态代理                
　　　　　4.Java7中引入Java虚拟机级别实现的动态语言支持和方法句柄             
- 脚本语言支持API                 
　　　　很多脚本语言都可以运行在Java虚拟机上。比如JavaScript、JRuby、Jython和Groovy等。    
　　　　比如一个应用程序可以用不同语言实现的组件结合起来。比如Groovy来编写界面，用Java编写核心业务逻辑，用Ruby进行数据处理。                
　　　　[JSR 223](https://www.jcp.org/en/jsr/detail?id=223)中规范了在虚拟机上运行的脚本语言与Java程序之间的交互方式。Java标准API中的包是javax.script。         
   - 脚本引擎               
　　　一段脚本的执行需要由该脚本语言对应的脚本引擎来完成。Java 6中自带了JavaScript语言的脚本引擎，是基于Mozilla的Rhino来实现的。其他语言的脚本引擎需要下载并放置程序的类路径中。                  
   - 语言绑定                 
　　　脚本支持API的优势：规范了Java语言与脚本之间的交互方式，使Java语言编写的程序可以与脚本之间进行双向的方法调用和数据传递。                        
　　　数据传递是通过语言绑定对象来完成的。javax.script.Bindings定义了语言绑定对象的接口，继承于java.util.Map接口。              
   - 脚本执行上下文            
　　　javax.script.ScriptContext包含脚本引擎执行过程中的相关上下文信息。可以与Java EE中servlet规范中javax.servlet.ServletContext进行劣币。主要包含以下3类信息：         
　　　　1.输入与输出            
　　　　2.自定义属性           
　　　　3.语言绑定对象                      
   - 脚本的编译            
　　　脚本语言一般是解释执行的。脚本引擎在运行时需要县解析脚本之后在执行。通过教师执行的方式来运行脚本的速度比编译之后在运行会慢一些。当一段脚本需要被多次重复执行时，可以先对脚本进行编译，可以提供执行效率。不是所有的脚本引擎都支持对脚本进行编译，如果支持这一特性，它会实现javax.script.Compilable接口类声明这一点。           
   - 方法调用                    
　　　在脚本中，最常见和最实用的就是方法。有些脚本引擎允许使用者单独调用脚本中的某一个方法。支持这种方法调用方式的脚本引擎可以实现javax.script.Invocable接口。       
　　　ScriptEngine对于Invocable接口的实现是可选的。                   
- 反射API                 
　　　反射API是Java语言本身提供的动态支持。通过反射API可以获取Java程序在运行时刻的内部结构。                            
　　　反射API在为Java程序带来灵活性的同事，也产生了额外的性能代价。在某些对性能要求比较高的应用中，要慎用反射API。                        
   - 获取构造方法        
　　　getConstructor、getDeclaredConstructors、getDeclaredConstructor         
   - 获取域            
　　　getFields、getField、getDeclaredFields、getDeclaredField          
   - 获取方法           
　　　getMethods、getMethod、getDeclaredMethods、getDeclaredMethod          
   - 操作数组            
 　　　java.lang.reflect.Array           
   - 访问权限与异常处理           
 　　　Constructor、Field和Method都集成自java.lang.reflect.AccessibleObject，其中setAccessible可以用来设置是否绕开默认的权限检查。           
  　　　再利用invok方法来调用方法时，如果方法本身抛出了异常，invoke方法会抛出InvocationTargetException异常来表示这种异常，通过getCause方法可以获取到真正的异常信息，帮助进行调试。           
- 动态代理         
  　　　通过使用动态代理，可以在运行时动态创建出多个Java接口的代理类及其对象实例。强大之处在于可以在运行时动态实现多个接口，而不需要源码中通过implements关键词来声明。通过动态代理可以实现面向切面编程（AOP）中常见的方法拦截功能。          
   - 基本使用方式        
  　　　两个要素：第一个是要代理的接口，另一个就是处理接口方法调用java.lang.reflect.InvocationHandler接口。动态代理只支持接口，一般的Java类是不行的。如果要代理的接口不是公开的，被代理的接口和创建动态代理的代码必须在同一个包中。             
  　　　Proxy.newProxyInstance方法来直接创建动态代理对象。通过Proxy.getProxyClass方法来首先获取到代理类。Proxy.isProxy方法来判断是否为代理类。               
    　　在通过动态代理对象来调用Object类声明的equals、hashCode和toString等方法的时候，这个调用也会被传递给InvocationHandler中的invoke方法。         
- 动态语言支持              
  　　　Java7的一个重要的新特性。在于它对Java虚拟机规范的修改，而不是对Java语言规范的修改。涉及的内容包括Java虚拟机中新的方法调用指令invokedynamic,以及Java SE7核心中的java.lang.invoke包。修改内容包含在JSR 292中。           
## Java7其他重要更新             
- 关系数据库访问             
   - 使用try-with-resources语句
  　　　Java7中，java.sql.Connection、java.sql.Statement和java.sql.ResultSet接口都实现了java.lang.AutoCloseable接口，以支持由try-with-resources语句来管理。
   - 数据库查询的默认模式
  　　　大部分关系数据库系统都支持为数据库中包含的表和其他对象创建一个额外的名称空间，即模式（Schema）。一个模式中可以包含表、视图以及其他对象。JDBC4.1为Connection接口添加了一对新的方法getSchema和setSchema用来获取和设置数据库操作时使用的默认模式名称。当通过setSchema进行设置之后，在SQL语句中就不需要使用模式名称作为前缀了。                
   - 数据库连接超时时间与终止
  　　　setNetworkTimeout用来设置通过此数据库连接进行数据库操作时的超时等待时间。      
  　　　与setNetworkTimeout相关的方法abort用来强制关闭一个数据库连接。
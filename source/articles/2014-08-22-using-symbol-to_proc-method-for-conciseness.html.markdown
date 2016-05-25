---
title: ruby迭代map简便写法的实现原理
date: 2014-08-22 08:37 UTC
tags: Ruby
online: true
---
##简便方法的用法

现有一个字符串列表，需要对其中的每个字符串执行转换大写操作，我们可以用一个简便写法来完成。

```ruby
name_list = ["chareice", "angel"]
name_list.map(&:upcase)
# => ["CHAREICE", "ANGEL"]
```
这个写法等同于

```ruby
name_list.map do {|name| name.upcase}
```

简便写法带来的是很明显的效率提升，可是这看似魔术一般的参数，背后的原理是怎样的呢？

## &符号

如果把上面方法调用的`&`符号去掉，可以很明显得看到，是把`:upcase`这个符号传到方法中，作为方法的参数。

实际上，`&`符号代表的是__块转变为Proc(block-to-proc conversion)__。我们看下面的一个例子。

```ruby
def capture_block(&block)
  block.call
end

capture_block { puts "我有一只小毛驴，我从来也不骑。" }
# => 我有一只小毛驴，我从来也不骑。
```

我们运行`capture_block`函数，给它传递一个代码块，代码块会经`&`符号的转换变为一个`Proc`对象传递到函数中，在上面的例子中就是`block`变量。如果我们输出一下`block`的class，输出的结果会是`Proc`。

你也可以将一个`Proc`对象传递给`capture_block`来代替代码块.

```ruby
p = Proc.new { puts "又给一只小毛驴" }
capture_block(&p)
# => 又给一只小毛驴
```

这里看来`&`符号是多余的，完全可以去掉`&`，运行的结果也是一样。

### `&`符号做了什么?

以`capture_block(&p)`调用为例。

1. 触发`p`的`to_proc`方法。
2. 告诉Ruby解释器，将`to_proc`方法返回的结果当做本次函数调用的`block`。

如果同时使用了`&`符号和传入了`block`给一个函数，Ruby会报错。

```ruby
capture_block(&p) { puts "传给一个block" }
#=>SyntaxError: (irb):30: both block arg and actual block given
```

所以将一个Proc对象传给`&`符号，它会调用Proc对象的`to_proc`方法，返回它自己，然后把它当做方法调用的`block`传递给方法。

### `&:upcase`是什么?

知道了`&`符号的作用后，我们可以看到，`&:upcase`是先调用了`:upcase`对象的`to_proc`方法。

`:upcase`的`to_proc`方法实现如下:

```ruby
class Symbol
  def to_proc
    Proc.new {|obj| obj.send(self) }
  end
end
```

这下结果就很清楚了，`Symbol#to_proc`会返回一个带参数的`Proc`对象，`Proc`对象所做的是为使用这个`Proc`对象的对象发送调用名字为该符号的方法。

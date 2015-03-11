---
title: 运行Rails测试会发生什么?
date: 2014-08-21 09:43 UTC
tags: Rails
---

## 运行Rails测试的方法

Rails默认的启动测试命令是`rake test:all`。运行这个命令之后，它会将test文件夹或其子目录下所有以`_test.rb`结尾的文件交给Minitest运行。如果你想运行单个的测试文件，那么你需要使用一个亢长的命令`rake test TEST=/test/models/some_model_test.rb`。

## 运行测试之后发生了什么?

当我们运行`rake test:all`，Rake task传递所有符合`test/**/*_test.rb`规则的文件给Minitest运行。当Minitest得到了符合规则的文件列表之后，它会对每个文件执行以下操作.

1. Ruby解释器加载文件。在Rails的测试中，头部的`require test_helper`很重要，它加载全局的变量和Rails环境设置。
1. 在每一个`Minitest::TestCase`的子类中，Minitest标识文件中的每一个测试方法。

这样Minitest得到了一个所有测试方法的列表，对于每一个测试方法，Minitest会执行以下操作。

1. 加载或重置`fixture`数据。Fixtures是Rails中定义可用来测试ActiveRecord数据的机制。一般的，fixtures会在一次数据库事务(database transaction)中加载，测试结束之后，事务会被回滚。这样可以保证下一个测试是初始化的状态。
1. 运行所有`setup`块。
1. 运行实际的测试方法，测试方法会在运行错误或者遭遇到失败的断言(failed assertion)之后被中止。如果这两种情况都没有发生，测试通过。
1. 运行`teardown`块。
1. 回滚或者删除第一步的fixtures。测试结果会输出到显示器上。

![MiniTest test execution](//dn-chareice.qbox.me/minitest-execution.png)

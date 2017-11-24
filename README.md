# LVMTimeCutdownManager
倒计时管理

```
   // 初始化
   self.manager = [[LVMTimeCutdownManager alloc] initWithFutureTimeIntervalSine1970:0 cutdownInterval:0.1];
   // 指定格式
   self.manager.cutdownFormats = @[@"%d月", @"%02d日", @"%02d时 ", @"%02d分 ", @"%02d.", @"%03d"];
   // 设置代理
   self.manager.delegate = self;
 
   // 实现代理
   - (void)timeCutdownManagerDidRefreshCutdown:(LVMTimeCutdownManager *)manager {
    NSLog(@"%@", manager.cutdownIntrol);    ///< 59分 46.799
   }
```


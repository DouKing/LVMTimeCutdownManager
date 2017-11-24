//
// LVMTimeCutdownManager
// LVMTimeCutdownManager.h
// Created by DouKing (https://github.com/DouKing) on 2017/11/24.
// 
	

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LVMTimeCutdownManagerDelegate;

typedef NS_ENUM(NSInteger, LVMCutdownDateType) {
  LVMCutdownDateTypeMonth,
  LVMCutdownDateTypeDay,
  LVMCutdownDateTypeHour,
  LVMCutdownDateTypeMinute,
  LVMCutdownDateTypeSecond,
  LVMCutdownDateTypeMilliSecond,
  
  LVMCutdownDateTypeTotalCount
};

/**
 倒计时管理类
 
 @example
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
 */
@interface LVMTimeCutdownManager : NSObject

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

/**
 初始化方法

 @param futureTimeIntervalSince1970 未来某个时间的时间戳，单位：秒
 @param cutdownInterval 倒计时间隔，单位秒
 @return instancetype，如果未来的时间小于当前时间，返回nil
 */
- (nullable instancetype)initWithFutureTimeIntervalSine1970:(NSTimeInterval)futureTimeIntervalSince1970
                                            cutdownInterval:(NSTimeInterval)cutdownInterval;

/**
 初始化方法

 @param cutdown 倒计时时长，单位：秒
 @param cutdownInterval 倒计时间隔，单位秒
 @return instancetype，如果时长不大于0，返回nil
 */
- (nullable instancetype)initWithCutdown:(NSTimeInterval)cutdown
                         cutdownInterval:(NSTimeInterval)cutdownInterval;

@property (nonatomic, weak, nullable) id<LVMTimeCutdownManagerDelegate> delegate;

/// 倒计时剩余时间戳，会在每个时间间隔刷新
@property (nonatomic, assign, readonly) NSTimeInterval cutdown;

@end

@interface LVMTimeCutdownManager (Format)

- (void)setCutdownFormat:(nullable NSString *)format forType:(LVMCutdownDateType)type;
- (nullable NSString *)getCutdownFormatForType:(LVMCutdownDateType)type;
@property (nonatomic, strong) NSArray *cutdownFormats;

- (NSString *)cutdownIntrol;

@end

@protocol LVMTimeCutdownManagerDelegate <NSObject>

- (void)timeCutdownManagerDidRefreshCutdown:(LVMTimeCutdownManager *)manager;

@end

NS_ASSUME_NONNULL_END

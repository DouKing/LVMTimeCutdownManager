//
// LVMTimeCutdownManager
// LVMTimeCutdownManager.m
// Created by DouKing (https://github.com/DouKing) on 2017/11/24.
//

#import "LVMTimeCutdownManager.h"
#import "NSTimer+LVM.h"

#define LVMCutdownDESC(introl,s) [NSString stringWithFormat:introl, s]

@interface LVMTimeCutdownManager ()

@property (nonatomic, assign) NSTimeInterval futureTimeIntervalSince1970;
@property (nonatomic, assign) NSTimeInterval cutdownInterval;

@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, assign) NSTimeInterval cutdown;

@property (nonatomic, strong) NSMutableArray *cutdownFormats;

@end

@implementation LVMTimeCutdownManager

- (void)dealloc {
  [_timer invalidate];
}

- (instancetype)initWithFutureTimeIntervalSine1970:(NSTimeInterval)futureTimeIntervalSince1970 cutdownInterval:(NSTimeInterval)cutdownInterval {
  NSTimeInterval currentTimeInterval = [[NSDate date] timeIntervalSince1970];
  return [self initWithCutdown:futureTimeIntervalSince1970 - currentTimeInterval cutdownInterval:cutdownInterval];
}

- (instancetype)initWithCutdown:(NSTimeInterval)cutdown cutdownInterval:(NSTimeInterval)cutdownInterval {
  if (self = [super init]) {
    if (cutdown <= 0) {
      return nil;
    }
    _cutdownInterval = cutdownInterval;
    self.cutdown = cutdown;
    __weak typeof(self) __weak_self__ = self;
    _timer = [NSTimer lvm_scheduledTimerWithTimeInterval:cutdownInterval userInfo:nil repeats:YES block:^{
      __strong typeof(__weak_self__) self = __weak_self__;
      [self _timerAction];
    }];
  }
  return self;
}

- (void)_timerAction {
  if (self.cutdown < self.cutdownInterval) {
    [self.timer invalidate];
    return;
  }
  self.cutdown -= self.cutdownInterval;
}

- (void)setCutdown:(NSTimeInterval)cutdown {
  if (_cutdown == cutdown) {
    return;
  }
  _cutdown = cutdown;
  if ([self.delegate respondsToSelector:@selector(timeCutdownManagerDidRefreshCutdown:)]) {
    [self.delegate timeCutdownManagerDidRefreshCutdown:self];
  }
}

- (NSMutableArray *)cutdownFormats {
  if (!_cutdownFormats) {
    _cutdownFormats = [NSMutableArray arrayWithCapacity:LVMCutdownDateTypeTotalCount];
    for (int i = 0; i < LVMCutdownDateTypeTotalCount; i++) {
      [_cutdownFormats addObject:[NSNull null]];
    }
  }
  return _cutdownFormats;
}

@end

@implementation LVMTimeCutdownManager (Format)

- (void)setCutdownFormat:(NSString *)format forType:(LVMCutdownDateType)type {
  id obj = format ?: [NSNull null];
  [self.cutdownFormats replaceObjectAtIndex:type withObject:obj];
}

- (NSString *)getCutdownFormatForType:(LVMCutdownDateType)type {
  if (type >= self.cutdownFormats.count) {
    return nil;
  }
  id obj = [self.cutdownFormats objectAtIndex:type];
  if ([obj isKindOfClass:[NSString class]]) {
    return obj;
  }
  return nil;
}

- (void)setCutdownFormats:(NSArray *)cutdownFormats {
  _cutdownFormats = [cutdownFormats mutableCopy];
}

- (NSString *)cutdownIntrol {
  long MTi = 3600 * 24 * 30;
  int  dTi = 3600 * 24;
  int  hTi = 3600;
  int  mTi = 60;
  int  sTi = 1;
  NSTimeInterval cutdown = self.cutdown;
  NSMutableArray<NSString *> *temp = [NSMutableArray arrayWithCapacity:6];
  
  NSString *introl = [self getCutdownFormatForType:LVMCutdownDateTypeMonth];
  if (introl) {
    int M = cutdown / MTi;
    if (M > 0) {
      cutdown -= M * MTi;
      [temp addObject:LVMCutdownDESC(introl, M)];
    }
  }
  
  introl = [self getCutdownFormatForType:LVMCutdownDateTypeDay];
  if (introl) {
    int d = cutdown / dTi;
    if (d > 0 || temp.lastObject) {
      cutdown -= d * dTi;
      [temp addObject:LVMCutdownDESC(introl, d)];
    }
  }
  
  introl = [self getCutdownFormatForType:LVMCutdownDateTypeHour];
  if (introl) {
    int h = cutdown / hTi;
    if (h > 0 || temp.lastObject) {
      cutdown -= h * hTi;
      [temp addObject:LVMCutdownDESC(introl, h)];
    }
  }
  
  introl = [self getCutdownFormatForType:LVMCutdownDateTypeMinute];
  if (introl) {
    int m = cutdown / mTi;
    if (m > 0 || temp.lastObject) {
      cutdown -= m * mTi;
      [temp addObject:LVMCutdownDESC(introl, m)];
    }
  }
  
  introl = [self getCutdownFormatForType:LVMCutdownDateTypeSecond];
  if (introl) {
    int s = cutdown / sTi;
    if (s > 0 || temp.lastObject) {
      cutdown -= s * sTi;
      [temp addObject:LVMCutdownDESC(introl, s)];
    }
  }
  
  introl = [self getCutdownFormatForType:LVMCutdownDateTypeMilliSecond];
  if (introl) {
    int S = cutdown * 1000;
    if (S > 0 || temp.lastObject) {
      [temp addObject:LVMCutdownDESC(introl, S)];
    }
  }
  
  return [temp componentsJoinedByString:@""];
}

@end

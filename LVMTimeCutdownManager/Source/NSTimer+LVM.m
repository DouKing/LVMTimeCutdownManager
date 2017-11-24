//
// LVMTimeCutdownManager
// NSTimer+LVM.m
// Created by DouKing (https://github.com/DouKing) on 2017/11/24.
// 

#import "NSTimer+LVM.h"
#import <objc/runtime.h>

@interface _LVMTimerHandler : NSObject
- (void)_handleTimerAction:(NSTimer *)timer;
@end


@interface NSTimer ()

@property (nonatomic, copy) LVMTimerBlock actionBlock;

@end

@implementation NSTimer (LVM)

+ (NSTimer *)lvm_scheduledTimerWithTimeInterval:(NSTimeInterval)ti userInfo:(id)userInfo repeats:(BOOL)yesOrNo block:(LVMTimerBlock)block {
  _LVMTimerHandler *handler = [[_LVMTimerHandler alloc] init];
  NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:ti target:handler selector:@selector(_handleTimerAction:) userInfo:userInfo repeats:yesOrNo];
  timer.actionBlock = block;
  return timer;
}

- (void)setActionBlock:(LVMTimerBlock)actionBlock {
  objc_setAssociatedObject(self, @selector(actionBlock), actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (LVMTimerBlock)actionBlock {
  return objc_getAssociatedObject(self, @selector(actionBlock));
}

@end

@implementation _LVMTimerHandler

- (void)_handleTimerAction:(NSTimer *)timer {
  if (timer.actionBlock) {
    timer.actionBlock();
  }
}

@end

//
// LVMTimeCutdownManager
// NSTimer+LVM.h
// Created by DouKing (https://github.com/DouKing) on 2017/11/24.
// 

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^LVMTimerBlock)(void);

@interface NSTimer (LVM)

+ (NSTimer *)lvm_scheduledTimerWithTimeInterval:(NSTimeInterval)ti userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo block:(LVMTimerBlock)block;

@end


NS_ASSUME_NONNULL_END

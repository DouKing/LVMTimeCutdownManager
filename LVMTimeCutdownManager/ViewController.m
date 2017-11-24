//
// LVMTimeCutdownManager
// ViewController.m
// Created by DouKing (https://github.com/DouKing) on 2017/11/24.
// 

#import "ViewController.h"
#import "LVMTimeCutdownManager.h"

@interface ViewController ()<LVMTimeCutdownManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *cutdownLabel;
@property (nonatomic, strong) LVMTimeCutdownManager *cutdownManager;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  NSTimeInterval cutdown = 32 * 24 * 60 * 60 + 3600 + 60 + 30.5;
  self.cutdownManager = [[LVMTimeCutdownManager alloc] initWithCutdown:cutdown cutdownInterval:0.1];
  self.cutdownManager.cutdownFormats = @[@"月", @"%d天", @"%02d时 ", @"%02d分 ", @"%02d.", @"%03d秒"];
  [self.cutdownManager setCutdownFormat:nil forType:LVMCutdownDateTypeMonth]; //忽略 月
  self.cutdownManager.delegate = self;
}

- (void)timeCutdownManagerDidRefreshCutdown:(LVMTimeCutdownManager *)manager {
  self.cutdownLabel.text = [manager cutdownIntrol];
}

@end

[![996.icu](https://img.shields.io/badge/link-996.icu-red.svg)](https://996.icu)
[![LICENSE](https://img.shields.io/badge/license-Anti%20996-blue.svg)](https://github.com/996icu/996.ICU/blob/master/LICENSE)

# LVMTimeCutdownManager

A time cutdown manager, use it to manage your time cutdown.

## How it works

The LVMTimeCutdownManager manage a `NSTimer` inside, and when the timer tick, the manager can give a callback.
If you set the `cutdownFormats`, the manager can also convert the residual time interval to a string as your format.

## Usage

```

// init your manager 
self.manager = [[LVMTimeCutdownManager alloc] initWithFutureTimeIntervalSine1970:0 cutdownInterval:0.1];
// set your formats
self.manager.cutdownFormats = @[@"%d月", @"%02d日", @"%02d时 ", @"%02d分 ", @"%02d.", @"%03d"];
// give a delegate to the manager so you can obtain the callback 
self.manager.delegate = self;

// implement the protocol
- (void)timeCutdownManagerDidRefreshCutdown:(LVMTimeCutdownManager *)manager {
   NSLog(@"%@", manager.cutdownIntrol);    ///< 59分 46.799
}

```

## Install

Drag the `Source` directory to your project. And import `LVMTimeCutdownManager.h` to your file that you want to use the manager.

## License

See LICENSE.
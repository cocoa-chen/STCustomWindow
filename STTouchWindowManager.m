//
//  STTouchWindowManager.m
//  PetParadise
//
//  Created by 爱彬 陈 on 12-9-7.
//  Copyright (c) 2012年 ispirit. All rights reserved.
//

#import "STTouchWindowManager.h"

static float _touchTimer = 0;

#define kTouchWindowNotification  @"kTouchWindowNotification"

@implementation STTouchWindowManager
@synthesize maxTime;

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) 
	{        

    }	
	return self;
}

//计时器加1
- (void)increaseTime
{
    NSLog(@"touchTimer;%f",_touchTimer);
    _touchTimer += 1;
    //超过最长时间限制
    if (_touchTimer >= maxTime) {
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:kTouchWindowNotification object:nil userInfo:nil];
        [self stopListenTouchEvent];
    }
}

- (void)sendEvent:(UIEvent *)event
{
    [super sendEvent:event];
    NSSet *allTouches = [event allTouches];
    if ([allTouches count] > 0) {
		// To reduce timer resets only reset the timer on a Began or Ended touch.
        UITouchPhase phase = ((UITouch *)[allTouches anyObject]).phase;
		if (phase == UITouchPhaseBegan || phase == UITouchPhaseEnded) {
            //活跃状态，将time置为0
            _touchTimer = 0;
		}
	}
}
//开始计时
- (void)startListenTouchEvent
{
    maxTime = 20;
    _touchTimer = 0;
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(increaseTime) userInfo:nil repeats:YES];
        [_timer retain];
    }
}
//停止计时
- (void)stopListenTouchEvent
{
    [_timer invalidate];
    [_timer release];
    _timer = nil;
    //重置时间
    _touchTimer = 0;
}

- (void)dealloc
{
    [super dealloc];
}

@end

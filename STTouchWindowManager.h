//
//  STTouchWindowManager.h
//  PetParadise
//
//  Created by 爱彬 陈 on 12-9-7.
//  Copyright (c) 2012年 ispirit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STTouchWindowManager : UIWindow
{
    float maxTime;
    NSTimer *_timer;
    
}
@property (nonatomic,assign) float maxTime;

- (void)startListenTouchEvent;
- (void)stopListenTouchEvent;

@end
//
//  AnimationUtils.m
//  Erm_mobile_ios
//
//  Created by 孙龙霄 on 7/17/15.
//  Copyright © 2015 孙龙霄. All rights reserved.
//

#import "AnimationUtils.h"

@implementation AnimationUtils


+ (void)wobble:(UIView *)view{
    
    srand([[NSDate date] timeIntervalSince1970]);
    float rand=(float)random();
    CFTimeInterval t=rand*0.0000000001;
    [UIView animateWithDuration:0.1 delay:t options:0  animations:^
     {
         view.transform=CGAffineTransformMakeRotation(-0.05);
     } completion:^(BOOL finished)
     {
         [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionRepeat|UIViewAnimationOptionAutoreverse|UIViewAnimationOptionAllowUserInteraction  animations:^
          {
              view.transform=CGAffineTransformMakeRotation(0.05);
          } completion:^(BOOL finished) {}];
     }];
    
}

+ (void)endWobble:(UIView *)view{
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState animations:^
     {
         view.transform=CGAffineTransformIdentity;
         
     } completion:^(BOOL finished) {}];
}

@end

//
//  NTESGLViewManager.m
//  RNNeteaseIm
//
//  Created by MaTHtoE on 2018/2/23.
//  Copyright © 2018年 Dowin. All rights reserved.
//

#import "RNNeteaseIm.h"
#import "NTESGLViewManager.h"
#import "NTESGLView.h"

@implementation NTESGLViewManager

RCT_EXPORT_MODULE()

- (UIView *)view
{
    NTESGLView* v = [[NTESGLView alloc] init];
    RNNeteaseIm *module = [self.bridge moduleForName:@"RNNeteaseIm"];
    [module registNTESGLView:v];
    return v;
}

- (dispatch_queue_t)methodQueue {
    return dispatch_get_main_queue();
}

@end

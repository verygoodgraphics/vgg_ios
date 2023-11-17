//
//  VggRenderView.h
//  VggRuntime
//
//  Created by houguanhua on 2023/11/16.
//  Copyright © 2023 VeryGoodGraphics LTD. All rights reserved.
//

#import <MetalKit/MetalKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface VggRenderView : MTKView

- (instancetype)initWithFrame:(CGRect)frameRect;

- (void)setModel:(NSString*)filePath;

@end

NS_ASSUME_NONNULL_END

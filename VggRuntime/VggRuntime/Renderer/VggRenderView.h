//
//  VggRenderView.h
//  VggRuntime
//
//  Created by houguanhua on 2023/11/16.
//  Copyright © 2023 VeryGoodGraphics LTD. All rights reserved.
//

#import <MetalKit/MetalKit.h>

#import <VggRuntime/VggContainer.h>


NS_ASSUME_NONNULL_BEGIN

@protocol VggDelegate
- (void)handleVggEvent:(NSString*)type path:(NSString*)path;
@end

@interface VggRenderView : MTKView

@property (nonatomic, weak) id<VggDelegate> vggDelegate;
@property (nonatomic, weak, nullable) VggContainer* vggContainer;

- (instancetype)initWithFrame:(CGRect)frameRect;

- (void)setModel:(NSString*)filePath;

@end

NS_ASSUME_NONNULL_END

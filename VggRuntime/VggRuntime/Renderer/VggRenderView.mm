//
//  VggRenderView.m
//  VggRuntime
//
//  Created by houguanhua on 2023/11/16.
//  Copyright © 2023 VeryGoodGraphics LTD. All rights reserved.
//

#import "VggRenderView.h"

#import "VGG/MetalComponent.hpp"

#import <memory>
#import <string>

using namespace VGG;

@implementation VggRenderView
{
    NSString* _modelFilePath;
    std::unique_ptr<VGG::MetalComponent> _component;
    bool _init;
}


- (instancetype)initWithCoder:(NSCoder*)decoder
{
    self = [super initWithCoder:decoder];

    return self;
}

- (instancetype)initWithFrame:(CGRect)frameRect
{
    auto metalDevice = MTLCreateSystemDefaultDevice();
    auto result = [super initWithFrame:frameRect device:metalDevice];
    _component.reset(new VGG::MetalComponent());
    
    return result;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    if(_modelFilePath) {
        [self initOnce];
        
        _component->run();
    }

}

- (void)setModel:(NSString*)filePath
{
    _modelFilePath = filePath;
}

- (void)initOnce {
    static bool initialized = false;
    if(initialized) {
        return;
    }
    initialized = true;
    
    // config view
    [self setDepthStencilPixelFormat:MTLPixelFormatDepth32Float_Stencil8];
    [self setColorPixelFormat:MTLPixelFormatRGBA8Unorm];
    [self setSampleCount:1];
    
    _component->setView((__bridge MetalComponent::MTLHandle)self);
    _component->load(_modelFilePath.UTF8String);
}

@end

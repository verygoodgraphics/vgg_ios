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
    bool _initialized;
    CGSize _size;
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
    _size = self.frame.size;
    
    return result;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if(!_initialized) {
        [self initOnce];
        
    } else {
        auto newSize = self.frame.size;
        if(!CGSizeEqualToSize(_size, newSize)) {
            _size = newSize;
            
            UEvent evt;
            evt.window.type = VGG_WINDOWEVENT;
            evt.window.event = VGG_WINDOWEVENT_SIZE_CHANGED;
            evt.window.data1 = _size.width;
            evt.window.data2 = _size.height;
            evt.window.drawableWidth = _size.width * self.contentScaleFactor;
            evt.window.drawableHeight = _size.height * self.contentScaleFactor;
            _component->onEvent(evt);
        }
        
    }

}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    if(_modelFilePath) {
        _component->run();
    }
}

- (void)setModel:(NSString*)filePath
{
    _modelFilePath = filePath;
}

- (void)initOnce {
    if(_initialized) {
        return;
    }
    _initialized = true;
    
    // config view
    [self setDepthStencilPixelFormat:MTLPixelFormatDepth32Float_Stencil8];
    [self setColorPixelFormat:MTLPixelFormatRGBA8Unorm];
    [self setSampleCount:1];
    
    _component->setView((__bridge MetalComponent::MTLHandle)self);
    _component->load(_modelFilePath.UTF8String);
}

@end

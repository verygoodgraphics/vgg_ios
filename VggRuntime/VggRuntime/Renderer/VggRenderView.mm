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

// MARK: - Setter
- (void)setVggDelegate:(id<VggDelegate>)vggDelegate
{
    _vggDelegate = vggDelegate;
    if (_vggDelegate) {
        __weak typeof(self) weakSelf = self;
        _component->setEventListener([weakSelf](std::string type, std::string path) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (strongSelf) {
                [strongSelf.vggDelegate handleVggEvent: [NSString stringWithUTF8String:type.c_str()]
                                                  path: [NSString stringWithUTF8String:path.c_str()]];
            }
        });
    } else {
        _component->setEventListener(nullptr);
    }
}

// MARK: -
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

// MARK: -
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    auto touch = [touches anyObject];
    if(!touch) {
        return;
    }
    
    auto location = [touch locationInView:self];
    
    UEvent evt;
    evt.touch.type = VGG_TOUCHDOWN;
    evt.touch.windowX = location.x;
    evt.touch.windowY = location.y;
    
    _component->onEvent(evt);
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    auto touch = [touches anyObject];
    if(!touch) {
        return;
    }
    
    auto previousLocation = [touch previousLocationInView:self];
    auto location = [touch locationInView:self];
    
    UEvent evt;
    evt.touch.type = VGG_TOUCHMOTION;
    evt.touch.windowX = location.x;
    evt.touch.windowY = location.y;
    evt.touch.xrel = location.x - previousLocation.x;
    evt.touch.yrel = location.y - previousLocation.y;
    
    _component->onEvent(evt);
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    auto touch = [touches anyObject];
    if(!touch) {
        return;
    }
    
    auto location = [touch locationInView:self];
    
    UEvent evt;
    evt.touch.type = VGG_TOUCHUP;
    evt.touch.windowX = location.x;
    evt.touch.windowY = location.y;
    
    _component->onEvent(evt);

}

@end

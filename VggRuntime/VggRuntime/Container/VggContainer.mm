//
//  VggContainer.m
//  VggRuntime
//
//  Created by houguanhua on 2023/12/12.
//  Copyright © 2023 VeryGoodGraphics LTD. All rights reserved.
//

#import "VggContainer.h"

#import "VGG/MetalContainer.hpp"

@implementation VggContainer
{
    std::shared_ptr<VGG::MetalContainer> _cppContainer;
    std::shared_ptr<VGG::ISdk> _vggSdk;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _cppContainer.reset(new VGG::MetalContainer());
        _vggSdk = _cppContainer->sdk();
    }
    return self;
}

// MARK: - design document
- (NSString*)designDoc {
    const auto& content = _vggSdk->designDocument();
    return [NSString stringWithUTF8String:content.c_str()];
}

- (nullable NSString*)designDocValueAt:(NSString*)path {
    try {
        const auto& value = _vggSdk->designDocumentValueAt(path.UTF8String);
        return [NSString stringWithUTF8String:value.c_str()];
    } catch (...) {
        return nil;
    }
}

- (nullable NSString*)elementById:(NSString*)idString {
    const auto& value = _vggSdk->getElement(idString.UTF8String);
    if (!value.empty()) {
        return [NSString stringWithUTF8String:value.c_str()];
    } else {
        return nil;
    }
}

- (void)updateElementById:(NSString*)idString content:(NSString*)jsonString {
     _vggSdk->updateElement(idString.UTF8String, jsonString.UTF8String);
}



- (void*)cppContainer {
    return _cppContainer.get();
}

@end

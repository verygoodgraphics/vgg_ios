//
//  VggModel.m
//  VggRuntime
//
//  Created by houguanhua on 2023/12/5.
//  Copyright © 2023 VeryGoodGraphics LTD. All rights reserved.
//

#import "VggModel.h"

#import "VGG/VggSdk.hpp"

@interface VggModel()

@property (nonatomic, strong, readwrite) NSString* filePath;

@end

@implementation VggModel
{
    std::shared_ptr<VggSdk> _vggSdk;
}

- (instancetype)initWithFilePath:(NSString*)filePath {
    self = [super init];
    
    _filePath = filePath;
    
    _vggSdk = std::make_shared<VggSdk>();
    
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

- (void)designDocAddAt:(NSString*)path value:(NSString*)value {
    _vggSdk->designDocumentAddAt(path.UTF8String, value.UTF8String);
}

- (void)designDocReplaceAt:(NSString*)path value:(NSString*)value {
    _vggSdk->designDocumentReplaceAt(path.UTF8String, value.UTF8String);
}

- (void)designDocDeletaAt:(NSString*)path {
    _vggSdk->designDocumentDeleteAt(path.UTF8String);
}

@end

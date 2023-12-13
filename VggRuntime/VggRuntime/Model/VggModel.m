//
//  VggModel.m
//  VggRuntime
//
//  Created by houguanhua on 2023/12/5.
//  Copyright © 2023 VeryGoodGraphics LTD. All rights reserved.
//

#import "VggModel.h"

@interface VggModel()

@property (nonatomic, strong, readwrite) NSString* filePath;

@end

@implementation VggModel

- (instancetype)initWithFilePath:(NSString*)filePath {
    self = [super init];
    
    _filePath = filePath;
    
    return self;
}


@end

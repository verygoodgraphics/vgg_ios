//
//  VggContainer.h
//  VggRuntime
//
//  Created by houguanhua on 2023/12/12.
//  Copyright © 2023 VeryGoodGraphics LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VggContainer : NSObject

- (void)setFitToViewportEnabled:(bool)enabled;

- (NSString*)designDoc;
- (nullable NSString*)designDocValueAt:(NSString*)path;

- (nullable NSString*)elementById:(NSString*)idString;
- (void)updateElementById:(NSString*)idString content:(NSString*)jsonString;

- (void*)cppContainer;

@end

NS_ASSUME_NONNULL_END

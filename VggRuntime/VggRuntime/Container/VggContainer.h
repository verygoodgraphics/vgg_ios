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

- (NSString*)designDoc;
- (nullable NSString*)designDocValueAt:(NSString*)path;
- (void)designDocAddAt:(NSString*)path value:(NSString*)value;
- (void)designDocReplaceAt:(NSString*)path value:(NSString*)value;
- (void)designDocDeletaAt:(NSString*)path;

- (void*)cppContainer;

@end

NS_ASSUME_NONNULL_END

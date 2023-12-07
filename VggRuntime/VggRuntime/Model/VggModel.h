//
//  VggModel.h
//  VggRuntime
//
//  Created by houguanhua on 2023/12/5.
//  Copyright © 2023 VeryGoodGraphics LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VggModel : NSObject

@property (nonatomic, strong, readonly) NSString* filePath;

- (instancetype)initWithFilePath:(NSString*)filePath;


- (NSString*)designDoc;
- (nullable NSString*)designDocValueAt:(NSString*)path;
- (void)designDocAddAt:(NSString*)path value:(NSString*)value;
- (void)designDocReplaceAt:(NSString*)path value:(NSString*)value;
- (void)designDocDeletaAt:(NSString*)path;


@end

NS_ASSUME_NONNULL_END

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




@end

NS_ASSUME_NONNULL_END

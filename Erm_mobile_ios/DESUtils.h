//
//  DESUtils.h
//  Erm_mobile_ios
//
//  Created by 孙龙霄 on 7/16/15.
//  Copyright © 2015 孙龙霄. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>
#import "GTMBase64.h"


@interface DESUtils : NSObject

+ (NSString *)decryptWithText:(NSString *)sText;
+ (NSString *)encrypt:(NSString *)sText encryptOrDecrypt:(CCOperation)encryptOperation key:(NSString *)key;

@end

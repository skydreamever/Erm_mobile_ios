//
//  DESUtils.m
//  Erm_mobile_ios
//
//  Created by 孙龙霄 on 7/16/15.
//  Copyright © 2015 孙龙霄. All rights reserved.
//

#import "DESUtils.h"

@implementation DESUtils

+ (NSString *)decryptWithText:(NSString *)sText

{
    
    NSString *tmp = [self encrypt:sText encryptOrDecrypt:kCCDecrypt key:@"12345678"];
    return tmp;
    
}

+ (NSString *)encrypt:(NSString *)sText encryptOrDecrypt:(CCOperation)encryptOperation key:(NSString *)key

{
    
    const void *vplainText;
    
    size_t plainTextBufferSize;
    
    
    
    if (encryptOperation == kCCDecrypt)
        
    {
        
        NSData *decryptData = [GTMBase64 decodeString:sText];
        
        plainTextBufferSize = [decryptData length];
        
        vplainText = [decryptData bytes];
        
    }
    
    else
        
    {
        
        NSData* encryptData = [sText dataUsingEncoding:NSUTF8StringEncoding];
        
        plainTextBufferSize = [encryptData length];
        
        vplainText = (const void *)[encryptData bytes];
        
    }
    
    
    
    CCCryptorStatus ccStatus;
    
    uint8_t *bufferPtr = NULL;
    
    size_t bufferPtrSize = 0;
    
    size_t movedBytes = 0;
    
    
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    //    Byte iv[] = {0x12, 0x34, 0x56, 0x78, 0x90, 0xAB, 0xCD, 0xEF};
    //    ccStatus = CCCrypt(encryptOrDecrypt,
    //                       kCCAlgorithmDES,
    //                       kCCOptionPKCS7Padding,
    //                       vkey,
    //
    //                       kCCKeySizeDES,
    //                       iv,//vinitVec, //"init Vec", //iv,
    //                       vplainText, //"Your Name", //plainText,
    //                       plainTextBufferSize,
    //                       (void *)bufferPtr,
    //                       bufferPtrSize,
    //                       &movedBytes);
    
    
    
    //    NSString *initVec = @"init ump";
    //    const void *vinitVec = (const void *) bt[8];
    
    const void *vkey = (const void *) [key UTF8String];
    Byte  iv[] = {0x12, 0x34, 0x56, 0x78, 0x90, 0xAB, 0xCD, 0xEF};
    
    
    
    
    
    
    
    ccStatus = CCCrypt(encryptOperation,
                       
                       kCCAlgorithmDES,
                       
                       kCCOptionPKCS7Padding,
                       
                       vkey,
                       
                       kCCKeySizeDES,
                       
                       iv,
                       
                       vplainText,
                       
                       plainTextBufferSize,
                       
                       (void *)bufferPtr,
                       
                       bufferPtrSize,
                       
                       &movedBytes);
    
    
    
    NSString *result = nil;
    
    
    
    if (encryptOperation == kCCDecrypt)
        
    {
        
        result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes] encoding:NSUTF8StringEncoding];
        
    }
    
    else
        
    {
        
        NSData *data = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
        
        result = [GTMBase64 stringByEncodingData:data];
        
    }
    
    
    
    return result;
    
}


@end

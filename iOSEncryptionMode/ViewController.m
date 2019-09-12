//
//  ViewController.m
//  iOSEncryptionMode
//
//  Created by grx on 2019/9/12.
//  Copyright © 2019 ruixiao. All rights reserved.
//

#import "ViewController.h"
#import "JoDes.h"
#import "AirMD5Tool.h"
#import "AESEncryption.h"
#import "RSAEncryption.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark ==========MD5 32位大写===============
-(void)md532StrUpper{
    NSString *str = @"123456";
    NSString *md5Str = [AirMD5Tool MD5ForUpper32Bate:str];
    NSLog(@"===%@",md5Str);
}
#pragma mark ==========MD5 32位小写===============
-(void)md532StrLower{
    NSString *str = @"123456";
    NSString *md5Str = [AirMD5Tool MD5ForLower32Bate:str];
    NSLog(@"===%@",md5Str);
}
#pragma mark ==========MD5 16位大写===============
-(void)md516StrUpper{
    NSString *str = @"123456";
    NSString *md5Str = [AirMD5Tool MD5ForUpper16Bate:str];
    NSLog(@"===%@",md5Str);
}
#pragma mark ==========MD5 16位小写===============
-(void)md516StrLower{
    NSString *str = @"123456";
    NSString *md5Str = [AirMD5Tool MD5ForLower16Bate:str];
    NSLog(@"===%@",md5Str);
}

#pragma mark ==========Des 加密===============
-(NSString *)DesStrEncode:(NSString *)str{
    NSString *encodeStr = [JoDes encode:str key:@"password"];
    NSLog(@"Des加密后的字符串===%@",encodeStr);
    return encodeStr;
}

#pragma mark ==========Des 解密===============
-(NSString *)DesStrDecode:(NSString *)str{
    NSString *desStr = [JoDes decode:str key:@"password"];
    NSLog(@"Des解密后的字符串===%@",desStr);
    return desStr;
}

#pragma mark ==========Aes 加密===============
-(NSString *)AesStrEncode:(NSString *)str{
    NSString *encodeStr = [AESEncryption encryptUseAES:str key:@"password" iv:@"iv"];
    NSLog(@"Aes加密后的字符串===%@",encodeStr);
    return encodeStr;
}

#pragma mark ==========Aes 解密===============
-(NSString *)AesStrDecode:(NSString *)str{
    NSString *desStr = [AESEncryption decryptUseAES:str key:@"password" iv:@"iv"];
    NSLog(@"Aes解密后的字符串===%@",desStr);
    return desStr;
}

#pragma mark ==========Res 加密===============
-(NSString *)RSAEncryption:(NSString *)str{
    RSAEncryption * rsa = [[RSAEncryption alloc] init];
    NSString *publicKeyPath = [[NSBundle mainBundle] pathForResource:@"public" ofType:@"der"];
    [rsa loadPublicKeyFromFile:publicKeyPath];
    NSString *securityText = str;
    NSString *encryptedString = [rsa rsaEncryptString:securityText];
    NSLog(@"Res加密后的字符串===%@",encryptedString);
    return encryptedString;
}

#pragma mark ==========Res 解密===============
-(NSString *)RSADEncryption:(NSString *)str{
    RSAEncryption * rsa = [[RSAEncryption alloc] init];
    [rsa loadPrivateKeyFromFile:[[NSBundle mainBundle] pathForResource:@"private_key" ofType:@"p12"] password:@"123456"];
    NSString *decryptedString = [rsa rsaDecryptString:str];
    NSLog(@"Res解密后的字符串===%@",decryptedString);
    return decryptedString;
}


@end

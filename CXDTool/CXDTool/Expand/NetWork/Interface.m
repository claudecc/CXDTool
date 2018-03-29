//
//  Interface.m
//  CXDTool
//
//  Created by claudechoi on 2018/3/29.
//  Copyright © 2018年 claudechoi. All rights reserved.
//

#import "Interface.h"
#import "UserAgent.h"
#import "AFNetWorking.h"
#import "MyTool.h"

@interface Interface()

@property (nonatomic, strong) AFHTTPSessionManager *shareManger;

@end

@implementation Interface

static Interface *instance = nil;
+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [Interface new];
    });
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        _shareManger = [AFHTTPSessionManager manager];
        _shareManger.responseSerializer = [AFJSONResponseSerializer serializer];
        _shareManger.requestSerializer = [AFHTTPRequestSerializer serializer];
        _shareManger.securityPolicy = [AFSecurityPolicy defaultPolicy];
        _shareManger.securityPolicy.allowInvalidCertificates = YES;
        _shareManger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", nil];
        
        [_shareManger.requestSerializer setValue:[[UserAgent shareInstance] getUserAgent] forHTTPHeaderField:@"User-Agent"];
        
        
//        // 1.初始化单例类
//        // 2.设置证书模式
//        NSString * cerPath = [[NSBundle mainBundle] pathForResource:@"huihuahua" ofType:@"cer"];
//        NSData * cerData = [NSData dataWithContentsOfFile:cerPath];
//        AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone withPinnedCertificates:[[NSSet alloc] initWithObjects:cerData, nil]];
//        // 客户端是否信任非法证书
//        policy.allowInvalidCertificates = YES;
//        // 是否在证书域字段中验证域名
//        [policy setValidatesDomainName:NO];
//        _shareManger.securityPolicy = policy;
    }
    return self;
}

+ (void)requestWithUrl:(NSString *)url
               baseUrl:(NSString *)baseUrl
                method:(HTTPMethod)method
            parameters:(id)parameters
              complete:(void (^)(BOOL, NSString *, NSString *, NSObject *))complete {
    [[Interface shareInstance] requestWithUrl:url baseUrl:baseUrl method:method parameters:parameters complete:complete];
}

- (void)requestWithUrl:(NSString *)url
               baseUrl:(NSString *)baseUrl
                method:(HTTPMethod)method
            parameters:(id)parameters
              complete:(void (^)(BOOL, NSString *, NSString *, NSObject *))complete {
    NSString *methodStr = @"GET";
    if (method == GET) {
        methodStr = @"GET";
    } else if (method == POST) {
        methodStr = @"POST";
    }
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:methodStr URLString:[NSString stringWithFormat:@"%@/%@",baseUrl,url] parameters:parameters error:nil];
    request.timeoutInterval = 6;
    [_shareManger dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        BOOL isSuccessBool = NO;
        NSString *codeStr = @"";
        NSString *msgStr = @"";
        NSObject *object = nil;
        if (error) {
            if (error.code==-1001) {
                complete(NO,@"",@"请求超时",nil);
                return;
            }
            //网络链接问题或者请求地址有误
            msgStr = @"网络异常";
        } else {
            NSDictionary *dic = responseObject;
            if (dic&&[dic isKindOfClass:[NSDictionary class]]) {
                codeStr = dic[@"code"];
                if ([codeStr isKindOfClass:[NSNull class]]) {
                    complete(NO,@"",@"请求失败",nil);
                    return;
                }
                codeStr = [MyTool getStringFromObj:dic[@"code"]];
                msgStr = dic[@"msg"];
                if ([codeStr isEqualToString:@"200"]) {
                    isSuccessBool = YES;
                    msgStr = [MyTool getStringFromObj:msgStr];
                    if([[dic allKeys] containsObject:@"result"]) {
                        object = dic[@"result"];
                    } else if ([[dic allKeys] containsObject:@"data"]) {
                        object = dic[@"data"];
                    }
                    
                } else {
                    if (!msgStr || ![msgStr isKindOfClass:[NSString class]]) {
                        //未返回错误信息
                        msgStr = @"请求失败";
                    }
                }
            }else{
                //返回数据格式错误
                msgStr = @"请求失败";
            }
        }
        complete(isSuccessBool,codeStr,msgStr,object);
    }];
}

@end

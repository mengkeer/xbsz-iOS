//
//  CXNetwork+Note.m
//  xbsz
//
//  Created by lotus on 2017/5/18.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "CXNetwork+Note.h"

@implementation CXNetwork (Note)

+ (void)publishNote:(UIImage *)image
              isBig:(BOOL)isBig
            subject:(NSString *)subject
           location:(NSString *)location
            success:(CXNetworkSuccessBlock)success
            failure:(CXNetworkFailureBlock)failure{
    CGFloat percent = isBig ? 1 : 0.5;
    NSData *imageData = UIImageJPEGRepresentation(image, percent);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.requestSerializer.timeoutInterval = 8;
    
    CGSize size = image.size;
    
    NSString *width = [NSString stringWithFormat:@"%lf",size.width];
    NSString *height = [NSString stringWithFormat:@"%lf",size.height];

    
    NSDictionary *parameters = @{@"token":[CXLocalUser instance].token,@"subject":subject,@"location":location,@"width":width,@"height":height};
    [manager POST:CXPublishNoteUrl parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *fileName = [NSString stringWithFormat:@"%@.png",[formatter stringFromDate:[NSDate date]]];
        //二进制文件，接口key值，文件路径，图片格式
        [formData appendPartWithFileData:imageData name:@"img" fileName:fileName mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        CXBaseResponseModel *rsp = [CXBaseResponseModel yy_modelWithDictionary:obj];
        CallbackRsp(rsp);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        InvokeFailure(error);
    }];

}

+ (void)getNotesByPageOffset:(NSInteger)offset
                       limit:(NSInteger)limit
                     success:(CXNetworkSuccessBlock)success
                     failure:(CXNetworkFailureBlock)failure{
    NSDictionary *parameters = nil;
    
    parameters = @{@"offset":[NSString stringWithFormat:@"%ld",offset],@"limit":[NSString stringWithFormat:@"%ld",limit]};
    
    [self invokePostRequest:CXGetNotesUrl parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        CXBaseResponseModel *rsp = [CXBaseResponseModel yy_modelWithDictionary:(NSDictionary *)responseObject];
        CallbackRsp(rsp);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        InvokeFailure(error);
    }];
    
}

+ (void)getNoteComments:(NSString *)noteID
                 offset:(NSInteger)offset
                  limit:(NSInteger)limit
                success:(CXNetworkSuccessBlock)success
                failure:(CXNetworkFailureBlock)failure{
    
    NSDictionary *parameters = nil;
    
    parameters = @{@"noteId":noteID,@"offset":[NSString stringWithFormat:@"%ld",offset],@"limit":[NSString stringWithFormat:@"%ld",limit]};
    
    [self invokePostRequest:CXGetNoteCommentsUrl parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        CXBaseResponseModel *rsp = [CXBaseResponseModel yy_modelWithDictionary:(NSDictionary *)responseObject];
        CallbackRsp(rsp);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        InvokeFailure(error);
    }];
}

+ (void)addNoteComment:(NSString *)noteID
               content:(NSString *)content
               success:(CXNetworkSuccessBlock)success
               failure:(CXNetworkFailureBlock)failure{
    NSDictionary *parameters = nil;
    
    parameters = @{@"token":[CXLocalUser instance].token,@"noteId":noteID,@"content":content};
    
    [self invokePostRequest:CXAddNoteCommentUrl parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        CXBaseResponseModel *rsp = [CXBaseResponseModel yy_modelWithDictionary:(NSDictionary *)responseObject];
        CallbackRsp(rsp);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        InvokeFailure(error);
    }];
}

@end

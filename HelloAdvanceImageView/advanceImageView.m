//
//  advanceImageView.m
//  HelloAdvanceImageView
//
//  Created by 陳韋傑 on 2017/6/13.
//  Copyright © 2017年 陳韋傑. All rights reserved.
//

#import "advanceImageView.h"

@implementation advanceImageView
{
    UIActivityIndicatorView * loadingView;
    NSURLSessionDataTask * existTask;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void) loadImageWithURL:(NSURL *)url {
    [self prepareIndicatorView];
    
//    Cache Support
    NSString *hashedFilename = [NSString stringWithFormat:@"Cache_%ld",[url hash]];
    NSURL * cachesURL = [[NSFileManager defaultManager]URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask].firstObject;
    NSString * fullFilePathname = [cachesURL.path stringByAppendingPathComponent:hashedFilename];
    NSLog(@"Caches Path: %@",cachesURL.path);
    UIImage *cachedImage = [UIImage imageWithContentsOfFile:fullFilePathname];
    if (cachedImage != nil) {
        self.image = cachedImage;
        return;
    }
    
//    cancel existTask
    if (existTask !=nil) {
        [existTask cancel];
        existTask = nil;
    }
    
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                  {
                                      existTask = nil;
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          [loadingView stopAnimating];
                                      });
                                      if (error) {
                                          NSLog(@"Download fail: %@",error);
                                          return;
                                      }
                                      UIImage *image = [UIImage imageWithData:data];
                                      
                                      dispatch_async(dispatch_get_main_queue(),^{
                                          self.image = image;
                                          
                                          
                                      });
                                      
//                                      save data as cache file
                                      [data writeToFile:fullFilePathname atomically:true];
                                  }];
    existTask = task;
    [task resume];
}
-(void)prepareIndicatorView{
    
    if (loadingView) {
        [loadingView removeFromSuperview];
    }
    CGRect loadingViewFrame = CGRectMake(0,0,self.frame.size.width,self.frame.size.height);
    loadingView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    loadingView.color = [UIColor darkGrayColor];
    loadingView.frame = loadingViewFrame;
    loadingView.hidesWhenStopped=true;
    
    [self addSubview:loadingView];
    
}
@end

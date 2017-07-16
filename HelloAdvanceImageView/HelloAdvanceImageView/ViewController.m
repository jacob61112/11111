//
//  ViewController.m
//  HelloAdvanceImageView
//
//  Created by 陳韋傑 on 2017/6/13.
//  Copyright © 2017年 陳韋傑. All rights reserved.
//

#import "ViewController.h"
#import "advanceImageView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet advanceImageView *secondImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    advanceImageView * firstImageView = [[advanceImageView alloc] initWithFrame: CGRectMake(20, 20, 320, 240)];
    NSString * urlString = @"http://t.softarts.cc/class/Cat14MP.JPG";
    NSURL *url = [NSURL URLWithString:urlString];
    [firstImageView loadImageWithURL:url];
    [self.view addSubview:firstImageView];

//    load secondImage
//    NSURL *url2 = [NSURL URLWithString:@"http://t.softarts.cc/class/北鼻.jpg"];
    NSString *urlString2 = @"http://t.softarts.cc/class/北鼻.jpg";
    NSString *encodedString = [urlString2 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSLog(@"Original:%@",urlString2);
    NSLog(@"Encoded:%@",encodedString);
    NSURL *url2 = [NSURL URLWithString:encodedString];
    [_secondImageView loadImageWithURL:url2];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

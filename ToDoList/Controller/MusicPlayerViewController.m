//
//  MusicPlayerViewController.m
//  ToDoList
//
//  Created by Mark Lewis on 15-10-4.
//  Copyright (c) 2015年 TechLewis. All rights reserved.
//

#import "MusicPlayerViewController.h"
#import "UIImage+ImageEffects.h"
#import "MusicPlayingView.h"

@interface MusicPlayerViewController ()

@end

@implementation MusicPlayerViewController
//
//- (NSString *)documentsPath
//{
//    // 获取应用程序沙盒的documents路径
//    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
//    NSString *documentsPath = paths[0];
//    // 合成指定plist文件的全路径
//    // NSString *filename=[plistPath1 stringByAppendingPathComponent:@"Music"];
//    
//    return documentsPath;
//}
//
//#pragma mark - Initalization
//// lazy init
//- (void)setMp3URLAsset:(AVURLAsset *)mp3URLAsset
//{
//    _mp3URLAsset = mp3URLAsset;
//    
//}
//
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor blackColor];
//    self.backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
//    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
//    [self.view addSubview:self.backgroundImageView];
//
//    
//    self.musicName = [NSString stringWithFormat:@"%@.mp3", self.title];
//    NSString *path =[[self documentsPath] stringByAppendingPathComponent:self.musicName];
//    NSData *data = [NSData dataWithContentsOfFile:path];
//    self.player = [[AVAudioPlayer alloc] initWithData:data error:nil];
//    [self.player play];
//    
//    self.backgroundImageView.image = self.artworkImage;
//    
//    [UIView animateWithDuration:0.2 animations:^{
//        UIImage *effectsImage = [self.artworkImage applyBlurWithRadius:4
//                                                         tintColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.5]
//                                             saturationDeltaFactor:1.8 maskImage:nil];
//        if(self.artworkImage) self.backgroundImageView.image = effectsImage;
//    }];
//    
//    MusicPlayingView *artistView  =[[MusicPlayingView alloc] initWithFrame:self.view.bounds];
//    artistView.artistImage = self.artworkImage;
//    [self.view addSubview:artistView];
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//        });
//        // NSData *data = [NSData dataWithContentsOfFile:musicPath];
//        // NSError *err = nil;
//        // _audioPlayer = [[AVAudioPlayer alloc] initWithData:data error:&err];
//        // _audioPlayer.volume=0.8;
//        // [_audioPlayer prepareToPlay];
//        
//    });
//}
//
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    
//    [self.backgroundImageView performSelector:@selector(setImage:)
//                                   withObject:nil
//                                   afterDelay:0.15];
//}
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
///*
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/

@end

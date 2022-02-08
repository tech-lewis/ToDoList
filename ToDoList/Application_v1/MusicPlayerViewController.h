//
//  MusicPlayerViewController.h
//  ToDoList
//
//  Created by Mark Lewis on 15-10-4.
//  Copyright (c) 2015年 TechLewis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface MusicPlayerViewController : UIViewController

@property (nonatomic, strong) AVURLAsset *mp3URLAsset;
@property (nonatomic, strong) UIImage *artworkImage;
@property (nonatomic, strong) NSString *musicName;
@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, strong) UIImageView *backgroundImageView;

@end

//
//  TYVoiceMemoCell.m
//  VoiceMemoDemo
//
//  Created by Maty on 2018/8/1.
//  Copyright © 2018年 kangarootec. All rights reserved.
//

#import "TYVoiceMemoCell.h"
#import "TYMemo.h"
#import "TYRecorderTool.h"
#import <AVFAudio/AVFAudio.h>
#import <AVFoundation/AVFoundation.h>
#define TYSCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define TYSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface TYVoiceMemoCell ()

@property (nonatomic, strong) UILabel *cellTitileLabel;
@property (nonatomic, strong) UILabel *cellTimeLabel;

@property (nonatomic, strong) UIButton *playBtn;
@property (nonatomic, strong) UIButton *deleteBtn;

@end

@implementation TYVoiceMemoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

#pragma mark - SET
- (void)setMemo:(TYMemo *)memo {
    _memo = memo;
    
    self.cellTitileLabel.text = [NSString stringWithFormat:@"%@",memo.name];
  NSLog(@"%@", [memo url].absoluteString);
    self.cellTimeLabel.text = [NSString stringWithFormat:@"%.2f", [self audioDurationFromURL:[memo url].absoluteString]];
    
}

- (float)audioDurationFromURL:(NSString *)url {
    AVURLAsset *audioAsset = nil;
    NSDictionary *dic = @{AVURLAssetPreferPreciseDurationAndTimingKey:@(YES)};
    if ([url hasPrefix:@"http://"]) {
        audioAsset = [AVURLAsset URLAssetWithURL:[NSURL URLWithString:url] options:dic];
    }else {
        audioAsset = [AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:url] options:dic];
    }
    CMTime audioDuration = audioAsset.duration;
    float audioDurationSeconds = CMTimeGetSeconds(audioDuration);
    return audioDurationSeconds;
}

#pragma mark - Button Method
- (void)playBtnClick:(UIButton *)button {
    button.selected = !button.selected;
    if (button.selected) {
        [button setSelected:YES];
        [button setImage:[UIImage imageNamed:@"cell-pause1"] forState:UIControlStateNormal];
        
        [[TYRecorderTool shareInstance] playbackMemo:self.memo];
        
        [TYRecorderTool shareInstance].audioPlayerStopPlayingCompletionHandler = ^(BOOL success) {
            if (success) {
                [button setSelected:NO];
                [button setImage:[UIImage imageNamed:@"cell-play"] forState:UIControlStateNormal];
            }
        };
        
        
    } else {
        [button setSelected:NO];
        [button setImage:[UIImage imageNamed:@"cell-play"] forState:UIControlStateSelected];
    }
}

- (void)deleteBtnClick:(UIButton *)button {
}

#pragma mark - UI
- (void)setupUI {
  self.backgroundColor = [UIColor whiteColor];
  self.cellTitileLabel.frame = CGRectMake(20, 15, 300, 30);
  [self addSubview:self.cellTitileLabel];
  
  self.cellTimeLabel.frame = CGRectMake(TYSCREEN_WIDTH - 50, 15, 100, 30);
  [self addSubview:self.cellTimeLabel];
  
  self.playBtn.frame = CGRectMake(20, 60 + 5, 20, 20);
  [self addSubview:self.playBtn];
  
  self.deleteBtn.frame = CGRectMake(TYSCREEN_WIDTH - 20 - 20, 60 + 5, 20, 20);
  [self addSubview:self.deleteBtn];
    
}

#pragma mark - Lazy Load
- (UILabel *)cellTitileLabel {
    if (nil == _cellTitileLabel) {
        _cellTitileLabel = [[UILabel alloc] init];
        _cellTitileLabel.textColor = [UIColor lightGrayColor];
        _cellTitileLabel.font = [UIFont systemFontOfSize:14];
        _cellTitileLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _cellTitileLabel;
}

- (UILabel *)cellTimeLabel {
    if (nil == _cellTimeLabel) {
        _cellTimeLabel = [[UILabel alloc] init];
        _cellTimeLabel.textColor = [UIColor lightGrayColor];
        _cellTimeLabel.font = [UIFont systemFontOfSize:14];
        _cellTimeLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _cellTimeLabel;
}

- (UIButton *)playBtn {
    if (nil == _playBtn) {
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playBtn setImage:[UIImage imageNamed:@"cell-play"] forState:UIControlStateNormal];
        [_playBtn addTarget:self action:@selector(playBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}

- (UIButton *)deleteBtn {
    if (nil == _deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setImage:[UIImage imageNamed:@"cell-pause1"] forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}

@end

//
//  MusicPlayingView.m
//  ToDoList
//
//  Created by Mark Lewis on 15-8-31.
//  Copyright (c) 2015年 TechLewis. All rights reserved.
//

#import "MusicPlayingView.h"

@implementation MusicPlayingView


#pragma mark - Initialization
- (void)setArtistImage:(UIImage *)artistImage
{
    _artistImage = artistImage;
    
    if(artistImage == nil) _artistImage = [UIImage imageNamed:@"defaultArtistImage"];
    [self setNeedsDisplay];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    //绘制图形
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [[UIColor blackColor] setStroke];
    [path setLineWidth:3];
    //*******************************************************************************
    //这之间的内容决定你画的是什么图形
    [path addArcWithCenter:self.center radius:100 startAngle:0 endAngle:2*M_PI clockwise:NO];
	// CGContextAddArc(context, self.center.x, self.center.y, 70, 0.0, 2*M_PI, NO);// self.center为圆心 100 是半径
    
    [path addClip];
    UIImage *image = self.artistImage;
    CGRect imageRect = {{(self.bounds.size.width-200)/2,(self.bounds.size.height-200)/2},{200, 200}};
    [image drawInRect:imageRect];
    
    //这之间的内容决定你画的是什么图形
    //*******************************************************************************
    [path stroke];
    
    
    
    
}

@end

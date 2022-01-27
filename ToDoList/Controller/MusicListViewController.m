//
//  MusicListViewController.m
//  ToDoList
//
//  Created by Mark Lewis on 15-8-27.
//  Copyright (c) 2015年 TechLewis. All rights reserved.
//

#import "MusicListViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "MusicPlayerViewController.h"
#import "UIImage+ImageEffects.h"
@interface MusicListViewController ()

@property (nonatomic, strong) NSMutableArray *musicArray;
@property (nonatomic, strong) NSMutableArray *movieArray;
@property (nonatomic, strong) NSIndexPath *chosenIndexPath;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, strong) MPMoviePlayerViewController *mediaPlayerController;
@property (nonatomic, strong) AVURLAsset *selectedURLAsset;

@end

@implementation MusicListViewController

- (NSString *)documentsPath
{
    // 获取应用程序沙盒的documents路径
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentsPath = paths[0];
    // 合成指定plist文件的全路径
    // NSString *filename=[plistPath1 stringByAppendingPathComponent:@"Music"];
    
    return documentsPath;
}


- (void)playMusic
{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        if (self.musicArray.count > 0)
        {
            NSString *musicPath = [[self documentsPath] stringByAppendingPathComponent:self.musicArray[0]];
            
            NSData *data = [NSData dataWithContentsOfFile:musicPath];
            NSError *err = nil;
            _audioPlayer = [[AVAudioPlayer alloc] initWithData:data error:&err];
            _audioPlayer.volume=0.8;
            // [_audioPlayer prepareToPlay];
            
            if (!err)
            {
                
                [_audioPlayer play];
            }
            
            NSLog(@"%@", [NSURL fileURLWithPath:musicPath]);
        }
        else
        {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Empty!"
                                                             message:@"Please connect iTunes and share mp3 File."
                                                            delegate:nil
                                                   cancelButtonTitle:@"Cancel"
                                                   otherButtonTitles: nil];
            
            [alert performSelector:@selector(show) withObject:nil afterDelay:0.2];
        }
        
        
    });
}
#pragma mark - Lifecycle
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Music List";
    self.musicArray = [NSMutableArray array];
    self.movieArray = [NSMutableArray array];
    
    for (NSString *filePath in [[NSFileManager defaultManager] enumeratorAtPath:[self documentsPath]])
    {
        if ([filePath.pathExtension isEqualToString:@"mp3"])
        {
            NSURL *fileURL = [NSURL fileURLWithPath:[[self documentsPath] stringByAppendingPathComponent:filePath]];
            AVURLAsset *avURLAsset = [[AVURLAsset alloc] initWithURL:fileURL options:nil];
            //初始化urlAsset，options中可以指定要求准确播放时长
            [self.musicArray addObject:avURLAsset
             ];
            // [self.musicArray addObject:[[self documentsPath] stringByAppendingPathComponent:filePath]];
        }
        
        if ([filePath.pathExtension isEqualToString:@"mp4"])
        {
            NSURL *fileURL = [NSURL fileURLWithPath:[[self documentsPath] stringByAppendingPathComponent:filePath]];
            NSDictionary *movieMap = @{filePath: fileURL};
            [self.movieArray addObject:movieMap];
        }
    }
    
    if (self.musicArray.count <= 0)
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Empty!"
                                                         message:@"Please connect iTunes and share mp3 File."
                                                        delegate:nil
                                               cancelButtonTitle:@"Cancel"
                                               otherButtonTitles: nil];
        
        [alert performSelector:@selector(show) withObject:nil afterDelay:0.2];
    }
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section != 0) return self.movieArray.count;

    return self.musicArray.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) return @"本地音乐";
    return @"本地资源";
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    
    if (indexPath.section != 0)
    {
        // 我是电影
        NSDictionary *dict = self.movieArray[indexPath.row];
        cell.textLabel.text = [dict.allKeys firstObject];
        cell.detailTextLabel.text = @"我是电影";
        return cell;
    }
    
    
    // Configure the cell...
    AVURLAsset *mp3Asset = self.musicArray[indexPath.row];
    NSString *mp3FileName = [[[mp3Asset URL] absoluteString]
                             stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    // 取得最后一个斜杠/的路径
    NSString *musicTitle = [mp3FileName.lastPathComponent stringByDeletingPathExtension];
    cell.textLabel.text = musicTitle;
    
    // 将取出的MP3Asset的格式遍历，取得元数据的信息
    for (NSString *format in [mp3Asset availableMetadataFormats])
    {
        for (AVMetadataItem *metadataItem in [mp3Asset metadataForFormat:format])
        {
            // NSLog(@"commonKey:%@ ",metadataItem.commonKey);
            if([metadataItem.commonKey isEqualToString:@"artist"])
            {
                // 取出演唱者的name
                NSString *artistName = [(NSString *)metadataItem.value stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                cell.detailTextLabel.text = [NSString stringWithFormat:@"artist: %@ - %@", artistName, musicTitle];
                cell.detailTextLabel.textColor = [UIColor lightGrayColor];
            }
            
            /*
            if ([metadataItem.commonKey isEqualToString:@"artwork"])
            {
                // 取出封面artwork，从data转成image显示
                // cell.imageView.image = [UIImage imageWithData:[(NSDictionary*)metadataItem.value objectForKey:@"data"]];
            }
             */
        }
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section != 0)
    {
        // 我是电影
        NSDictionary *dict = self.movieArray[indexPath.row];
        self.mediaPlayerController = [[MPMoviePlayerViewController alloc] initWithContentURL:[dict.allValues firstObject]];
        [self presentMoviePlayerViewControllerAnimated:_mediaPlayerController];
        return;
    }
    
    AVURLAsset *mp3URLAsset = self.musicArray[indexPath.row];
    // code
    NSString *title = [mp3URLAsset.URL.lastPathComponent stringByDeletingPathExtension];
    NSString *musicName = mp3URLAsset.URL.lastPathComponent;
    UIImage *artworkImage;
    
    // 将取出的MP3Asset的格式遍历，取得元数据的信息
    for (NSString *format in [mp3URLAsset availableMetadataFormats])
    {
        for (AVMetadataItem *metadataItem in [mp3URLAsset metadataForFormat:format])
        {
            // NSLog(@"commonKey:%@ ",metadataItem.commonKey);
            if ([metadataItem.commonKey isEqualToString:@"artwork"])
            {
                artworkImage = [UIImage imageWithData:[(NSDictionary*)metadataItem.value objectForKey:@"data"]];
                
            }
            
            if([metadataItem.commonKey isEqualToString:@"artist"])
            {
                // 取出演唱者的name
                //NSString *artistName = [(NSString *)metadataItem.value stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                // [NSString stringWithFormat:@"artist: %@ - %@", artistName, musicTitle];
            }
        }
    }

    MusicPlayerViewController *vc = [[MusicPlayerViewController alloc] init];
    vc.title = title;
    vc.musicName = musicName;
    vc.artworkImage = artworkImage;
    [self.navigationController pushViewController:vc animated:YES];
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

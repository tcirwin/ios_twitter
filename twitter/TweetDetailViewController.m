//
//  TweetDetailViewController.m
//  twitter
//
//  Created by Therin Irwin on 10/20/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "TweetDetailViewController.h"
#import "Common.h"
#import <UIImageView+AFNetworking.h>
#import "ComposeViewController.h"

#define RETWEET 0
#define REPLY 1
#define FAVORITE 2

@interface TweetDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetTextLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *actionBar;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (strong, nonatomic) Tweet *tweet;

- (IBAction)tappedActionBar:(UISegmentedControl *)sender;

@end

@implementation TweetDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil andModel:(Tweet *)tweet bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _tweet = tweet;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _usernameLabel.text = _tweet.username;
    _tweetTextLabel.text = _tweet.text;
    _timestampLabel.text = _tweet.timestamp;
    
    NSString *favLabel = _tweet.favorited ? @"Favorited" : @"Favorite";
    [_actionBar setTitle:favLabel forSegmentAtIndex:FAVORITE];
    
    [_tweetTextLabel sizeToFit];
    
    [_userImageView setImageWithURLRequest:[NSURLRequest requestWithURL:_tweet.userImageURL] placeholderImage:PLACEHOLDER_IMAGE success:nil failure:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)retweet
{
    [[TwitterClient instance] reTweet:_tweet.tweetId success:^(AFHTTPRequestOperation *operation, id response) {
        NSLog(@"Success!");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure: retweeting tweet %@!", _tweet.tweetId);
    }];
}

- (void)reply
{
    ComposeViewController *compose = [[ComposeViewController alloc] initWithNibName:@"ComposeViewController" andReplyId:_tweet.tweetId andRepliedUsername:_tweet.screenName];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:compose];
    
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)favorite
{
    if (_tweet.favorited) {
        [[TwitterClient instance] unFavorite:_tweet.tweetId success:^(AFHTTPRequestOperation *operation, id response) {
            NSLog(@"Success: unfavorited tweet: %@", _tweet.tweetId);
            [_actionBar setTitle:@"Favorite" forSegmentAtIndex:FAVORITE];
            _tweet.favorited = NO;
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Failure: didn't favorite tweet: %@", _tweet.tweetId);
        }];
    } else {
        [[TwitterClient instance] favorite:_tweet.tweetId success:^(AFHTTPRequestOperation *operation, id response) {
            NSLog(@"Success: favorited tweet: %@", _tweet.tweetId);
            [_actionBar setTitle:@"Favorited" forSegmentAtIndex:FAVORITE];
            _tweet.favorited = YES;
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Failure: didn't favorite tweet: %@", _tweet.tweetId);
        }];
    }
}

- (IBAction)tappedActionBar:(UISegmentedControl *)sender
{
    switch ([sender selectedSegmentIndex]) {
        case RETWEET:
            [self retweet];
            break;
        case REPLY:
            [self reply];
            break;
        case FAVORITE:
            [self favorite];
            break;
    }
}
@end

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

@interface TweetDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetTextLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (strong, nonatomic) Tweet *tweet;

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
    
    [_tweetTextLabel sizeToFit];
    
    [_userImageView setImageWithURLRequest:[NSURLRequest requestWithURL:_tweet.userImageURL] placeholderImage:PLACEHOLDER_IMAGE success:nil failure:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

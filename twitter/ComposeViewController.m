//
//  ComposeViewController.m
//  twitter
//
//  Created by Therin Irwin on 10/21/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "ComposeViewController.h"

@interface ComposeViewController ()
{
    NSString *_replyId;
    NSString *_screenName;
}

@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;

@end

@implementation ComposeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil andReplyId:(NSString *)replyId andRepliedUsername:(NSString *)screenName
{
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    if (self) {
        _replyId = replyId;
        _screenName = screenName;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(closeComposeModal)];
    
    UIBarButtonItem *tweetButton = [[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStylePlain target:self action:@selector(postTweet)];
    
    self.title = @"Compose Tweet";
    self.navigationItem.leftBarButtonItem = closeButton;
    self.navigationItem.rightBarButtonItem = tweetButton;
    
    if (_replyId) {
        _tweetTextView.text = [NSString stringWithFormat:@"@%@", _screenName];
    }
    
    [_tweetTextView becomeFirstResponder];
}

- (void)postTweet
{
    if (!_replyId) {
        [[TwitterClient instance] tweet:_tweetTextView.text success:^(AFHTTPRequestOperation *operation, id response) {
            NSLog(@"Success; posted tweet!");
            [self.delegate reload];
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Failure: failed to post tweet!");
        }];
    } else {
        [[TwitterClient instance] replyTo:_replyId withText:_tweetTextView.text success:^(AFHTTPRequestOperation *operation, id response) {
            NSLog(@"Success; replied to tweet: %@!", _replyId);
            [self.delegate reload];
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Failure: failed to reply to tweet: %@!", _replyId);
        }];
    }
}

- (void)closeComposeModal
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

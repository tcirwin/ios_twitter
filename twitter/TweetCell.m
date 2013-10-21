//
//  TweetCell.m
//  twitter
//
//  Created by Timothy Lee on 8/6/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "TweetCell.h"
#import <UIImageView+AFNetworking.h>
#import "Common.h"

@interface TweetCell()

- (IBAction)handleTap:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *tweetTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;

@end

@implementation TweetCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateModel:(Tweet *)model
{
    _tweetTextLabel.text = model.text;
    _usernameLabel.text = model.username;
    _timestampLabel.text = model.timestamp;
    
    [_userImageView setImageWithURLRequest:[NSURLRequest requestWithURL:model.userImageURL] placeholderImage:PLACEHOLDER_IMAGE success:nil failure:nil];
}

- (IBAction)handleTap:(id)sender {
    NSLog(@"tapped");
}
@end

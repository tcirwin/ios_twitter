//
//  Tweet.m
//  twitter
//
//  Created by Timothy Lee on 8/5/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "Tweet.h"
#import <NSDate+TimeAgo.h>
#import <UIImageView+AFNetworking.h>

@implementation Tweet

+ (NSMutableArray *)tweetsWithArray:(NSArray *)array {
    NSMutableArray *tweets = [[NSMutableArray alloc] initWithCapacity:array.count];
    for (NSDictionary *params in array) {
        [tweets addObject:[[Tweet alloc] initWithDictionary:params]];
    }
    return tweets;
}

- (id)initWithDictionary:(NSDictionary *)data
{
    self = [super initWithDictionary:data];
    
    if (self) {
        _favorited = [[self.data valueOrNilForKeyPath:@"favorited"] boolValue];
    }
    
    return self;
}

- (NSString *) tweetId
{
    return [self.data valueOrNilForKeyPath:@"id_str"];
}

- (NSString *)text
{
    return [self.data valueOrNilForKeyPath:@"text"];
}

- (NSString *)timestamp
{
    NSString *datetime = [self.data valueOrNilForKeyPath:@"created_at"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEE MMM dd HH:mm:ss Z yyyy"];
    NSDate *date = [formatter dateFromString:datetime];
    
    return [date timeAgo];
}

- (NSString *)username
{
    return [[self.data valueOrNilForKeyPath:@"user"] valueOrNilForKeyPath:@"name"];
}

- (NSString *)screenName
{
    return [[self.data valueOrNilForKeyPath:@"user"] valueOrNilForKeyPath:@"screen_name"];
}

- (NSURL *)userImageURL
{
    return [NSURL URLWithString:[[self.data valueOrNilForKeyPath:@"user"] valueOrNilForKeyPath:@"profile_image_url"]];
}

@end

//
//  Tweet.h
//  twitter
//
//  Created by Timothy Lee on 8/5/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tweet : RestObject

@property (nonatomic) BOOL favorited;
@property (nonatomic, strong, readonly) NSString *text;

+ (NSMutableArray *)tweetsWithArray:(NSArray *)array;

- (NSString *)tweetId;
- (NSString *)text;
- (NSString *)timestamp;
- (NSString *)username;
- (NSString *)screenName;
- (NSURL *)userImageURL;

@end

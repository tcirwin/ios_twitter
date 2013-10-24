//
//  ComposeViewController.h
//  twitter
//
//  Created by Therin Irwin on 10/21/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataReloadable.h"

@interface ComposeViewController : UIViewController

@property (weak, nonatomic) id<DataReloadable> delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil andReplyId:(NSString *)replyId andRepliedUsername:(NSString *)username;

@end

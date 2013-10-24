//
//  TweetDetailViewController.h
//  twitter
//
//  Created by Therin Irwin on 10/20/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataReloadable.h"

@interface TweetDetailViewController : UIViewController

@property (weak, nonatomic) id<DataReloadable> delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil andModel:(Tweet *)tweet bundle:(NSBundle *)nibBundleOrNil;

@end

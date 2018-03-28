//
//  DetailViewController.h
//  MailList
//
//  Created by OurEDA on 2018/3/15.
//  Copyright © 2018年 OurEDA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"
#import "MailItem.h"
#import "AddMailController.h"
#import "MailListDataManager.h"

@interface DetailViewController : UIViewController <AddMailProtocol> {
    UIImageView *imageView;
    UIImageView *imageBack;
    UIImageView *imageEdit;

    NSUserDefaults *myUserDefaults;
    NSDictionary *mailDetail;

    UILabel *labelName;
    UIButton *btnPhone;
    UIButton *btnEmail;
    UITextView *tvDescription;
    UIButton *btnDelete;
}

@end

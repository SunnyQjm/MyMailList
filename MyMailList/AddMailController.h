//
//  AddMailController.h
//  MailList
//
//  Created by OurEDA on 2018/3/14.
//  Copyright © 2018年 OurEDA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddMailProtocol.h"

@interface AddMailController : UIViewController<UITextFieldDelegate>{
    UILabel *labelBar;
    UIButton *btnBack;
    UIButton *btnSave;
    UITextField *tfName;
    UITextField *tfPhone;
    UITextField *tfEmail;
    UITextField *tfDescription;
    UILabel *errTip;

    NSUserDefaults *myUserDefaults;
    NSDictionary *mailDetail;


}

@property (nonatomic, strong) id<AddMailProtocol> delegate;

@end

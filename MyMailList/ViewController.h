//
//  ViewController.h
//  MailList
//
//  Created by OurEDA on 2018/3/14.
//  Copyright © 2018年 OurEDA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddMailController.h"
#import "AddMailProtocol.h"
#import "DetailViewController.h"
#import "MailListDataManager.h"


@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, AddMailProtocol>{
    UIButton *btnAdd;
    UILabel *labelBar;
    UITableView *tableView;
    NSDictionary *mailList;
    NSArray *keys;

    NSUserDefaults *myUserDefaults;
}



@end


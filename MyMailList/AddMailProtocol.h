//
//  AddMailProtocol.h
//  MailList
//
//  Created by OurEDA on 2018/3/14.
//  Copyright © 2018年 OurEDA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MailItem.h"

@protocol AddMailProtocol <NSObject>
- (void)add:(MailItem *)item;
@end

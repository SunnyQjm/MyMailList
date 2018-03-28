//
// Created by OurEDA on 2018/3/17.
// Copyright (c) 2018 OurEDA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MailList+CoreDataClass.h"


@interface MailListDataManager : NSObject{
    NSMutableDictionary *mailList;
    NSString *plistPath;

    NSManagedObjectContext *context;
}

- (void)initData:(NSString *)path;

- (NSMutableDictionary *)getMailList;

- (BOOL) add: (NSDictionary *)item;

- (BOOL) update: (NSString *) key withItem:(NSDictionary *)item;

- (BOOL) remove: (NSString *) key;

+ (MailListDataManager *)getInstance;
@end
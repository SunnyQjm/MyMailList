//
//  MailList+CoreDataProperties.m
//  MyMailList
//
//  Created by OurEDA on 2018/3/28.
//  Copyright © 2018年 OurEDA. All rights reserved.
//
//

#import "MailList+CoreDataProperties.h"

@implementation MailList (CoreDataProperties)

+ (NSFetchRequest<MailList *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"MailList"];
}

@dynamic email;
@dynamic myDescription;
@dynamic name;
@dynamic phone;
@dynamic uid;

@end

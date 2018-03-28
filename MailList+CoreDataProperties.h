//
//  MailList+CoreDataProperties.h
//  MyMailList
//
//  Created by OurEDA on 2018/3/28.
//  Copyright © 2018年 OurEDA. All rights reserved.
//
//

#import "MailList+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface MailList (CoreDataProperties)

+ (NSFetchRequest<MailList *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *email;
@property (nullable, nonatomic, copy) NSString *myDescription;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *phone;
@property (nullable, nonatomic, copy) NSString *uid;

@end

NS_ASSUME_NONNULL_END

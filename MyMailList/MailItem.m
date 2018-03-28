//
//  MailItem.m
//  MailList
//
//  Created by OurEDA on 2018/3/14.
//  Copyright © 2018年 OurEDA. All rights reserved.
//

#import "MailItem.h"

@implementation MailItem
- (instancetype)initWithName:(NSString *)aName phone:(NSString *)aPhone email:(NSString *)anEmail
                 description:(NSString *)aDescription{
    self = [super init];
    if (self) {
        self.name = aName;
        self.phone = aPhone;
        self.email = anEmail;
        self.myDescription = aDescription;
        self.uid = [MailItem gen_uuid];
    }

    return self;
}

- (instancetype)initWithName:(NSString *)aName phone:(NSString *)aPhone email:(NSString *)anEmail description:(NSString *)aDescription uid:(NSString *)uid {
    self = [super init];
    if (self) {
        self.name = aName;
        self.phone = aPhone;
        self.email = anEmail;
        self.myDescription = aDescription;
        self.uid = uid;
    }

    return self;
}


+ (NSString *) gen_uuid{

    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);

    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);

    CFRelease(uuid_ref);

    NSString *uuid = [NSString stringWithString:(__bridge NSString*)uuid_string_ref];

    CFRelease(uuid_string_ref);

    return uuid;

}

- (NSDictionary *)toDictionary {
    NSDictionary *myItem = @{@"name": self.name, @"phone": self.phone,
            @"email": self.email, @"description": self.myDescription,
            @"uid": self.uid};
    return myItem;
}

+ (MailItem *)toMailItem:(NSDictionary *)d {
    MailItem *mailItem = [[MailItem alloc] initWithName:d[@"name"] phone:d[@"phone"]
                                                  email:d[@"email"] description:d[@"description"]
                                                    uid:d[@"uid"]];
    return mailItem;
}


@end

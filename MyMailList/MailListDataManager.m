//
// Created by OurEDA on 2018/3/17.
// Copyright (c) 2018 OurEDA. All rights reserved.
//

#import "MailListDataManager.h"


@implementation MailListDataManager {

}

static MailListDataManager * instance = nil;

- (void)initData:(NSString *)myPath {
//    //沙盒获取路径
//    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *path = pathArray[0];
//    //获取文件的完整路径
//    NSString *filePath = [path stringByAppendingPathComponent:myPath];//没有会自动创建
//    NSLog(@"file patch%@",filePath);
//    plistPath = filePath;
//    mailList = [[NSMutableDictionary alloc]initWithContentsOfFile:filePath];
//    NSLog(@"%@", mailList == nil ? @"nil" : @"not nil");
//    if(mailList == nil){        //第一次读取初始数据
//        /**
//        * 获取数据
//        */
//        NSString *plistPath = [[NSBundle mainBundle] pathForResource:myPath ofType:@"plist"];
//        mailList = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
//        [self saveToCoreData];
//    }

    [self QueryCoreData];
//    NSFetchRequest *request = [[NSFetchRequest alloc] init];
//    request.entity = [NSEntityDescription entityForName:@"MailList" inManagedObjectContext:context];
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uid LIKE *"];
//    request.predicate = predicate;

}


- (void)QueryCoreData{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:@"MailList" inManagedObjectContext:context];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uid LIKE[cd] '*'"];
    request.predicate = predicate;

    NSError *error = nil;
    NSArray *objs = [context executeFetchRequest:request error:&error];
    if (error) {
        [NSException raise:@"查询错误" format:@"%@", [error localizedDescription]];
    }

    mailList = [[NSMutableDictionary alloc] init];

    for (NSManagedObject *obj in objs) {
        NSLog(@"name = %@, uid = %@, phone = %@", [obj valueForKey:@"name"], [obj valueForKey:@"uid"], [obj valueForKey:@"phone"]);
        NSMutableDictionary *d = [[NSMutableDictionary alloc] init];
        d[@"name"] = [obj valueForKey:@"name"];
        d[@"phone"] = [obj valueForKey:@"phone"];
        d[@"email"] = [obj valueForKey:@"email"];
        d[@"description"] = [obj valueForKey:@"myDescription"];
        d[@"uid"] = [obj valueForKey:@"uid"];
        mailList[[obj valueForKey:@"uid"]] = d;
    }
}

- (BOOL)add:(NSDictionary *)item {
    [mailList setValue:item forKey:item[@"uid"]];
    NSManagedObject *s1 = [NSEntityDescription insertNewObjectForEntityForName:@"MailList" inManagedObjectContext:context];
    [s1 setValue:item[@"name"] forKey:@"name"];
    [s1 setValue:item[@"uid"] forKey:@"uid"];
    [s1 setValue:item[@"email"] forKey:@"email"];
    [s1 setValue:item[@"phone"] forKey:@"phone"];
    [s1 setValue:item[@"description"] forKey:@"myDescription"];

    return [self saveToCoreData];
}

- (BOOL)update:(NSString *)key withItem:(NSDictionary *)item {
    [mailList setValue:item forKey:key];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"MailList"];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uid = %@", key];
    request.predicate = predicate;

    //发送请求
    NSArray *resArray = [context executeFetchRequest:request error:nil];
    for(MailList *ml in resArray){
        ml.name = item[@"name"];
        ml.phone = item[@"phone"];
        ml.email = item[@"email"];
        ml.myDescription = item[@"description"];
    }

    return [self saveToCoreData];
}

- (BOOL)remove:(NSString *)key {
    [mailList removeObjectForKey:key];
    //创建删除请求
    NSFetchRequest *deleRequest = [NSFetchRequest fetchRequestWithEntityName:@"MailList"];

    //删除条件
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"uid = %@", key];
    deleRequest.predicate = pre;

    //返回需要删除的对象数组
    NSArray *deleArray = [context executeFetchRequest:deleRequest error:nil];

    //从数据库中删除
    for (MailList *ml in deleArray) {
        [context deleteObject:ml];
    }

    return [self saveToCoreData];
}

- (BOOL)saveToCoreData{
    //保存
    NSError *error = nil;
    if ([context save:&error]) {
        return true;
    }else{
        NSLog(@"更新数据失败, %@", error);
        return false;
    }
}

- (NSMutableDictionary *)getMailList {
    return mailList;
}


- (instancetype)init {
    NSLog(@"MailListManager: init");
    if(self = [super init]){
        NSError *error = nil;

        NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
        NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];

        NSString *docs = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSURL *url = [NSURL fileURLWithPath:[docs stringByAppendingString:@"MailList.sqlite"]];

        NSPersistentStore *store = [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error];

        if (store == nil) {
            [NSException raise:@"DB Error" format:@"%@", [error localizedDescription]];
        }

        context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        context.persistentStoreCoordinator = psc;
    }
    return self;
}

+ (MailListDataManager *)getInstance {
    if(instance == nil){
        instance = [[MailListDataManager alloc] init];

    }
    return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    if (instance == nil) {
        instance = (MailListDataManager *) [super allocWithZone:zone];
    }
    return instance;
}

//重写copy方法中会调用的copyWithZone方法，确保单例实例复制时不会重新创建
-(id) copyWithZone:(struct _NSZone *)zone
{
    return instance;
}

@end
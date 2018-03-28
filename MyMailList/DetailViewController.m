//
//  DetailViewController.m
//  MailList
//
//  Created by OurEDA on 2018/3/15.
//  Copyright © 2018年 OurEDA. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    myUserDefaults = NSUserDefaults.standardUserDefaults;

    NSInteger alreadyLayoutHeight = 0;

    NSInteger rootViewWidth = (NSInteger) self.view.bounds.size.width;
    NSInteger rootViewHeight = (NSInteger) self.view.bounds.size.height;
    UIImage *imgBg = [UIImage imageNamed:@"bg.jpeg"];
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, rootViewWidth, 300)];
    [imageView setImage:imgBg];
    [self.view addSubview:imageView];

    alreadyLayoutHeight += 300;

    UIImage *backImage = [UIImage imageNamed:@"back.png"];
    imageBack = [[UIImageView alloc] initWithFrame:CGRectMake(10, 30, 30, 30)];
    [imageBack setImage:backImage];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]
            initWithTarget:self action:@selector(imageBackPressed:)];
    [imageBack addGestureRecognizer:tapGesture];
    imageBack.userInteractionEnabled = YES;
    [self.view addSubview:imageBack];

    UIImage *editImage = [UIImage imageNamed:@"edit.png"];
    imageEdit = [[UIImageView alloc] initWithFrame:CGRectMake(rootViewWidth - 40, 30, 30, 30)];
    [imageEdit setImage:editImage];
    tapGesture = [[UITapGestureRecognizer alloc]
            initWithTarget:self action:@selector(imageEditPressed:)];
    [imageEdit addGestureRecognizer:tapGesture];
    imageEdit.userInteractionEnabled = YES;
    [self.view addSubview:imageEdit];

    labelName = [[UILabel alloc] initWithFrame:
            CGRectMake(0, alreadyLayoutHeight - 100, rootViewWidth, 50)];
    labelName.textAlignment = NSTextAlignmentCenter;
    [labelName setTextColor:[UIColor whiteColor]];
    labelName.font = [UIFont systemFontOfSize:50];
    [self.view addSubview:labelName];

    btnPhone = [[UIButton alloc] initWithFrame:CGRectMake(0, alreadyLayoutHeight, rootViewWidth, 50)];
    btnPhone.layer.borderColor = [UIColor lightGrayColor].CGColor;
    btnPhone.layer.borderWidth = 1;
    [btnPhone setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.view addSubview:btnPhone];

    alreadyLayoutHeight += 50;

    btnEmail = [[UIButton alloc] initWithFrame:CGRectMake(0, alreadyLayoutHeight - 1, rootViewWidth, 50)];
    [btnEmail setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btnEmail.layer.borderColor = [UIColor lightGrayColor].CGColor;
    btnEmail.layer.borderWidth = 1;
    [self.view addSubview:btnEmail];

    alreadyLayoutHeight += 50;

    tvDescription = [[UITextView alloc] initWithFrame:CGRectMake(0, alreadyLayoutHeight, rootViewWidth, 200)];
    [tvDescription setTextColor:[UIColor grayColor]];


    btnDelete = [[UIButton alloc] initWithFrame:CGRectMake(0, rootViewHeight - 50, rootViewWidth, 50)];
    btnDelete.backgroundColor = [UIColor redColor];
    [btnDelete setTitle:@"删除" forState:UIControlStateNormal];
    [btnDelete addTarget:self action:@selector(btnDeletePressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tvDescription];

    [self.view addSubview:btnDelete];

    [self fillInfo];
}

- (void)btnDeletePressed:(id)target {

    UIAlertController *mAC = [UIAlertController
            alertControllerWithTitle:@"提示" message:@"确定删除？" preferredStyle:UIAlertControllerStyleAlert];
    [mAC addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
        NSString *key = [myUserDefaults valueForKey:@"selectKey"];
        [[MailListDataManager getInstance] remove:key];
        [self.navigationController popViewControllerAnimated:YES];
    }]];
    [mAC addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
    }]];
    [self presentViewController:mAC animated:YES completion:nil];
}

- (void)fillInfo {
    mailDetail = [myUserDefaults valueForKey:@"selectTarget"];
    MailItem *mailItem = [MailItem toMailItem:mailDetail];
    [btnEmail setTitle:mailItem.email forState:UIControlStateNormal];
    [btnPhone setTitle:mailItem.phone forState:UIControlStateNormal];
    [tvDescription setText:mailItem.myDescription];
    [labelName setText:mailItem.name];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)imageBackPressed:(id)target {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)imageEditPressed:(id)target {
    [myUserDefaults setObject:mailDetail forKey:@"edit"];
    AddMailController *addMailCV = [[AddMailController alloc] init];
    addMailCV.delegate = self;
    [self presentViewController:addMailCV animated:YES completion:Nil];
}

/**
 * 编辑以后的回调
 * @param item
 */
- (void)add:(MailItem *)item {
    NSDictionary *nsd = [item toDictionary];
    NSString *key = [myUserDefaults valueForKey:@"selectKey"];
    //更新数据
    [[MailListDataManager getInstance] update:key withItem:nsd];
    [myUserDefaults setObject:nsd forKey:@"selectTarget"];
    [self fillInfo];
}

/**
 * 当试图重新可见的时候加载新数据
 * @param animated
 */
- (void)viewWillAppear:(BOOL)animated {
    [self fillInfo];
    //并清楚编辑状态
    [myUserDefaults removeObjectForKey:@"edit"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  AddMailController.m
//  MailList
//
//  Created by OurEDA on 2018/3/14.
//  Copyright © 2018年 OurEDA. All rights reserved.
//

#import "AddMailController.h"

@interface AddMailController ()

@end

@implementation AddMailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];

    myUserDefaults = [NSUserDefaults standardUserDefaults];

    NSInteger rootViewWidth = (NSInteger) self.view.bounds.size.width;
    NSInteger rootViewHeight = (NSInteger) self.view.bounds.size.height;
    NSInteger alreadyLayoutHeight = 0;
    labelBar = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, rootViewWidth, 50)];
    labelBar.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:labelBar];
    
    btnBack = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 80, 50)];
    [btnBack setTitle:@"返回" forState:UIControlStateNormal];
    [btnBack setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(btnBackPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnBack];
    btnSave = [[UIButton alloc]initWithFrame:CGRectMake(rootViewWidth - 80, 20, 80, 50)];
    [btnSave setTitle:@"保存" forState:UIControlStateNormal];
    [btnSave setTitleColor:[UIColor whiteColor]
            forState:UIControlStateNormal];
    [btnSave addTarget:self action:@selector(btnSavePressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnSave];
    
    alreadyLayoutHeight += 70;
    NSInteger labelWidth = 100;
    NSInteger itemHeight = 50;
    
    UILabel *bg = [[UILabel alloc]initWithFrame:CGRectMake(0, alreadyLayoutHeight, rootViewWidth, rootViewHeight - alreadyLayoutHeight)];
    bg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bg];
    
    UILabel *labelName = [[UILabel alloc]initWithFrame:CGRectMake(20, alreadyLayoutHeight, labelWidth, itemHeight)];
    labelName.text = @"姓名: ";
    [self.view addSubview:labelName];
    tfName = [[UITextField alloc]initWithFrame:CGRectMake(labelWidth, alreadyLayoutHeight, rootViewWidth - labelWidth, itemHeight)];
    tfName.placeholder = @"请输入姓名";
    tfName.borderStyle = UITextBorderStyleRoundedRect;
    tfName.clearButtonMode = UITextFieldViewModeAlways;
    tfName.delegate = self;
    tfName.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.view addSubview:tfName];

    alreadyLayoutHeight += itemHeight;

    UILabel *labelPhone = [[UILabel alloc]initWithFrame:CGRectMake(20, alreadyLayoutHeight, labelWidth, itemHeight)];
    labelPhone.text = @"手机号: ";
    [self.view addSubview:labelPhone];
    tfPhone = [[UITextField alloc]initWithFrame:CGRectMake(labelWidth, alreadyLayoutHeight, rootViewWidth - labelWidth, itemHeight)];
    tfPhone.placeholder = @"请输入手机号";
    tfPhone.borderStyle = UITextBorderStyleRoundedRect;
    [tfPhone setKeyboardType:UIKeyboardTypePhonePad];
    tfPhone.clearButtonMode = UITextFieldViewModeAlways;
    tfPhone.autocapitalizationType = UITextAutocapitalizationTypeNone;
    tfPhone.delegate = self;
    [self.view addSubview:tfPhone];
    
    alreadyLayoutHeight += itemHeight;
    
    UILabel *labelMail = [[UILabel alloc]initWithFrame:CGRectMake(20, alreadyLayoutHeight, labelWidth, itemHeight)];
    labelMail.text = @"邮箱: ";
    [self.view addSubview:labelMail];
    tfEmail = [[UITextField alloc]initWithFrame:CGRectMake(labelWidth, alreadyLayoutHeight, rootViewWidth - labelWidth, itemHeight)];
    tfEmail.placeholder = @"请输入邮箱";
    [tfEmail setKeyboardType:UIKeyboardTypeEmailAddress];
    tfEmail.borderStyle = UITextBorderStyleRoundedRect;
    tfEmail.clearButtonMode = UITextFieldViewModeAlways;
    tfEmail.autocapitalizationType = UITextAutocapitalizationTypeNone;
    tfEmail.delegate = self;
    [self.view addSubview:tfEmail];
    
    alreadyLayoutHeight += itemHeight;
    
    UILabel *labelDescription = [[UILabel alloc]initWithFrame:CGRectMake(20, alreadyLayoutHeight, labelWidth, itemHeight)];
    labelDescription.text = @"备注: ";
    [self.view addSubview:labelDescription];
    
    tfDescription = [[UITextField alloc]initWithFrame:CGRectMake(labelWidth, alreadyLayoutHeight, rootViewWidth - labelWidth, itemHeight)];
    tfDescription.placeholder = @"请输入备注";
    tfDescription.borderStyle = UITextBorderStyleRoundedRect;
    tfDescription.clearButtonMode = UITextFieldViewModeAlways;
    tfDescription.delegate = self;
    tfDescription.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.view addSubview:tfDescription];
    
    alreadyLayoutHeight += itemHeight;
    
    
    errTip = [[UILabel alloc]initWithFrame:CGRectMake(0, rootViewHeight - 100, rootViewWidth, 100)];
    errTip.textAlignment = NSTextAlignmentCenter;
    [errTip setTextColor:[UIColor redColor]];
    [errTip setText:@"输入不能为空"];
    errTip.hidden = YES;
    [self.view addSubview: errTip];


    [self fillInfo];
}

- (void)fillInfo {
    mailDetail = [myUserDefaults valueForKey:@"edit"];
    if(mailDetail == NULL) {
        return;
    }
    MailItem *mailItem = [MailItem toMailItem:mailDetail];
    [tfEmail setText:mailItem.email];
    [tfName setText:mailItem.name];
    [tfPhone setText:mailItem.phone];
    [tfDescription setText:mailItem.myDescription];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    /**
     * 开始编辑的时候隐藏错误提示
     */
    errTip.hidden = YES;
}

- (void)btnBackPressed: (id)target{
    NSLog(@"click btnBack");
//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:Nil];
}

- (void)btnSavePressed: (id)target{
    NSString *name = tfName.text;
    NSString *phone = tfPhone.text;
    NSString *email = tfEmail.text;
    NSString *description = tfDescription.text;
    
    if([name isEqualToString:@""] || [phone isEqualToString:@""] ||
       [email isEqualToString:@""] || [description isEqualToString:@""]){   //不允许为空
        errTip.hidden = NO;
        return;
    }

    [_delegate add:[[MailItem alloc] initWithName:name phone:phone email:email description:description]];
    [self btnBackPressed:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

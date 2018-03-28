//
//  ViewController.m
//  MailList
//
//  Created by OurEDA on 2018/3/14.
//  Copyright © 2018年 OurEDA. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self.view setBackgroundColor:[UIColor blueColor]];
    [self.view setBackgroundColor: [UIColor grayColor]];
    myUserDefaults = NSUserDefaults.standardUserDefaults;

    NSInteger rootViewWidth = (NSInteger) self.view.bounds.size.width;
    NSInteger rootViewHeight = (NSInteger) self.view.bounds.size.height;
    labelBar = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, rootViewWidth, 50)];
    labelBar.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:labelBar];

    btnAdd = [[UIButton alloc] initWithFrame:CGRectMake(rootViewWidth - 80, 20, 80, 50)];
    [btnAdd setTitle:@"添加" forState:UIControlStateNormal];
    [btnAdd setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnAdd addTarget:self action:@selector(addPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnAdd];

    tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 70, rootViewWidth, rootViewHeight - 70)];
//    tableView.backgroundColor = [UIColor redColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];

    /**
     * 获取数据
     */
    [[MailListDataManager getInstance] initData:@"mailList"];
    mailList = [MailListDataManager getInstance].getMailList;
    NSLog(@"%@", mailList);
    keys = [mailList allKeys];
}


- (void) addPressed: (id)target{
    AddMailController * addMC = [[AddMailController alloc]init];
    addMC.delegate = self;
    [self presentViewController:addMC animated:YES completion:Nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)uiTableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *reuseFlag = @"reuseableFlag";
    UITableViewCell *cell = [uiTableView dequeueReusableCellWithIdentifier:reuseFlag];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseFlag];
    }
    NSDictionary *d = mailList[keys[(NSUInteger) [indexPath row]]];
    cell.textLabel.text = d[@"name"];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)uiTableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%ld", [keys count]);
    return [keys count];
}

/**
 * 添加数据回调
 * @param item
 */
- (void)add:(MailItem *)item {
    [[MailListDataManager getInstance] add:[item toDictionary]];
    [self updateUI];
}

- (void)updateUI{
    if(mailList != NULL){
        keys = [mailList allKeys];
        [tableView reloadData];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    //使得在主界面无法跳转到编辑界面
    [myUserDefaults removeObjectForKey:@"edit"];
    [self updateUI];
}


- (nullable NSIndexPath *)tableView:(UITableView *)uiTableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *d = mailList[keys[(NSUInteger) [indexPath row]]];
    [myUserDefaults setObject:d forKey:@"selectTarget"];
    [myUserDefaults setObject:keys[(NSUInteger) [indexPath row]] forKey:@"selectKey"];
    DetailViewController * detailVC = [[DetailViewController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
    return indexPath;
}

//- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
//    <#code#>
//}
//
//- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
//    <#code#>
//}
//
//- (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
//    <#code#>
//}
//
//- (CGSize)sizeForChildContentContainer:(nonnull id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize {
//    <#code#>
//}
//
//- (void)systemLayoutFittingSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
//    <#code#>
//}
//
//- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
//    <#code#>
//}
//
//- (void)willTransitionToTraitCollection:(nonnull UITraitCollection *)newCollection withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
//    <#code#>
//}
//
//- (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator {
//    <#code#>
//}
//
//- (void)setNeedsFocusUpdate {
//    <#code#>
//}
//
//- (BOOL)shouldUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context {
//    <#code#>
//}
//
//- (void)updateFocusIfNeeded {
//    <#code#>
//}

@end

//
//  AttendUpdate.m
//  Uninavi_attend
//
//  Created by owner_mac on 11/11/27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AttendUpdate.h"


@implementation AttendUpdate
@synthesize cusCell1;
@synthesize cusCell2;
@synthesize cusCell3;
@synthesize cusCell4;
@synthesize KessekiNum;
@synthesize AttNum;
@synthesize ChikokuNum;
@synthesize KyukoNum;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [cusCell1 release];
    [cusCell2 release];
    [cusCell3 release];
    [cusCell4 release];
    [KessekiNum release];
    [AttNum release];
    [ChikokuNum release];
    [KyukoNum release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self TableSettei];
    [self NaviSettei];

    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (void)TableSettei     //テーブルビューの設定
{
    self.tableView.alwaysBounceVertical = YES;
    self.tableView.allowsSelection = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.scrollEnabled = NO;
    self.tableView.rowHeight = 52;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

- (void)NaviSettei  //ナビゲーションバーの設定
{
    self.navigationItem.title = @"プロジェクト";
    self.navigationItem.prompt = @"出欠管理";    
}

- (void)viewDidUnload
{
    [self setCusCell1:nil];
    [self setCusCell2:nil];
    [self setCusCell3:nil];
    [self setCusCell4:nil];
    [self setKessekiNum:nil];
    [self setAttNum:nil];
    [self setChikokuNum:nil];
    [self setKyukoNum:nil];
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
    //1固定・・・でね？変えると落ちはしないけど崩れる
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
    //4固定で静的に実装したので変えたら落ちるよ！
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
    //以下テーブルビューセルの処理
{
    if (indexPath.row == 0)
    {
        return cusCell1;
    }
    else if(indexPath.row == 1)
    {
        return cusCell2;
    }
    else if(indexPath.row == 2)
    {
        return cusCell3;
    }
    else if(indexPath.row == 3)
    {
        return cusCell4;
    }
    return nil;
}


//以下強引に実装したボタンの処理
//余力があれば修正予定


- (IBAction)AttMinusTouched:(id)sender {
    int i;
    i = [AttNum.text intValue];
    if(i > 0) i--;
    AttNum.text = [ NSString stringWithFormat : @"%d", i ];  
}

- (IBAction)AttPlusTouched:(id)sender {
    int i;
    i = [AttNum.text intValue] + 1;
    AttNum.text = [ NSString stringWithFormat : @"%d", i ];    
}

- (IBAction)KessekiMinusTouched:(id)sender {
    int i;
    i = [KessekiNum.text intValue];
    if(i > 0) i--;
    KessekiNum.text = [ NSString stringWithFormat : @"%d", i ];      
}

- (IBAction)KessekiPlusTouched:(id)sender {
    int i;
    i = [KessekiNum.text intValue] + 1;
    KessekiNum.text = [ NSString stringWithFormat : @"%d", i ];      
}

- (IBAction)ChikokuMinusTouched:(id)sender {
    int i;
    i = [ChikokuNum.text intValue];
    if(i > 0) i--;
    ChikokuNum.text = [ NSString stringWithFormat : @"%d", i ];      
}

- (IBAction)ChikokuPlusTouched:(id)sender {
    int i;
    i = [ChikokuNum.text intValue] + 1;
    ChikokuNum.text = [ NSString stringWithFormat : @"%d", i ];      
}

- (IBAction)KyukoMinusTouched:(id)sender {
    int i;
    i = [KyukoNum.text intValue];
    if(i > 0) i--;
    KyukoNum.text = [ NSString stringWithFormat : @"%d", i ];           
}

- (IBAction)KyukoPlusTouched:(id)sender {
    int i;
    i = [KyukoNum.text intValue] + 1;
    KyukoNum.text = [ NSString stringWithFormat : @"%d", i ];          
}


@end

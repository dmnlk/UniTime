//
//  InputView.m
//  TabNavTableTest
//
//  Created by dmnlk on 11/11/02.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import "UniTimeAppDelegate.h"
#import "InputView.h"
#import "MyTableViewController.h"
#import "UIAlertView+Blocks.h"
#import "RIButtonItem.h"
@implementation InputView
@synthesize timeLabel;
@synthesize teacher;
@synthesize lesson;
@synthesize room;
@synthesize regist;
@synthesize time;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    
    [teacher release];
    [room release];
    [lesson release];
    [regist release];
    [timeLabel release];
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
    UniTimeAppDelegate *appDelegate = [(UniTimeAppDelegate *)[UIApplication sharedApplication] delegate];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //キーボードの通知
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [notificationCenter addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    lesson.delegate = self;
    room.delegate = self;
    teacher.delegate = self;
    teacher.returnKeyType =UIReturnKeyDone;
    lesson.returnKeyType = UIReturnKeyDone;
    room.returnKeyType = UIReturnKeyDone;
    originy = teacher.frame.origin.y;
    //timeLabel.text= [[NSNumber numberWithUnsignedInt:time] stringValue];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    lesson.text= [[[[defaults objectForKey:@"Data"] objectForKey:appDelegate.todayy] objectForKey:[[NSNumber numberWithUnsignedInteger:time] stringValue]] objectForKey:@"lesson"];
    
    room.text= [[[[defaults objectForKey:@"Data"] objectForKey:appDelegate.todayy] objectForKey:[[NSNumber numberWithUnsignedInteger:time] stringValue]] objectForKey:@"room"];
    
    teacher.text= [[[[defaults objectForKey:@"Data"] objectForKey:appDelegate.todayy] objectForKey:[[NSNumber numberWithUnsignedInteger:time] stringValue]] objectForKey:@"teacher"];
    
}

- (void)viewDidUnload
{
    
    [self setTeacher:nil];
    [self setRoom:nil];
    [self setLesson:nil];
    [self setRegist:nil];
    [self setTimeLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)keyboardDidShow:(NSNotification *)notification
{
    
    if(teachery == originy){
        NSDictionary *info = [notification userInfo];
        NSValue *aValue = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
        CGRect kbFrame = [aValue CGRectValue];
        CGRect viewFrame = self.view.frame;
        viewFrame.origin.y -= kbFrame.size.height;
        viewFrame.origin.y += 50;
        self.view.frame = viewFrame;
    }
    
}

-(void)keyboardDidHide:(NSNotification *)notification
{
    if(teachery ==originy){
        NSDictionary *info = [notification userInfo];
        NSValue *aValue = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
        CGRect kbFrame = [aValue CGRectValue];
        CGRect viewFrame = self.view.frame;
        viewFrame.origin.y += kbFrame.size.height;
        viewFrame.origin.y -= 50;
        self.view.frame = viewFrame;
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}

- (IBAction)registData:(id)sender {
    [self.view endEditing:YES];
    RIButtonItem *cancelItem = [RIButtonItem item];
    cancelItem.label = @"キャンセル";
    cancelItem.action = ^
    {
        // this is the code that will be executed when the user taps "No"
        // this is optional... if you leave the action as nil, it won't do anything
        // but here, I'm showing a block just to show that you can use one if you want to.
    };
    
    RIButtonItem *deleteItem = [RIButtonItem item];
    deleteItem.label = @"登録";
    deleteItem.action = ^
    {
        // this is the code that will be executed when the user taps "Yes"
        // delete the object in question...
        if ([[lesson.text stringByTrimmingCharactersInSet:
              [NSCharacterSet whitespaceCharacterSet]] length] == 0 || [[room.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0 || [[teacher.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"エラー"
                                                           message:@"未入力の項目があります"
                                                          delegate:self 
                                                 cancelButtonTitle:@"OK" 
                                                 otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        }
        else{
            UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"登録完了"
                                                          message:@"登録されました"
                                                         delegate:self
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil, nil];
            [self registInputData];
            [alert show];
            [alert release];
            [self.navigationController popViewControllerAnimated:YES];
        }

    };
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"登録確認" 
                                                        message:@"登録しますか" 
                                               cancelButtonItem:cancelItem 
                                               otherButtonItems:deleteItem, nil];
    [alertView show];
    [alertView release];
}

- (IBAction)deleteConfirm:(id)sender {
    [self.view endEditing:YES];
    RIButtonItem *cancelItem = [RIButtonItem item];
    cancelItem.label = @"キャンセル";
    cancelItem.action = ^
    {
        // this is the code that will be executed when the user taps "No"
        // this is optional... if you leave the action as nil, it won't do anything
        // but here, I'm showing a block just to show that you can use one if you want to.
    };
    
    RIButtonItem *deleteItem = [RIButtonItem item];
    deleteItem.label = @"削除";
    deleteItem.action = ^
    {
        // this is the code that will be executed when the user taps "Yes"
        // delete the object in question...
       
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"削除完了"
                                                      message:@"削除されました"
                                                     delegate:self
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil, nil];
        [self deleteData];
        [alert show];
        [alert release];
        [self.navigationController popViewControllerAnimated:YES];
    };
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"削除確認" 
                                                        message:@"削除しますか" 
                                               cancelButtonItem:cancelItem 
                                               otherButtonItems:deleteItem, nil];
    [alertView show];
    [alertView release];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    activeField = textField;
    teachery= activeField.frame.origin.y;
    
    
}
- (IBAction)backgroundTapped:(id)sender {
    [self.view endEditing:YES];
}

-(void)registInputData{
    
    UniTimeAppDelegate *appDelegate = [(UniTimeAppDelegate *)[UIApplication sharedApplication] delegate];
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    for (NSString *day in [defaults objectForKey:@"Data"]) {
        if([day isEqualToString:appDelegate.todayy]){
            for (NSString *timed in [[defaults objectForKey:@"Data"] objectForKey:day]) {
                if ([timed isEqualToString:[[NSNumber numberWithUnsignedInt:time] stringValue]]) {
                    NSMutableDictionary *d = [NSMutableDictionary dictionaryWithDictionary:[defaults objectForKey:@"Data"]];
                    NSMutableDictionary *c =[NSMutableDictionary dictionaryWithDictionary:[d objectForKey:day]];
                    NSMutableDictionary *b =[NSMutableDictionary dictionaryWithDictionary:[c objectForKey:timed]];
                    [b setObject:lesson.text forKey:@"lesson"];
                    [b setObject:room.text forKey:@"room"];
                    [b setObject:teacher.text forKey:@"teacher"];
                    
                    [c setObject:b forKey:timed];
                    [d setObject:c forKey:day];
                    [defaults setObject:d forKey:@"Data"];

                    [defaults synchronize];
                    
                }
            }
        }
    }
    
    [defaults synchronize];
}
- (void)deleteData {
    UniTimeAppDelegate *appDelegate = [(UniTimeAppDelegate *)[UIApplication sharedApplication] delegate];
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    for (NSString *day in [defaults objectForKey:@"Data"]) {
        if([day isEqualToString:appDelegate.todayy]){
            for (NSString *timed in [[defaults objectForKey:@"Data"] objectForKey:day]) {
                if ([timed isEqualToString:[[NSNumber numberWithUnsignedInt:time] stringValue]]) {
                    NSMutableDictionary *d = [NSMutableDictionary dictionaryWithDictionary:[defaults objectForKey:@"Data"]];
                    NSMutableDictionary *c =[NSMutableDictionary dictionaryWithDictionary:[d objectForKey:day]];
                    NSMutableDictionary *b =[NSMutableDictionary dictionaryWithDictionary:[c objectForKey:timed]];
                    [b setObject:@"" forKey:@"lesson"];
                    [b setObject:@"" forKey:@"room"];
                    [b setObject:@"" forKey:@"teacher"];
                    [b setObject:@"0" forKey:@"att"];
                    [b setObject:@"0" forKey:@"abs"];
                    [b setObject:@"0" forKey:@"late"];
                    [b setObject:@"0" forKey:@"kyuko"];
                    [c setObject:b forKey:timed];
                    [d setObject:c forKey:day];

                    [defaults setObject:d forKey:@"Data"];
                    [defaults synchronize];
                    
                }
            }
        }
    }
    lesson.text= [[[[defaults objectForKey:@"Data"] objectForKey:appDelegate.todayy] objectForKey:[[NSNumber numberWithUnsignedInteger:time] stringValue]] objectForKey:@"lesson"];
    
    room.text= [[[[defaults objectForKey:@"Data"] objectForKey:appDelegate.todayy] objectForKey:[[NSNumber numberWithUnsignedInteger:time] stringValue]] objectForKey:@"room"];
    
    teacher.text= [[[[defaults objectForKey:@"Data"] objectForKey:appDelegate.todayy] objectForKey:[[NSNumber numberWithUnsignedInteger:time] stringValue]] objectForKey:@"teacher"];

    [defaults synchronize];
}
@end

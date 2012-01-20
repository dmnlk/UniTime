//
//  UniTimeInfoController.m
//  UniTime
//
//  Created by dmnlk on 11/12/06.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UniTimeInfoController.h"
#import "UIAlertView+Blocks.h"
#import "UniTimeAppDelegate.h"
@implementation UniTimeInfoController

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
{   self.navigationController.navigationBarHidden =YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)allDataDelete:(id)sender {
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
        UniTimeAppDelegate *appDelegate = [(UniTimeAppDelegate *)[UIApplication sharedApplication] delegate];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSMutableDictionary *Dic =[NSMutableDictionary dictionary];
        NSMutableDictionary *dayDic =[NSMutableDictionary dictionary];
        NSMutableDictionary *timeDic =[NSMutableDictionary dictionary];
        for (NSString *day in appDelegate.weekarray) {
            for (int i = 1; i<7; i++) {
                [timeDic setObject:@"" forKey:@"lesson"];
                [timeDic setObject:@"" forKey:@"room"];
                [timeDic setObject:@"" forKey:@"teacher"];
                [timeDic setObject:@"0" forKey:@"att"];
                [timeDic setObject:@"0" forKey:@"abs"];
                [timeDic setObject:@"0" forKey:@"late"];
                [timeDic setObject:@"0" forKey:@"kyuko"];
                [dayDic setObject:timeDic forKey:[[NSNumber numberWithInt:i] stringValue]];
                [Dic setObject:dayDic forKey:day];
            }
        }
        [defaults setObject:Dic forKey:@"Data"];
        [defaults setBool:TRUE forKey:@"exist"];
        [defaults synchronize];

        [alert show];
        [alert release];
        [self.navigationController popViewControllerAnimated:YES];
    };
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"削除確認" 
                                                        message:@"入力された全てのデータ削除しますか" 
                                               cancelButtonItem:cancelItem 
                                               otherButtonItems:deleteItem, nil];
    [alertView show];
    [alertView release];

}
@end

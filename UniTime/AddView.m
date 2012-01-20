//
//  AddView.m
//  UniTime
//
//  Created by dmnlk on 11/12/05.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//


#import "AddView.h"

@implementation AddView

// プロパティ
@synthesize addButton;
@synthesize jugyoText; 
@synthesize datePicker;
@synthesize fetchedResultsController;
@synthesize managedObject = _managedObject;
@synthesize dateField;
@synthesize myTextView; 
@synthesize picker;  
@synthesize colorView;
@synthesize tap;
@synthesize tap2;
@synthesize list;


//pickerの内容を決める

int x = 0;
int v = 0;
int t = 0;
int youbi = 1;

int k = 0;
int c = -1;
int ind = 0;


/*if (string6 == @"iuy" || string6 == @"aiuoe") {
 NSLog(@"56");
 NSLog(string6);
 NSLog(@"34");
 return [NSString stringWithFormat:[[[[defaults objectForKey:@"Data"] objectForKey:@"火曜日"] objectForKey:[[NSNumber numberWithUnsignedInteger:row+1] stringValue]] objectForKey:@"lesson"]]; 
 }
 else{
 return [NSString stringWithFormat:[[[[defaults objectForKey:@"Data"] objectForKey:@"火曜日"] objectForKey:[[NSNumber numberWithUnsignedInteger:row+1] stringValue]] objectForKey:@"lesson"]]; 
 }
 */


- (id)init
{
    self = [super initWithNibName:@"AddView"
                           bundle:nil];
    if (self)
    {
        // インスタンス変数の初期化
        _managedObject = nil;
        
    }
    return self;
}


int w = 0;
- (void)viewDidLoad
{
    [super viewDidLoad];
    //NSLog(@"nannnoerroeyanaenn!¥");
    //NSLog(@"aa = %d",x);
    appDelegate = [(UniTimeAppDelegate *)[UIApplication sharedApplication] delegate];
    NSString *kyou = appDelegate.todayy;
    if (kyou == @"日曜日"){
        youbi = 1;
    }
    else if (kyou == @"月曜日"){
        youbi = 1;
    }
    else if (kyou == @"火曜日"){
        youbi = 2;
    }
    else if (kyou == @"水曜日"){
        youbi = 3;
    }
    else if (kyou == @"木曜日"){
        youbi = 4;
    }
    else if (kyou == @"金曜日"){
        youbi = 5;
    }
    else if (kyou == @"土曜日"){
        youbi = 6;
    }
    
    
    list = [[NSMutableArray alloc] initWithCapacity:1];
    
    while (x < 36) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        k = k + 1;
        if (k == 7){
            k = k - 6;
            youbi  = youbi + 1;
            if (youbi == 7){
                youbi = 1;
            }            
        }
        NSString *today =[appDelegate.weekarray objectAtIndex:youbi];
        NSString *string6 = [NSString stringWithFormat:@"%@",[[[[defaults objectForKey:@"Data"] objectForKey:today] objectForKey:[[NSNumber numberWithUnsignedInteger:k] stringValue]] objectForKey:@"lesson"]]; 
        //ここの前に中身のないデータがあるかどうかを判断しなければrowに+1する。これをwhile分で繰り返す。
        
        int len = string6.length;
        while (len == 0) {
            x = x + 1;
            if(k == 6){
                k = 1;
                youbi = youbi + 1;
                if (youbi == 7){
                    youbi = 1;
                }
            }
            else{
                k = k + 1;
            }
            today =[appDelegate.weekarray objectAtIndex:youbi];
            string6 = [NSString stringWithFormat:@"%@",[[[[defaults objectForKey:@"Data"] objectForKey:today] objectForKey:[[NSNumber numberWithUnsignedInteger:k] stringValue]] objectForKey:@"lesson"]]; 
            //ここの前に中身のないデータがあるかどうかを判断しなければrowに+1する。これをwhile分で繰り返す。
            
            len = string6.length;
            if (x == 36){
                w = 1;
                break;
            }
        }
        
        //  NSLog(@"lelelel898989999999990 = %d",k);
        
        //  NSLog(@"array : %@\n", list);
        
        //  NSLog(@"999999999999999323232");
        // NSMutableArray *anArray = [[NSMutableArray alloc] init];
          string6 = [NSString stringWithFormat:@"%@",[[[[defaults objectForKey:@"Data"] objectForKey:today] objectForKey:[[NSNumber numberWithUnsignedInteger:k] stringValue]] objectForKey:@"lesson"]]; 
        //string6 = [[NSString alloc] initWithString:[NSString stringWithFormat:[[[[defaults objectForKey:@"Data"] objectForKey:today] objectForKey:[[NSNumber numberWithUnsignedInteger:k] stringValue]] objectForKey:@"lesson"]]];
        
        //[list insertObject:@"ai" atIndex:ind];
        
        if (w != 1){
            [list insertObject:string6 atIndex:ind];
        }
        if ([list count] == 0){
            [list insertObject:@"授業を登録してください" atIndex:ind];
            
        }
        ind = ind +1;
        
        x = x + 1;
    }
    w = 0;
    x = 0;
    ind = 0;
    k = 0;
    // NSLog(@"array : %@\n", list);
    // NSLog(@"aaiueirwuoiapwfeapwuapwfuW");
    /* self.navigationItem.rightBarButtonItem.title = @"登録";
     self.navigationItem.leftBarButtonItem.title = @"Delete";
     */
    
    self.navigationItem.rightBarButtonItem
    = [[[UIBarButtonItem alloc]
        initWithTitle:@"登録"
        style:UIBarButtonItemStylePlain
        target:self
        action:@selector(addjugyo)] autorelease];
    
    [addButton release];
    NSDate *timeStamp = [self.managedObject valueForKey:@"timeStamp"];
    if(timeStamp == nil){
        NSDate *todayp = [NSDate date];
        self.datePicker.date = todayp;
    }
    else{
        self.datePicker.date = timeStamp;
    }
    picker.delegate = self; 
    // データベースの内容を反映
    [self reload];
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
 // Custom initialization
 }
 return self;
 }
 */

/*
 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad {
 [super viewDidLoad];
 }
 */

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
}

- (void)reload
{
    
    // タイトルを表示する
    //  NSLog(@"aijfipewajfip;gjip:ewrgh:hgggggggggggggggggg");
    
    NSString *jugyo2 = [self.managedObject valueForKey:@"jugyo2"];
    [self.jugyoText setText:jugyo2];
    NSDate *timeStamp = [self.managedObject valueForKey:@"timeStamp"];
    NSDateFormatter *df = [[[NSDateFormatter alloc] init]autorelease];
    /*NSDateFormatter *date = [[self.manag*/
    df.dateFormat = @"yyyy/MM/dd HH:mm";
    dateField.text = [df stringFromDate:datePicker.date];
    
    [self setTitle:jugyo2];
    NSString *memo = [self.managedObject valueForKey:@"memo"];
    [self.myTextView setText:memo];
    if(jugyo2 == nil && memo == nil && timeStamp == nil){
        v = 1;
    }
    else{
        v = 2;
    }
    // ビューコントローラのタイトルに設定する
    /*[self.managedObject setValue:date forKey:@"date"];*/
    /*
     [self.myDatePicker setDate:date];*/
    
}



- (void) pickerView: (UIPickerView*)pView didSelectRow:(NSInteger) row  inComponent:(NSInteger)component {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];; 
    //  NSLog(@"lelelele20 = %d",row);
    
   // int row1 = [picker selectedRowInComponent:0];  
    
    // NSLog(@"selected %d", row1); 
    
    
    /*while (len == 0) {
     if (flag < dis + 1){
     dis = dis + po;
     flag = dis + 1;
     }
     else if(flag > dis + 1){
     dis = dis - po;
     flag = dis + 1;
     }
     
     NSString *string = [NSString stringWithFormat:[[[[defaults objectForKey:@"Data"] objectForKey:@"火曜日"] objectForKey:[[NSNumber numberWithUnsignedInteger:dis] stringValue]] objectForKey:@"lesson"]]; 
     len = string.length;
     
     }*/
    
    NSLog(@"leleleleaaaaaaaaaaaaa2 = %d",row);
    NSString *string = [list objectAtIndex:row];
    
    jugyoText.text = string;
    
    // id obj01 = [list objectAtIndex:row];
    //jugyoText.text = obj01;
    /*
     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
     
     
     
     NSLog(@"row=%d, component=%d", row, component);  
     
     NSString *string = [NSString stringWithFormat: [[[[defaults objectForKey:@"Data"] objectForKey:appDelegate.todayy] objectForKey:[[NSNumber numberWithUnsignedInteger:indexPath.row+1] stringValue]] objectForKey:@"lesson"]]; 
     jugyoText.text = string;
     [defaults synchronize];*/
    
    
}  

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {  
    return 1;  
}  

- (NSInteger) pickerView: (UIPickerView*)pView numberOfRowsInComponent:(NSInteger) component { 
    return [list count];  //dictionaryに入っている授業名の個数を返すようにする
}  
//pickerに表示する内容を決める
- (NSString*)pickerView: (UIPickerView*) pView titleForRow:(NSInteger) row forComponent:(NSInteger)component {  
    
    /* NSString *string = [NSString stringWithFormat:[[[[defaults objectForKey:@"Data"] objectForKey:@"火曜日"] objectForKey:[[NSNumber numberWithUnsignedInteger:3] stringValue]] objectForKey:@"lesson"]]; */
    
    /*return [list objectAtIndex:row];*/
    
    
    /*
     k = k + 1;
     if (k == 7){
     k = k - 6;
     NSLog(@"lelelele9999999999 = %d",k);
     
     }
     
     NSString *string6 = [NSString stringWithFormat:[[[[defaults objectForKey:@"Data"] objectForKey:@"火曜日"] objectForKey:[[NSNumber numberWithUnsignedInteger:k] stringValue]] objectForKey:@"lesson"]]; 
     
     int len = [string6 length];
     if (row + 1 + k == 0) {
     row = row + 1;
     }
     */
    
    
    // [list addObject:str];
    
    /*
     list = [[NSArray arrayWithObjects:
     [NSString stringWithFormat:[[[[defaults objectForKey:@"Data"] objectForKey:@"火曜日"] objectForKey:[[NSNumber numberWithUnsignedInteger:k] stringValue]] objectForKey:@"lesson"]],
     nil] retain];
     */
    
    c = c + 1;
    // return [list objectAtIndex:c];
    
    //   NSLog(@"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaeijfiejiej");
    //  NSLog(@"lelelele10000000000000 = %d",row);
    // NSLog(@"array : %@\n", list);
    
    return [list objectAtIndex:row];
    
}

- (IBAction)changeDatePicker:(id)sender{
    
    NSDateFormatter *df = [[[NSDateFormatter alloc] init]autorelease];
    /*NSDateFormatter *date = [[self.manag*/
    df.dateFormat = @"yyyy/MM/dd HH:mm";
    dateField.text = [df stringFromDate:datePicker.date];
    
    // NSLog(@"aiueo");
    /*NSDateFormatter *df2 = [[[NSDateFormatter alloc] init]autorelease];
     df2.dateFormat = @"yyyy/MM/dd";
     _dateField.text = [df2 stringFromDate:_myDatePicker.date];
     */
    
}





- (IBAction)backgroundTapped:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)backtap:(id)sender {
    [self.view endEditing:YES];
}
// スケジュールを追加する
int ch = 0;
- (void)addjugyo {
    
    if ([[jugyoText.text stringByTrimmingCharactersInSet:
          [NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        UIAlertView *keikoku = [[UIAlertView alloc]initWithTitle:@"エラー"
                                                         message:@"授業名を選択してください"
                                                        delegate:self 
                                               cancelButtonTitle:@"OK" 
                                               otherButtonTitles:nil, nil];
        [keikoku show];
        [keikoku release];
        ch = 1;
    }
    if (ch == 0){
        if(v == 1){
            // Create a new instance of the entity managed by the fetched results controller.
            NSManagedObjectContext *context = [fetchedResultsController managedObjectContext];
            NSEntityDescription *entity = [[fetchedResultsController fetchRequest] entity];
            
            NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
           
            // If appropriate, configure the new managed object.
            // 選択された日付を追加
            [newManagedObject setValue:
             [NSNumber numberWithInteger:1]
                                forKey:@"kind"];
            [newManagedObject setValue:datePicker.date forKey:@"timeStamp"];
            // 入力された予定を追加
            [newManagedObject setValue:jugyoText.text forKey:@"jugyo2"];
            [newManagedObject setValue:myTextView.text forKey:@"memo"];
            
            
            NSDateFormatter *df2 = [[[NSDateFormatter alloc] init]autorelease];
            df2.dateFormat = @"yyyy年MM月dd日";
            
            [newManagedObject setValue:[df2 stringFromDate:datePicker.date] forKey:@"timeStamp2"];
            
            
            NSError *error = nil;
            if (![context save:&error]) {
                /*
                 Replace this implementation with code to handle the error appropriately.
                 
                 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
                 */
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                abort();
            }
        }
        else{
            /*
             NSManagedObjectContext *context = [fetchedResultsController managedObjectContext];
             NSEntityDescription *entity = [[fetchedResultsController fetchRequest] entity];
             
             NSManagedObject *managedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
             
             */
            [self.managedObject setValue:self.jugyoText.text
                                  forKey:@"jugyo2"];
            [self.managedObject setValue:self.myTextView.text
                                  forKey:@"memo"];
            [self.managedObject setValue:datePicker.date forKey:@"timeStamp"];
            
            //   NSLog(@"123");
            NSDateFormatter *df2 = [[[NSDateFormatter alloc] init]autorelease];
            df2.dateFormat = @"yyyy年MM月dd日";
            
            [self.managedObject setValue:[df2 stringFromDate:datePicker.date] forKey:@"timeStamp2"];
            
            
            //   NSLog(@"456");
            
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
    ch = 0;
}

// キーボードを閉じる
- (void)closeKeyboard {
	[myTextView resignFirstResponder];
}

- (IBAction)nokeybord{
    //  NSLog(@"aiorhjfapiowj");
    [jugyoText resignFirstResponder];
    [dateField resignFirstResponder];
}
int j = 0;
int i = 0;
- (IBAction)pushjugyo{
    if (j == 0) {
        if (i == 1){
            datePicker.hidden = YES;
            colorView.hidden = YES;
            tap2.hidden = YES;
            i = 0;
        }
        picker.hidden = NO;
        colorView.hidden = NO;
        tap.hidden = NO;
        j = 1;
    }
    else{
        picker.hidden = YES;
        colorView.hidden = YES;
        tap.hidden = YES;
        j = 0;
    }
}

- (IBAction)pushdate{
    if (i == 0) {
        if(j == 1){
            picker.hidden = YES;
            colorView.hidden = YES;
            tap.hidden = YES;
            j = 0;
            
        }
        datePicker.hidden = NO;
        colorView.hidden = NO;
        tap2.hidden = NO;
        i = 1;
    }
    else{
        datePicker.hidden = YES;
        colorView.hidden = YES;
        tap2.hidden = YES;
        i = 0;
    }
}
- (IBAction)disapear{
    datePicker.hidden = NO;
    colorView.hidden = NO;
    tap2.hidden = NO;
    picker.hidden = NO;
    colorView.hidden = NO;
    tap.hidden = NO;
}


- (void)dealloc {
	[addButton release];
	[jugyoText release];
	[datePicker release];
    [myTextView release];
    [colorView release];
    [tap release];
    [tap2 release];
    [dateField release];
    [list release];
	[fetchedResultsController release];
    [_managedObject release];
    [super dealloc];
}


@end
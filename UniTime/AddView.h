//
//  AddView.h
//  Unitime
//
//  Created by dmnlk on 11/12/05.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//


#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

#import "UniTimeAppDelegate.h"
@interface AddView : UIViewController {
	// ボタン、スケジュール、日付を入力する部品を定義
   	IBOutlet UIButton *addButton;
    IBOutlet UIButton *tap;
    IBOutlet UIButton *tap2;
    IBOutlet UIButton *cancelButton;
	IBOutlet UITextField *jugyoText;
	IBOutlet UIDatePicker *datePicker;
    IBOutlet UITextField *dateField;
    IBOutlet UIPickerView *picker; 
    IBOutlet UITextView *myTextView;
    IBOutlet UIView *colorView;
    
    UniTimeAppDelegate *appDelegate;
    
    NSManagedObject *_managedObject;
    NSMutableArray *list;
    
	// データベースアクセス用変数
	NSFetchedResultsController *fetchedResultsController;
}
// プロパティ
@property (nonatomic, retain) UIPickerView *picker;  
@property (nonatomic,retain) UIView *colorView;
@property (retain, nonatomic) NSManagedObject *managedObject;
@property (nonatomic, retain)  UIButton *addButton; 
@property (nonatomic,retain) UIButton *tap;
@property (nonatomic,retain) UIButton *tap2;
@property(nonatomic, retain)  UITextField *jugyoText; 
@property(nonatomic, retain)  UIDatePicker *datePicker;
@property(nonatomic, retain)  NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) UITextField *dateField;
@property (nonatomic, retain) UITextView *myTextView;
@property (nonatomic, retain) NSArray *list;
@property (nonatomic,retain)UniTimeAppDelegate *appDelegate;
- (IBAction)backgroundTapped:(id)sender;
- (IBAction)backtap:(id)sender;

- (IBAction)addjugyo;
- (IBAction)closeKeyboard;
- (IBAction)nokeybord;
- (IBAction)pushjugyo;
- (IBAction)pushdate;
- (IBAction)disapear;
- (IBAction)changePicker:(id)sender;
- (IBAction)changeDatePicker:(id)sender;

@end


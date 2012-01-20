//
//  InputView.h
//  TabNavTableTest
//
//  Created by dmnlk on 11/11/02.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface InputView : UIViewController<UITextFieldDelegate> {
   
    UITextField *teacher;
    UITextField *lesson;
    UITextField *room;
    UIButton *regist;
    UITextField *activeField;
    NSUInteger time;
    float teachery;
    float originy;
    UILabel *timeLabel;
}

@property (nonatomic, retain) IBOutlet UILabel *timeLabel;
@property (nonatomic, retain) IBOutlet UITextField *teacher;
@property (nonatomic, retain) IBOutlet UITextField *lesson;
@property (nonatomic, retain) IBOutlet UITextField *room;
@property (nonatomic, retain) IBOutlet UIButton *regist;
@property (nonatomic,assign)NSUInteger time;
- (IBAction)backgroundTapped:(id)sender;

- (IBAction)registData:(id)sender;
- (IBAction)deleteConfirm:(id)sender;
- (void)deleteData;
-(void)registInputData;
@end

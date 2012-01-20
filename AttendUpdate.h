//
//  AttendUpdate.h
//  Uninavi_attend
//
//  Created by owner_mac on 11/11/27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


//時間がなかったので強引に実装
//余力があれば修正予定

@interface AttendUpdate : UITableViewController {
    
    UITableViewCell *cusCell1;
    UITableViewCell *cusCell2;
    UITableViewCell *cusCell3;
    UITableViewCell *cusCell4;
    UILabel *KessekiNum;
    UILabel *AttNum;
    UILabel *ChikokuNum;
    UILabel *KyukoNum;
}
@property (nonatomic, retain) IBOutlet UITableViewCell *cusCell1;
@property (nonatomic, retain) IBOutlet UITableViewCell *cusCell2;
@property (nonatomic, retain) IBOutlet UITableViewCell *cusCell3;
@property (nonatomic, retain) IBOutlet UITableViewCell *cusCell4;
@property (nonatomic, retain) IBOutlet UILabel *KessekiNum;
@property (nonatomic, retain) IBOutlet UILabel *AttNum;
@property (nonatomic, retain) IBOutlet UILabel *ChikokuNum;
@property (nonatomic, retain) IBOutlet UILabel *KyukoNum;

- (IBAction)AttMinusTouched:(id)sender;
- (IBAction)AttPlusTouched:(id)sender;
- (IBAction)KessekiMinusTouched:(id)sender;
- (IBAction)KessekiPlusTouched:(id)sender;
- (IBAction)ChikokuMinusTouched:(id)sender;
- (IBAction)ChikokuPlusTouched:(id)sender;
- (IBAction)KyukoMinusTouched:(id)sender;
- (IBAction)KyukoPlusTouched:(id)sender;
- (IBAction)KessekiMinusTouched:(id)sender;
-(void)TableSettei;
-(void)NaviSettei;

@end

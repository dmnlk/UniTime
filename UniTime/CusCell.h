//
//  CusCell.h
//  TabNavTableTest
//
//  Created by dmnlk on 11/10/26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CusCell : UITableViewCell {
    
   
    UILabel *kamoku;
    UILabel *lessson;
    UILabel *room;
    UILabel *teacher;
    UILabel *startTime;
    UILabel *haihun;
    UILabel *endTime;
}
@property (nonatomic, retain) IBOutlet UILabel *kamoku;
@property (nonatomic, retain) IBOutlet UILabel *lessson;
@property (nonatomic, retain) IBOutlet UILabel *room;
@property (nonatomic, retain) IBOutlet UILabel *teacher;
@property (nonatomic, retain) IBOutlet UILabel *startTime;
@property (nonatomic, retain) IBOutlet UILabel *haihun;
@property (nonatomic, retain) IBOutlet UILabel *endTime;

@end

//
//  AttendCell.m
//  Uninavi_attend
//
//  Created by owner_mac on 11/11/23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AttendCell.h"


@implementation AttendCell
@synthesize SubjectLabel;
@synthesize AttendLabel;
@synthesize KessekiLabel;
@synthesize ChikokuLabel;
@synthesize KyukoLabel;


- (void)dealloc
{

    [SubjectLabel release];
    [AttendLabel release];
    [KessekiLabel release];
    [ChikokuLabel release];
    [KyukoLabel release];
    [super dealloc];
}

@end

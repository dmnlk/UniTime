//
//  MyView.m
//  TabNavTableTest
//
//  Created by dmnlk on 11/11/02.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyView.h"
#import "UniTimeAppDelegate.h"
#import "CustomLabel.h"
@implementation MyView
@synthesize delegate;
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
{
    //StatusBarの非表示
     
    [[UIApplication sharedApplication]setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    
    [super viewDidLoad];
    
    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI * 90 / 180.0f);
	transform = CGAffineTransformTranslate(transform, 80, 80);
	self.view.transform = transform;
    //閉じるButtonの生成
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image =[UIImage imageNamed:@"closeButton.png"];
    button.frame = CGRectMake(0.0, 0.0, 27,27);
    [button setImage:image forState:UIControlStateNormal];
   // [button setValue:[UIColor redColor] forKey:@"tintColor"];
    [button addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    // Do any additional setup after loading the view from its nib.
    
    //時限の座標
    float default_x =10;
    float default_y = 35;
    float size =54;
    for (int t =1; t<7; t++) {
        UILabel *time =[[UILabel alloc]init];
        time.backgroundColor=[UIColor clearColor];
        UIFont *timeFont =[time font];
        UIFont *newtimeFont = [UIFont fontWithName:[timeFont fontName] size:11.0];
        [time setFont:newtimeFont];
        time.text=[NSString stringWithFormat:@"%d",t];
        time.frame=CGRectMake(default_x,default_y, 10, 20);
        default_y +=size;
        [self.view addSubview:time];
        [time release];
        
    }
    
    
    //授業と教室名
    NSUserDefaults *defaluts = [NSUserDefaults standardUserDefaults];
  //  UniTimeAppDelegate *appDelegate = [(UniTimeAppDelegate *)[UIApplication sharedApplication] delegate];

    float default_lesson_x=23.0;
    float default_lesson_y=0.0;
    float default_room_x=23.0;
    float default_room_y=32.0;
    //月曜日
   NSMutableDictionary *dic =[[defaluts objectForKey:@"Data"] objectForKey:@"月曜日"];
    
    for (int i=1; i<7; i++) {
        
        CustomLabel *lessonlabel = [[CustomLabel alloc]init];
        lessonlabel.backgroundColor=[UIColor clearColor];
        UIFont *lessonFont =[lessonlabel font];
        UIFont*newlessonFont =[UIFont fontWithName:[lessonFont fontName] size:11];
        [lessonlabel setFont:newlessonFont];
        lessonlabel.text =[[dic objectForKey:[[NSNumber numberWithInt:i] stringValue]] objectForKey:@"lesson"];
        lessonlabel.infolesson = [[dic objectForKey:[[NSNumber numberWithInt:i] stringValue]] objectForKey:@"lesson"];
        lessonlabel.inforoom =[[dic objectForKey:[[NSNumber numberWithInt:i] stringValue]] objectForKey:@"room"];
        
        lessonlabel.infoteacher =[[dic objectForKey:[[NSNumber numberWithInt:i] stringValue]] objectForKey:@"teacher"];
        lessonlabel.frame=CGRectMake(default_lesson_x, default_lesson_y, 75.0, 38.0);
        lessonlabel.numberOfLines =2;
        lessonlabel.userInteractionEnabled =YES;
        lessonlabel.tag = i;
        [self.view addSubview:lessonlabel];
        [lessonlabel becomeFirstResponder];
        
        
        
        UILabel *roomLabel=[[UILabel alloc]init];
        roomLabel.backgroundColor=[UIColor clearColor];
        UIFont *roomFont =[roomLabel font];
        UIFont*newroomFont =[UIFont fontWithName:[roomFont fontName] size:9];
        [roomLabel setFont:newroomFont];
        roomLabel.text =[[dic objectForKey:[[NSNumber numberWithInt:i] stringValue]] objectForKey:@"room"];
        roomLabel.frame=CGRectMake(default_room_x, default_room_y, 75.0, 30.0);
        roomLabel.numberOfLines =1;
        [self.view addSubview:roomLabel];
        default_lesson_y +=53.33333;
        default_room_y +=53.33333;
    }
    
    
    //火曜日
    dic =[[defaluts objectForKey:@"Data"] objectForKey:@"火曜日"];
    default_lesson_x =100;
    default_lesson_y = 0.0;
    default_room_x =100;
    default_room_y = 32.0;
    for (int i=1; i<7; i++) {
        
        CustomLabel *lessonlabel = [[CustomLabel alloc]init];
        lessonlabel.backgroundColor=[UIColor clearColor];
        UIFont *lessonFont =[lessonlabel font];
        UIFont*newlessonFont =[UIFont fontWithName:[lessonFont fontName] size:11];
        [lessonlabel setFont:newlessonFont];
        lessonlabel.text =[[dic objectForKey:[[NSNumber numberWithInt:i] stringValue]] objectForKey:@"lesson"];
        lessonlabel.infolesson = [[dic objectForKey:[[NSNumber numberWithInt:i] stringValue]] objectForKey:@"lesson"];
        lessonlabel.inforoom =[[dic objectForKey:[[NSNumber numberWithInt:i] stringValue]] objectForKey:@"room"];
        
        lessonlabel.infoteacher =[[dic objectForKey:[[NSNumber numberWithInt:i] stringValue]] objectForKey:@"teacher"];

        lessonlabel.frame=CGRectMake(default_lesson_x, default_lesson_y, 75, 38);
        lessonlabel.numberOfLines =2;
        lessonlabel.userInteractionEnabled =YES;
        lessonlabel.tag = i;
        [self.view addSubview:lessonlabel];
        [lessonlabel becomeFirstResponder];
        
        UILabel *roomLabel=[[UILabel alloc]init];
        roomLabel.backgroundColor=[UIColor clearColor];
        UIFont *roomFont =[roomLabel font];
        UIFont*newroomFont =[UIFont fontWithName:[roomFont fontName] size:9];
        [roomLabel setFont:newroomFont];
        roomLabel.text =[[dic objectForKey:[[NSNumber numberWithInt:i] stringValue]] objectForKey:@"room"];
        roomLabel.frame=CGRectMake(default_room_x, default_room_y, 75, 30.0);
        roomLabel.numberOfLines =1;
        [self.view addSubview:roomLabel];
        default_lesson_y +=53.33333;
        default_room_y +=53.33333;
        }
    
    //水曜日
    dic =[[defaluts objectForKey:@"Data"] objectForKey:@"水曜日"];
    default_lesson_x =177;
    default_lesson_y = 0.0;
    default_room_x =177;
    default_room_y = 32.0;
    for (int i=1; i<7; i++) {
        
        CustomLabel *lessonlabel = [[CustomLabel alloc]init];
        lessonlabel.backgroundColor=[UIColor clearColor];
        UIFont *lessonFont =[lessonlabel font];
        UIFont*newlessonFont =[UIFont fontWithName:[lessonFont fontName] size:11];
        [lessonlabel setFont:newlessonFont];
        lessonlabel.text =[[dic objectForKey:[[NSNumber numberWithInt:i] stringValue]] objectForKey:@"lesson"];
        lessonlabel.infolesson = [[dic objectForKey:[[NSNumber numberWithInt:i] stringValue]] objectForKey:@"lesson"];
        lessonlabel.inforoom =[[dic objectForKey:[[NSNumber numberWithInt:i] stringValue]] objectForKey:@"room"];
        
        lessonlabel.infoteacher =[[dic objectForKey:[[NSNumber numberWithInt:i] stringValue]] objectForKey:@"teacher"];
        
        lessonlabel.frame=CGRectMake(default_lesson_x, default_lesson_y, 75, 38);
        lessonlabel.numberOfLines =2;
        lessonlabel.userInteractionEnabled =YES;
        lessonlabel.tag = i;
        [self.view addSubview:lessonlabel];
        [lessonlabel becomeFirstResponder];
        
        UILabel *roomLabel=[[UILabel alloc]init];
        roomLabel.backgroundColor=[UIColor clearColor];
        UIFont *roomFont =[roomLabel font];
        UIFont*newroomFont =[UIFont fontWithName:[roomFont fontName] size:9];
        [roomLabel setFont:newroomFont];
        roomLabel.text =[[dic objectForKey:[[NSNumber numberWithInt:i] stringValue]] objectForKey:@"room"];
        roomLabel.frame=CGRectMake(default_room_x, default_room_y, 75, 30.0);
        roomLabel.numberOfLines =1;
        [self.view addSubview:roomLabel];
        default_lesson_y +=53.33333;
        default_room_y +=53.33333;
    }
    
    
    //木曜日
    dic =[[defaluts objectForKey:@"Data"] objectForKey:@"木曜日"];
    default_lesson_x =254.0;
    default_lesson_y = 0.0;
    default_room_x =254.0;
    default_room_y = 32.0;
    for (int i=1; i<7; i++) {
        
        CustomLabel *lessonlabel = [[CustomLabel alloc]init];
        lessonlabel.backgroundColor=[UIColor clearColor];
        UIFont *lessonFont =[lessonlabel font];
        UIFont*newlessonFont =[UIFont fontWithName:[lessonFont fontName] size:11];
        [lessonlabel setFont:newlessonFont];
        lessonlabel.text =[[dic objectForKey:[[NSNumber numberWithInt:i] stringValue]] objectForKey:@"lesson"];
        lessonlabel.infolesson = [[dic objectForKey:[[NSNumber numberWithInt:i] stringValue]] objectForKey:@"lesson"];
        lessonlabel.inforoom =[[dic objectForKey:[[NSNumber numberWithInt:i] stringValue]] objectForKey:@"room"];
        
        lessonlabel.infoteacher =[[dic objectForKey:[[NSNumber numberWithInt:i] stringValue]] objectForKey:@"teacher"];
        
        lessonlabel.frame=CGRectMake(default_lesson_x, default_lesson_y, 75, 38);
        lessonlabel.numberOfLines =2;
        lessonlabel.userInteractionEnabled =YES;
        lessonlabel.tag = i;
        [self.view addSubview:lessonlabel];
        [lessonlabel becomeFirstResponder];
        
        UILabel *roomLabel=[[UILabel alloc]init];
        roomLabel.backgroundColor=[UIColor clearColor];
        UIFont *roomFont =[roomLabel font];
        UIFont*newroomFont =[UIFont fontWithName:[roomFont fontName] size:9];
        [roomLabel setFont:newroomFont];
        roomLabel.text =[[dic objectForKey:[[NSNumber numberWithInt:i] stringValue]] objectForKey:@"room"];
        roomLabel.frame=CGRectMake(default_room_x, default_room_y, 75, 30.0);
        roomLabel.numberOfLines =1;
        [self.view addSubview:roomLabel];
        default_lesson_y +=53.33333;
        default_room_y +=53.33333;
    }
    
    
    //金曜日
    dic =[[defaluts objectForKey:@"Data"] objectForKey:@"金曜日"];
    default_lesson_x =331;
    default_lesson_y = 0.0;
    default_room_x =331;
    default_room_y = 32.0;
    for (int i=1; i<7; i++) {
        
        CustomLabel *lessonlabel = [[CustomLabel alloc]init];
        lessonlabel.backgroundColor=[UIColor clearColor];
        UIFont *lessonFont =[lessonlabel font];
        UIFont*newlessonFont =[UIFont fontWithName:[lessonFont fontName] size:11];
        [lessonlabel setFont:newlessonFont];
        lessonlabel.text =[[dic objectForKey:[[NSNumber numberWithInt:i] stringValue]] objectForKey:@"lesson"];
        lessonlabel.infolesson = [[dic objectForKey:[[NSNumber numberWithInt:i] stringValue]] objectForKey:@"lesson"];
        lessonlabel.inforoom =[[dic objectForKey:[[NSNumber numberWithInt:i] stringValue]] objectForKey:@"room"];
        
        lessonlabel.infoteacher =[[dic objectForKey:[[NSNumber numberWithInt:i] stringValue]] objectForKey:@"teacher"];
        
        lessonlabel.frame=CGRectMake(default_lesson_x, default_lesson_y, 75, 38);
        lessonlabel.numberOfLines =2;
        lessonlabel.userInteractionEnabled =YES;
        lessonlabel.tag = i;
        [self.view addSubview:lessonlabel];
        [lessonlabel becomeFirstResponder];
        
        UILabel *roomLabel=[[UILabel alloc]init];
        roomLabel.backgroundColor=[UIColor clearColor];
        UIFont *roomFont =[roomLabel font];
        UIFont*newroomFont =[UIFont fontWithName:[roomFont fontName] size:9];
        [roomLabel setFont:newroomFont];
        roomLabel.text =[[dic objectForKey:[[NSNumber numberWithInt:i] stringValue]] objectForKey:@"room"];
        roomLabel.frame=CGRectMake(default_room_x, default_room_y, 75, 30.0);
        roomLabel.numberOfLines =1;
        [self.view addSubview:roomLabel];
        default_lesson_y +=53.33333;
        default_room_y +=53.33333;
    }
    
    //土曜日
    dic =[[defaluts objectForKey:@"Data"] objectForKey:@"土曜日"];
    default_lesson_x =408;
    default_lesson_y = 0.0;
    default_room_x =408;
    default_room_y = 32.0;
    for (int i=1; i<7; i++) {
        
        CustomLabel *lessonlabel = [[CustomLabel alloc]init];
        lessonlabel.backgroundColor=[UIColor clearColor];
        UIFont *lessonFont =[lessonlabel font];
        UIFont*newlessonFont =[UIFont fontWithName:[lessonFont fontName] size:11];
        [lessonlabel setFont:newlessonFont];
        lessonlabel.text =[[dic objectForKey:[[NSNumber numberWithInt:i] stringValue]] objectForKey:@"lesson"];
        lessonlabel.infolesson = [[dic objectForKey:[[NSNumber numberWithInt:i] stringValue]] objectForKey:@"lesson"];
        lessonlabel.inforoom =[[dic objectForKey:[[NSNumber numberWithInt:i] stringValue]] objectForKey:@"room"];
        
        lessonlabel.infoteacher =[[dic objectForKey:[[NSNumber numberWithInt:i] stringValue]] objectForKey:@"teacher"];
        
        lessonlabel.frame=CGRectMake(default_lesson_x, default_lesson_y, 75, 38);
        lessonlabel.numberOfLines =2;
        lessonlabel.userInteractionEnabled =YES;
        lessonlabel.tag = i;
        [self.view addSubview:lessonlabel];
        [lessonlabel becomeFirstResponder];
        
        UILabel *roomLabel=[[UILabel alloc]init];
        roomLabel.backgroundColor=[UIColor clearColor];
        UIFont *roomFont =[roomLabel font];
        UIFont*newroomFont =[UIFont fontWithName:[roomFont fontName] size:9];
        [roomLabel setFont:newroomFont];
        roomLabel.text =[[dic objectForKey:[[NSNumber numberWithInt:i] stringValue]] objectForKey:@"room"];
        roomLabel.frame=CGRectMake(default_room_x, default_room_y, 75, 30.0);
        roomLabel.numberOfLines =1;
        [self.view addSubview:roomLabel];
        default_lesson_y +=53.33333;
        default_room_y +=53.33333;
    }

    /*
    //時限の座標
    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI * 90 / 180.0f);
    float default_x =270;
    float default_y = 10;
    float size =54;
    for (int t =1; t<7; t++) {
        UILabel *time =[[UILabel alloc]init];
        time.backgroundColor=[UIColor clearColor];
        time.transform = transform;
        UIFont *timeFont =[time font];
        UIFont *newtimeFont = [UIFont fontWithName:[timeFont fontName] size:11.0];
        [time setFont:newtimeFont];
        time.text=[NSString stringWithFormat:@"%d",t];
        time.frame=CGRectMake(default_x,default_y, 10, 20);
        default_x -=size;
        [self.view addSubview:time];
        [time release];
        
    }
    
    //授業と教室名
    NSUserDefaults *defaluts = [NSUserDefaults standardUserDefaults];
    UniTimeAppDelegate *appDelegate = [(UniTimeAppDelegate *)[UIApplication sharedApplication] delegate];
    float default_lesson_x=280.0;
    float default_lesson_y=23.0;
    float default_room_x=260.0;
    float default_room_y=23.0;
    //月曜日
    NSMutableDictionary *dic =[NSMutableDictionary dictionary];
    dic =[[defaluts objectForKey:@"Data"] objectForKey:@"月曜日"];
    for (int i=1; i<7; i++) {

        CustomLabel *lessonlabel = [[CustomLabel alloc]init];
        lessonlabel.backgroundColor=[UIColor clearColor];
        lessonlabel.transform =transform;
        UIFont *lessonFont =[lessonlabel font];
        UIFont*newlessonFont =[UIFont fontWithName:[lessonFont fontName] size:11];
        [lessonlabel setFont:newlessonFont];
        lessonlabel.text =[[dic objectForKey:[[NSNumber numberWithInt:i] stringValue]] objectForKey:@"lesson"];
        lessonlabel.infolesson = [[dic objectForKey:[[NSNumber numberWithInt:i] stringValue]] objectForKey:@"lesson"];
        lessonlabel.inforoom =[[dic objectForKey:[[NSNumber numberWithInt:i] stringValue]] objectForKey:@"room"];
        
        lessonlabel.infoteacher =[[dic objectForKey:[[NSNumber numberWithInt:i] stringValue]] objectForKey:@"teacher"];
        lessonlabel.frame=CGRectMake(default_lesson_x, default_lesson_y, 40, 70.0);
        lessonlabel.numberOfLines =2;
        lessonlabel.userInteractionEnabled =YES;
        
        [self.view addSubview:lessonlabel];
        [lessonlabel becomeFirstResponder];
        
        
        
        UILabel *roomLabel=[[UILabel alloc]init];
        roomLabel.backgroundColor=[UIColor clearColor];
        roomLabel.transform =transform;
        UIFont *roomFont =[roomLabel font];
        UIFont*newroomFont =[UIFont fontWithName:[roomFont fontName] size:9];
        [roomLabel setFont:newroomFont];
        roomLabel.text =[[dic objectForKey:[[NSNumber numberWithInt:i] stringValue]] objectForKey:@"room"];
        roomLabel.frame=CGRectMake(default_room_x, default_room_y, 30, 70.0);
        roomLabel.numberOfLines =1;
        [self.view addSubview:roomLabel];
        default_lesson_x -=53.33333;
        default_room_x -=53.33333;
}
    
    
    //火曜日
    dic =[[defaluts objectForKey:@"Data"] objectForKey:@"火曜日"];
    default_lesson_x =280;
    default_lesson_y = 100;
    default_room_x =260;
    default_room_y = 100;
    for (int i=1; i<7; i++) {
        
        UILabel *lessonlabel = [[UILabel alloc]init];
        lessonlabel.backgroundColor=[UIColor clearColor];
        lessonlabel.transform =transform;
        UIFont *lessonFont =[lessonlabel font];
        UIFont*newlessonFont =[UIFont fontWithName:[lessonFont fontName] size:11];
        [lessonlabel setFont:newlessonFont];
        lessonlabel.text =[[dic objectForKey:[[NSNumber numberWithInt:i] stringValue]] objectForKey:@"lesson"];
        lessonlabel.frame=CGRectMake(default_lesson_x, default_lesson_y, 40, 70.0);
        lessonlabel.numberOfLines =2;
        
        [self.view addSubview:lessonlabel];
        
        UILabel *roomLabel=[[UILabel alloc]init];
        roomLabel.backgroundColor=[UIColor clearColor];
        roomLabel.transform =transform;
        UIFont *roomFont =[roomLabel font];
        UIFont*newroomFont =[UIFont fontWithName:[roomFont fontName] size:9];
        [roomLabel setFont:newroomFont];
        roomLabel.text =[[dic objectForKey:[[NSNumber numberWithInt:i] stringValue]] objectForKey:@"room"];
        roomLabel.frame=CGRectMake(default_room_x, default_room_y, 30, 70.0);
        roomLabel.numberOfLines =1;
        [self.view addSubview:roomLabel];
        default_lesson_x -=53.33333;
        default_room_x -=53.33333;
    }

    //水曜日
    dic =[[defaluts objectForKey:@"Data"] objectForKey:@"水曜日"];
    default_lesson_x =280;
    default_lesson_y = 177;
    default_room_x =260;
    default_room_y = 177;
    for (int i=1; i<7; i++) {
        
        UILabel *lessonlabel = [[UILabel alloc]init];
        lessonlabel.backgroundColor=[UIColor clearColor];
        lessonlabel.transform =transform;
        UIFont *lessonFont =[lessonlabel font];
        UIFont*newlessonFont =[UIFont fontWithName:[lessonFont fontName] size:11];
        [lessonlabel setFont:newlessonFont];
        lessonlabel.text =[[dic objectForKey:[[NSNumber numberWithInt:i] stringValue]] objectForKey:@"lesson"];
        lessonlabel.frame=CGRectMake(default_lesson_x, default_lesson_y, 40, 70.0);
        lessonlabel.numberOfLines =2;
        
        [self.view addSubview:lessonlabel];
        
        UILabel *roomLabel=[[UILabel alloc]init];
        roomLabel.backgroundColor=[UIColor clearColor];
        roomLabel.transform =transform;
        UIFont *roomFont =[roomLabel font];
        UIFont*newroomFont =[UIFont fontWithName:[roomFont fontName] size:9];
        [roomLabel setFont:newroomFont];
        roomLabel.text =[[dic objectForKey:[[NSNumber numberWithInt:i] stringValue]] objectForKey:@"room"];
        roomLabel.frame=CGRectMake(default_room_x, default_room_y, 30, 70.0);
        roomLabel.numberOfLines =1;
        [self.view addSubview:roomLabel];
        default_lesson_x -=53.33333;
        default_room_x -=53.33333;
    }
    

    //木曜日
    dic =[[defaluts objectForKey:@"Data"] objectForKey:@"木曜日"];
    default_lesson_x =280;
    default_lesson_y = 254;
    default_room_x =260;
    default_room_y = 254;
    for (int i=1; i<7; i++) {
        
        UILabel *lessonlabel = [[UILabel alloc]init];
        lessonlabel.backgroundColor=[UIColor clearColor];
        lessonlabel.transform =transform;
        UIFont *lessonFont =[lessonlabel font];
        UIFont*newlessonFont =[UIFont fontWithName:[lessonFont fontName] size:11];
        [lessonlabel setFont:newlessonFont];
        lessonlabel.text =[[dic objectForKey:[[NSNumber numberWithInt:i] stringValue]] objectForKey:@"lesson"];
        lessonlabel.frame=CGRectMake(default_lesson_x, default_lesson_y, 40, 70.0);
        lessonlabel.numberOfLines =2;
        
        [self.view addSubview:lessonlabel];
        
        UILabel *roomLabel=[[UILabel alloc]init];
        roomLabel.backgroundColor=[UIColor clearColor];
        roomLabel.transform =transform;
        UIFont *roomFont =[roomLabel font];
        UIFont*newroomFont =[UIFont fontWithName:[roomFont fontName] size:9];
        [roomLabel setFont:newroomFont];
        roomLabel.text =[[dic objectForKey:[[NSNumber numberWithInt:i] stringValue]] objectForKey:@"room"];
        roomLabel.frame=CGRectMake(default_room_x, default_room_y, 30, 70.0);
        roomLabel.numberOfLines =1;
        [self.view addSubview:roomLabel];
        default_lesson_x -=53.33333;
        default_room_x -=53.33333;
    }

    //金曜日
    dic =[[defaluts objectForKey:@"Data"] objectForKey:@"金曜日"];
    default_lesson_x =280;
    default_lesson_y = 331;
    default_room_x =260;
    default_room_y = 331;
    for (int i=1; i<7; i++) {
        
        UILabel *lessonlabel = [[UILabel alloc]init];
        lessonlabel.backgroundColor=[UIColor clearColor];
        lessonlabel.transform =transform;
        UIFont *lessonFont =[lessonlabel font];
        UIFont*newlessonFont =[UIFont fontWithName:[lessonFont fontName] size:11];
        [lessonlabel setFont:newlessonFont];
        lessonlabel.text =[[dic objectForKey:[[NSNumber numberWithInt:i] stringValue]] objectForKey:@"lesson"];
        lessonlabel.frame=CGRectMake(default_lesson_x, default_lesson_y, 40, 70.0);
        lessonlabel.numberOfLines =2;
        
        [self.view addSubview:lessonlabel];
        
        UILabel *roomLabel=[[UILabel alloc]init];
        roomLabel.backgroundColor=[UIColor clearColor];
        roomLabel.transform =transform;
        UIFont *roomFont =[roomLabel font];
        UIFont*newroomFont =[UIFont fontWithName:[roomFont fontName] size:9];
        [roomLabel setFont:newroomFont];
        roomLabel.text =[[dic objectForKey:[[NSNumber numberWithInt:i] stringValue]] objectForKey:@"room"];
        roomLabel.frame=CGRectMake(default_room_x, default_room_y, 30, 70.0);
        roomLabel.numberOfLines =1;
        [self.view addSubview:roomLabel];
        default_lesson_x -=53.33333;
        default_room_x -=53.33333;
    }

    //土曜日
    dic =[[defaluts objectForKey:@"Data"] objectForKey:@"土曜日"];
    default_lesson_x =280;
    default_lesson_y = 408;
    default_room_x =260;
    default_room_y = 408;
    for (int i=1; i<7; i++) {
        
        UILabel *lessonlabel = [[UILabel alloc]init];
        lessonlabel.backgroundColor=[UIColor clearColor];
        lessonlabel.transform =transform;
        UIFont *lessonFont =[lessonlabel font];
        UIFont*newlessonFont =[UIFont fontWithName:[lessonFont fontName] size:11];
        [lessonlabel setFont:newlessonFont];
        lessonlabel.text =[[dic objectForKey:[[NSNumber numberWithInt:i] stringValue]] objectForKey:@"lesson"];
        lessonlabel.frame=CGRectMake(default_lesson_x, default_lesson_y, 40, 70.0);
        lessonlabel.numberOfLines =2;
        
        [self.view addSubview:lessonlabel];
        
        UILabel *roomLabel=[[UILabel alloc]init];
        roomLabel.backgroundColor=[UIColor clearColor];
        roomLabel.transform =transform;
        UIFont *roomFont =[roomLabel font];
        UIFont*newroomFont =[UIFont fontWithName:[roomFont fontName] size:9];
        [roomLabel setFont:newroomFont];
        roomLabel.text =[[dic objectForKey:[[NSNumber numberWithInt:i] stringValue]] objectForKey:@"room"];
        roomLabel.frame=CGRectMake(default_room_x, default_room_y, 30, 70.0);
        roomLabel.numberOfLines =1;
        [self.view addSubview:roomLabel];
        default_lesson_x -=53.33333;
        default_room_x -=53.33333;
    }
    
    
    */
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
   // return (interfaceOrientation == UIInterfaceOrientationPortrait);
    //return YES;
    
    return  (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

-(void)closeView{
    [[UIApplication sharedApplication]setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [delegate modalViewWillClose];
}


@end

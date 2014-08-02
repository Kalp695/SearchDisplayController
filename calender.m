
#import "CalendarView.h"

@interface CalendarView()

{
    
    NSCalendar *gregorian;
    NSInteger _selectedMonth;
    NSInteger _selectedYear;
}

@end
@implementation CalendarView
@synthesize themeColor;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
     //        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.size.height-100, self.bounds.size.width, 44)];

    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    
    [self setCalendarParameters];
    _weekNames = @[@"Mon",@"Tue",@"Wed",@"Thu",@"Fri",@"Sat",@"Sun"];
    NSDateComponents *components = [gregorian components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.calendarDate];
//    _selectedDate  =components.day;
    components.day = 1;
    NSDate *firstDayOfMonth = [gregorian dateFromComponents:components];
    NSDateComponents *comps = [gregorian components:NSWeekdayCalendarUnit fromDate:firstDayOfMonth];
    int weekday = [comps weekday];
//      NSLog(@"components%d %d %d",_selectedDate,_selectedMonth,_selectedYear);
    weekday  = weekday - 2;
    
    if(weekday < 0)
        weekday += 7;
    
    NSCalendar *c = [NSCalendar currentCalendar];
    NSRange days = [c rangeOfUnit:NSDayCalendarUnit
                           inUnit:NSMonthCalendarUnit
                          forDate:self.calendarDate];
    
    NSInteger columns = 7;
    NSInteger width =IS_IPHONE?40:100;
    NSInteger originX = IS_IPHONE?20:34;
    NSInteger originY =IS_IPHONE? 60:100;
    NSInteger monthLength = days.length;
    
  //  UILabel *titleText = [[UILabel alloc]initWithFrame:CGRectMake(0,20, self.bounds.size.width, 40)];

    UIButton *btnNext = [UIButton buttonWithType:UIButtonTypeCustom];

    [btnNext setTitle:@"Next" forState:UIControlStateNormal];
    [btnNext setFrame:CGRectMake(IS_IPHONE? WIDTH-70:WIDTH-110,20 ,IS_IPHONE?40:80,40)];
    [btnNext setTitleColor:themeColor forState:UIControlStateNormal];
    [btnNext.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:IS_IPHONE?15.0f:25.0f]];
    [btnNext addTarget:self action:@selector(goTONextMonth:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnNext];
    
    
    
    UIButton *btnPrev = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnPrev setTitle:@"Prev" forState:UIControlStateNormal];
    [btnPrev setFrame:CGRectMake(30,20 ,IS_IPHONE?40:80,40)];
    [btnPrev setTitleColor:themeColor forState:UIControlStateNormal];
    [btnPrev.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:IS_IPHONE?15.0f:25.0f]];
    [btnPrev addTarget:self action:@selector(goTOPreviousMonth:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnPrev];

    
    UILabel *titleText = [[UILabel alloc]initWithFrame:CGRectMake(originX,20,WIDTH-(originX*2), 40)];
    titleText.textAlignment = NSTextAlignmentCenter;
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MMMM yyyy"];
    NSString *dateString = [[format stringFromDate:self.calendarDate] uppercaseString];
    [titleText setText:dateString];
    [titleText setFont:[UIFont fontWithName:@"Helvetica-Bold" size:IS_IPHONE?15.0f:25.0f]];
    [titleText setTextColor:themeColor];
    [titleText.layer setBorderWidth:1.0];
    [titleText.layer setCornerRadius:5];
    [titleText.layer setBorderColor:themeColor.CGColor];
    [self addSubview:titleText];
    
    for (int i =0; i<_weekNames.count; i++) {
        UIButton *weekNameLabel = [UIButton buttonWithType:UIButtonTypeCustom];
        weekNameLabel.titleLabel.text = [_weekNames objectAtIndex:i];
        [weekNameLabel setTitle:[_weekNames objectAtIndex:i] forState:UIControlStateNormal];
        [weekNameLabel setFrame:CGRectMake(originX+(width*(i%columns)),IS_IPHONE?originY-5 : originY-50, width, width)];
        [weekNameLabel setTitleColor:themeColor forState:UIControlStateNormal];
        [weekNameLabel.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:IS_IPHONE?15.0f:25.0f]];
        weekNameLabel.userInteractionEnabled = NO;
        [self addSubview:weekNameLabel];
    }
    

    for (NSInteger i= 0; i<monthLength; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i+1;
        button.titleLabel.text = [NSString stringWithFormat:@"%d",i+1];
        [button setTitle:[NSString stringWithFormat:@"%d",i+1] forState:UIControlStateNormal];
        [button setTitleColor:themeColor forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:IS_IPHONE?15.0f:25.0f]];
        [button addTarget:self action:@selector(tappedDate:) forControlEvents:UIControlEventTouchUpInside];
        NSInteger offsetX = (width*((i+weekday)%columns));
        NSInteger offsetY = (width *((i+weekday)/columns));
        [button setFrame:CGRectMake(originX+offsetX, originY+40+offsetY, width, width)];
        [button.layer setBorderColor:themeColor.CGColor];
        [button.layer setBorderWidth:0.5];
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = themeColor;
        if(((i+weekday)/columns)==0)
        {
            [lineView setFrame:CGRectMake(0, 0, button.frame.size.width, 2)];
            [button addSubview:lineView];
            
            // top border for current month
        }

        if(((i+weekday)/columns)==((monthLength+weekday-1)/columns))
        {
            [lineView setFrame:CGRectMake(0, button.frame.size.width-2, button.frame.size.width, 2)];
            [button addSubview:lineView];
        }
        
        UIView *columnView = [[UIView alloc]init];
        [columnView setBackgroundColor:themeColor];
        if((i+weekday)%7==0)
        {
            [columnView setFrame:CGRectMake(0, 0, 2, button.frame.size.width)];
           [button addSubview:columnView];
            //left border
        }
        else if((i+weekday)%7==6)
        {
            [columnView setFrame:CGRectMake(button.frame.size.width-2, 0, 2, button.frame.size.width)];
            [button addSubview:columnView];
        }
        if(i+1 ==_selectedDate && components.month == _selectedMonth && components.year == _selectedYear)
        {
            [button setBackgroundColor:themeColor];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
        }
        
        [self addSubview:button];
    }
    
    NSDateComponents *previousMonthComponents = [gregorian components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.calendarDate];
    previousMonthComponents.month -=1;
    NSDate *previousMonthDate = [gregorian dateFromComponents:previousMonthComponents];
    NSRange previousMonthDays = [c rangeOfUnit:NSDayCalendarUnit
                   inUnit:NSMonthCalendarUnit
                  forDate:previousMonthDate];
    NSInteger maxDate = previousMonthDays.length - weekday;
    
    
    for (int i=0; i<weekday; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.text = [NSString stringWithFormat:@"%d",maxDate+i+1];
        [button setTitle:[NSString stringWithFormat:@"%d",maxDate+i+1] forState:UIControlStateNormal];
        NSInteger offsetX = (width*(i%columns));
        NSInteger offsetY = (width *(i/columns));
        [button setFrame:CGRectMake(originX+offsetX, originY+40+offsetY, width, width)];
        [button.layer setBorderWidth:0.5];
        [button.layer setBorderColor:themeColor.CGColor];
        UIView *columnView = [[UIView alloc]init];
        [columnView setBackgroundColor:themeColor];
        if(i==0)
        {
            [columnView setFrame:CGRectMake(0, 0, 2, button.frame.size.width)];
            [button addSubview:columnView];
        }

        UIView *lineView = [[UIView alloc]init];
        [lineView setBackgroundColor:themeColor];
        [lineView setFrame:CGRectMake(0, 0, button.frame.size.width, 2)];
       // Last month day top
        
        [button addSubview:lineView];
        [button setTitleColor:[UIColor colorWithRed:229.0/255.0 green:231.0/255.0 blue:233.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:IS_IPHONE?16.0f:27.0f]];
        [button setEnabled:NO];
        [self addSubview:button];
    }
    
    NSInteger remainingDays = (monthLength + weekday) % columns;
    if(remainingDays >0){
        for (int i=remainingDays; i<columns; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.titleLabel.text = [NSString stringWithFormat:@"%d",(i+1)-remainingDays];
            [button setTitle:[NSString stringWithFormat:@"%d",(i+1)-remainingDays] forState:UIControlStateNormal];
            NSInteger offsetX = (width*((i) %columns));
            NSInteger offsetY = (width *((monthLength+weekday)/columns));
            [button setFrame:CGRectMake(originX+offsetX, originY+40+offsetY, width, width)];
            [button.layer setBorderWidth:0.5];
            [button.layer setBorderColor:themeColor.CGColor];
            UIView *columnView = [[UIView alloc]init];
            [columnView setBackgroundColor:themeColor];
            if(i==columns - 1)
            {
                [columnView setFrame:CGRectMake(button.frame.size.width-2, 0, 2, button.frame.size.width)];
                [button addSubview:columnView];
            }
            UIView *lineView = [[UIView alloc]init];
            [lineView setBackgroundColor:themeColor];
            [lineView setFrame:CGRectMake(0, button.frame.size.width-2, button.frame.size.width, 2)];
            [button addSubview:lineView];
            [button setTitleColor:[UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0] forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:IS_IPHONE?16.0f:27.0f]];
            [button setEnabled:NO];
            [self addSubview:button];

        }
    }

}
-(IBAction)tappedDate:(UIButton *)sender
{
    gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.calendarDate];
    if(!(_selectedDate == sender.tag && _selectedMonth == [components month] && _selectedYear == [components year]))
    {
        if(_selectedDate != -1)
        {
            UIButton *previousSelected =(UIButton *) [self viewWithTag:_selectedDate];
            [previousSelected setBackgroundColor:[UIColor clearColor]];
            [previousSelected setTitleColor:themeColor forState:UIControlStateNormal];
            
        }
        
        [sender setBackgroundColor:themeColor];
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _selectedDate = sender.tag;
        NSDateComponents *components = [gregorian components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.calendarDate];
        components.day = _selectedDate;
        _selectedMonth = components.month;
        _selectedYear = components.year;
        NSDate *clickedDate = [gregorian dateFromComponents:components];

        [self.delegate tappedOnDate:clickedDate];
    }
}

-(void)goTONextMonth:(id)sender
{
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSDateComponents *components = [gregorian components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.calendarDate];
    components.day = 1;
    components.month += 1;
    self.calendarDate = [gregorian dateFromComponents:components];
    [UIView transitionWithView:self
                      duration:0.5f
                       options:UIViewAnimationOptionTransitionCurlUp
                    animations:^ { [self setNeedsDisplay]; }
                    completion:nil];
    
    
}

-(void)goTOPreviousMonth:(id)sender
{
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSDateComponents *components = [gregorian components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.calendarDate];
    components.day = 1;
    components.month -= 1;
    self.calendarDate = [gregorian dateFromComponents:components];
    [UIView transitionWithView:self
                      duration:0.5f
                       options:UIViewAnimationOptionTransitionCurlDown
                    animations:^ { [self setNeedsDisplay]; }
                    completion:nil];
}
-(void)setCalendarParameters
{
    if(gregorian == nil)
    {
        gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *components = [gregorian components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.calendarDate];
        _selectedDate  = components.day;
        _selectedMonth = components.month;
        _selectedYear = components.year;
    }
}

@end

UILabel *Ttime;
NSDateFormatter *ttime;
UIDevice *myDevice;
UIWindow *mainWindow;

@interface IOSViewController : UIViewController
- (void)loadView;
@end
%hook IOSViewController
- (void)loadView {
%orig;

dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

mainWindow = [UIApplication sharedApplication].keyWindow;

myDevice = [UIDevice currentDevice];
[myDevice setBatteryMonitoringEnabled:YES];
double batLeft = (float)[myDevice batteryLevel] * 100;

ttime = [[NSDateFormatter alloc] init];
[ttime setDateFormat:@"yyyy/MM/dd • hh:mm:ss"];

Ttime = [[UILabel alloc]initWithFrame:CGRectMake(300, 20, 300, 31)];
Ttime.font = [UIFont fontWithName:@"AvenirNext-Bold" size:13.0];

Ttime.text = [NSString stringWithFormat:@"%@  •  %0.0f⚡️ ",[ttime stringFromDate:[NSDate date]],batLeft];

Ttime.textColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];

[mainWindow addSubview:Ttime];

[NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(RR) userInfo:nil repeats:YES];


});
}

%new
- (void)RR {

myDevice = [UIDevice currentDevice];
[myDevice setBatteryMonitoringEnabled:YES];
double batLeft = (float)[myDevice batteryLevel] * 100;

Ttime.textColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];

Ttime.text = [NSString stringWithFormat:@"%@ • %0.0f⚡️ ",[ttime stringFromDate:[NSDate date]],batLeft];

}
%end
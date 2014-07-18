//
//  AppDelegate.m
//  SearchDisplay Controller
//
//  Created by NLS17 on 18/07/14.
//  Copyright (c) 2014 Kalpit Gajera. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
//
//  HomeViewController.m
//  SearchDisplay Controller
//
//  Created by NLS17 on 18/07/14.
//  Copyright (c) 2014 Kalpit Gajera. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout=0;
    self.title=@"Search";
    arrData =[[NSMutableArray alloc]initWithObjects:@"India",@"Antigua & Deps"
              ,@"Argentina",@"Armenia",@"Australia",@"Austria",@"Azerbaijan",@"Bahamas",@" Bahrain",@" Bangladesh",@" Barbados",@"Brazil ",@"Brunei",@"Bulgaria",@"Burkina",@"Burundi",@"Cambodia",@"Cameroon",@"Canada",@"Cyprus",@"Czech Republic",@"Denmark",@"Djibouti",@"Dominica",@"Estonia",@"Ethiopia",@"Fiji",@"Finland",@"France",@"Gabon",@"Gambia",@"Georgia",@"Germany",@"Ghana",@"Haiti",@"Honduras",@"Hungary",@"Iceland",@"India",@"Indonesia",@"Iran",@"Italy",@"Ivory Coast",@"Jamaica",@"Japan",@"Jordan",@"Kazakhstan",@"Kenya",@"Kiribati",@"Korea North",@"Korea South",@"Kosovo",@"Kuwait",@"Lithuania",@"Luxembourg",@"Macedonia",@"Madagascar",@"Malawi",@"Nicaragua",@"Niger",@"Nigeria",@"Norway",@"Oman",@"Pakistan",@"Palau",@"Panama",@"Qatar",@"             Romania",@"Russian Federation",@"Rwanda",@"St Kitts & Nevis",@"St Lucia",@"Saint Vincent & the Grenadines",@"Samoa",@"Turkmenistan",@"Tuvalu",@"Uganda",@"Ukraine",@"United Arab Emirates",@"United Kingdom",@"United States",@"Uruguay",@"Uzbekistan",@"Vanuatu",@"Vatican City",@"Venezuela",@"Vietnam",@"Yemen",@"Zambia",@"Zimbabwe", nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if(tableView==self.searchDisplayController.searchResultsTableView){
        return arrFilterdata.count;
    }else
    return arrData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if ( cell == nil ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if(tableView==self.searchDisplayController.searchResultsTableView){
        cell.textLabel.text=[arrFilterdata objectAtIndex:indexPath.row];

    }else{
    cell.textLabel.text=[arrData objectAtIndex:indexPath.row];
    }
    return cell;

}
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar;                    // called when cancel button pressed
{
    [tblView reloadData];
}

#pragma mark - UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}
#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
	// Update the filtered array based on the search text and scope.
	
/*    arrdata1=[NSMutableArray arrayWithArray:arrData];
    // Remove all objects from the filtered search array
    
	// Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@",searchText];
    NSArray *tempArray = [arrdata1 filteredArrayUsingPredicate:predicate];
    [arrData removeAllObjects];
    arrData = [NSMutableArray arrayWithArray:tempArray];
  */
    
    
    // Update the filtered array based on the search text and scope.
	
    // Remove all objects from the filtered search array
	[arrFilterdata removeAllObjects];
    
	// Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@",searchText];
    NSArray *tempArray = [arrData filteredArrayUsingPredicate:predicate];
    
   
    
    arrFilterdata = [NSMutableArray arrayWithArray:tempArray];
    
}


@end

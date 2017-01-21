//
//  RootViewController.m
//  QCTableView
//
//  Created by Husky on 8/9/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import "RootViewController.h"
#import "PushViewController.h"
#import "QCCustomCell.h"
#import "TableHeaderCustom.h"
#import "friendList.h"
@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self parseData];
//    NSInteger screenWidth = [UIScreen mainScreen].bounds.size.width;
//    NSInteger screenHeight = [UIScreen mainScreen].bounds.size.height;
    self.title = @"QCTableView";
    
    self.navigationController.navigationBar.translucent = NO;
    _tv = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    _tv.delegate = self;
    _tv.dataSource = self;
    [self.view addSubview:_tv];
    

    
    
    
    
    // Do any additional setup after loading the view.
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
//    NSLog(@"%ld",[_groupArray count]);
    return [_groupArray count];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [[_numOfCells objectAtIndex:section] integerValue];

}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .1f;
}

-(UITableViewCell* )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Section: %ld, row: %ld",(long)indexPath.section,indexPath.row);
    NSString *cellstr = @"cell";
    
    QCCustomCell *cell = [_tv dequeueReusableCellWithIdentifier:cellstr];
    friendList *tempF = [[_groupArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    NSString *status;
    if(tempF.isOnline)
        status = @"在线";
    else
        status = @"离线";
    
    //没有复用配置了
    if(cell == nil)
      cell = [[QCCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellstr imageName:tempF.headerImage titleName:tempF.name status:status];
    
    //有复用的情况，更新UI
    [cell configUI:tempF];
    
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 60;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tv deselectRowAtIndexPath:indexPath animated:YES];
    PushViewController *pvc = [[PushViewController alloc] init];
    [self.navigationController pushViewController:pvc animated:YES];
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    TableHeaderCustom *thc = [[TableHeaderCustom alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width, 60) titles:[_groupName objectAtIndex:section] numOfOnline:[self getOnline:section] numofTotal:[[_groupArray objectAtIndex:section] count]];
//    thc.userInteractionEnabled = YES;
    UIButton *click = [UIButton buttonWithType:UIButtonTypeSystem];
    click.frame = CGRectMake(0, 0, self.view.bounds.size.width, 60);
    click.tag = section;
    [click addTarget:self  action:@selector(changeNumOfCells:) forControlEvents:UIControlEventTouchUpInside];
    
    [thc addSubview:click];
    
    return thc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) parseData{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"friends" ofType:@"plist"];
    NSInteger count = 0;
    _arrayData = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    
    _rootArray = [[NSMutableArray alloc] init];
    
    _groupName = [[NSMutableArray alloc] init];
    
    _groupArray = [[NSMutableArray alloc] init];
    
    _numOfCells = [[NSMutableArray alloc] init];
    
    for(int i = 0; i <_arrayData.count; i++){
        _rootArray = _arrayData[i];
        
        for(int j = 0; j< _rootArray.count; j++)
        {
            _rootDic = [_rootArray objectAtIndex:j];
 
            for(id key in _rootDic)
            {
                NSMutableArray *tempArr = [_rootDic objectForKey:key];
                [_groupName addObject: key];
                _friendArray = [[NSMutableArray alloc] init];
                count++;
                for(int k = 0; k<tempArr.count; k++)
                {
                    NSDictionary *tempDic = [tempArr objectAtIndex:k];
                    NSString *headerImage = [tempDic objectForKey:@"headerImage"];
                    NSString *name = [tempDic objectForKey:@"name"];
                    BOOL isOnline = [[tempDic objectForKey:@"isOnline"] boolValue];
                    friendList *friend = [[friendList alloc] init];
                    friend.isOnline = isOnline;
                    friend.headerImage = headerImage;
                    friend.name = name;
                    [_friendArray addObject:friend];
                }
                
            }
            
            if(_friendArray != nil)
                [_groupArray addObject:_friendArray];
            else
                [_groupArray addObject:@"none"];
        }
        
    }
    for(int i =0 ; i<count;i++)
        [_numOfCells addObject:[NSNumber numberWithInteger:0]];
    
    NSLog(@"%@", _numOfCells);
}

-(NSInteger) getOnline:(NSInteger) section{
    NSInteger onLineCount = 0;
    friendList *tempF;
    for(int i = 0;i<[[_groupArray objectAtIndex:section] count];i++)
    {
        tempF = [[_groupArray objectAtIndex:section] objectAtIndex:i];
        if(tempF.isOnline)
            onLineCount ++;
    }
    return onLineCount;
}

-(void)changeNumOfCells:(UIButton*) btn{
    NSInteger section = btn.tag;
    NSLog(@"%ld",section);
    if([[_numOfCells objectAtIndex:section] integerValue] == 0)
    {
        NSInteger realCells = [[_groupArray objectAtIndex:section] count];
        [_numOfCells replaceObjectAtIndex:section withObject:[NSNumber numberWithInteger:realCells]];
    }
    else
        [_numOfCells replaceObjectAtIndex:section withObject:[NSNumber numberWithInteger:0]];
    
    for(int i = 0; i <[_groupArray count];i++)
    {
        NSLog(@"/n");
        for(int j = 0; j<[[_groupArray objectAtIndex:i] count];j++)
        {
            friendList *tempF = [[_groupArray objectAtIndex:i] objectAtIndex:j];
            NSLog(@"%@",tempF.name);
        }
    }

    [_tv reloadData];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

-(NSMutableArray *)sortArray:(NSMutableArray *)mainArray

{
    //original date is object property  in main array
    NSSortDescriptor *ageDescriptor = [[NSSortDescriptor alloc] initWithKey:@"originalDate" ascending:NO];
    NSArray *sortDescriptors = @[ageDescriptor];
    NSArray *sortedArray = [mainArray sortedArrayUsingDescriptors:sortDescriptors];
    return [[NSMutableArray alloc]initWithArray:sortedArray];
    
/*NSArray *sortedArray = [mainArray sortedArrayUsingComparator:^NSComparisonResult(PayHistory *p1, PayHistory *p2){
    
    return [p1.trans_date compare:p2.trans_date];
}];
    
    return [[NSMutableArray alloc]initWithArray:sortedArray];*/
}

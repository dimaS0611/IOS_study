#import "ReverseBinary.h"

UInt8 ReverseInteger(UInt8 n) {
    NSMutableArray<NSNumber *> *binaryArr = [NSMutableArray array];
    
    while(n > 0)
    {
        [binaryArr addObject: @(n % 2)];
        n = n / 2;
    }
    
    
    while([binaryArr count] != 8) {
        [binaryArr addObject:@0];
    }
    
    binaryArr = [NSMutableArray arrayWithArray:[[binaryArr reverseObjectEnumerator] allObjects]];
    
    UInt8 deciminal = 0;
    for(int i = 0; i < [binaryArr count]; i++) {
        deciminal += [[binaryArr objectAtIndex: i] intValue] * pow(2, i);
    }
    
    return deciminal; 
}

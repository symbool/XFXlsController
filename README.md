# XFXlsController

```Objective-C
XFXlsController *detailController = [[XFXlsController alloc]init];
    detailController.cellPadding = UIEdgeInsetsMake(10, 30, 10, 30);
    detailController.cellSelectedBackgroundColor = [UIColor purpleColor];
    detailController.titleRowNum = 2;
    detailController.titleLineNum = 1;
    detailController.maxCellSize = CGSizeMake(250, 200);
    detailController.data = _data;
```
```Objective-C
_data = [[NSMutableArray alloc]init];
NSArray *row1 = @[@"第一行", @"姓名", @"武学", @"诗号"];
NSArray *row2 = @[@"第二行", @"清香白莲素还真"];
[_data addObject:row1];
[_data addObject:row2];
```# XFXlsController

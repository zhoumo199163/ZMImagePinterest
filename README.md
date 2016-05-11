# ZMImagePinterest
无限加载图片瀑布流

可修改参数：
```
static const NSInteger initLoadImageNum = 24; //第一次加载图片的数量  
static const NSInteger addRefreshImageNum = 12; //向下滑动加载图片数量  
static const NSInteger refreshImageHeight = 100; // 距离底部告诉小于100时加载图片  
static const NSInteger stopRefreshImageNum = 100; // 图片加载超过100 停止继续加载  

static const NSInteger columnNumber = 3;//列数  
static const CGFloat topSpacing = 15; //上间距  
static const CGFloat leftSpacing = 15;//左间距  
static const CGFloat rightSpacing = 15;//右间距  
static const CGFloat rowSpacing = 10.0f; //行间距  
static const CGFloat columnSpacing = 10.0f;//列间距  
```


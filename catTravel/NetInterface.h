//
//  NetInterface.h
//  catTravel
//
//  Created by qianfeng on 15/9/18.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#ifndef catTravel_NetInterface_h
#define catTravel_NetInterface_h

//面包旅行  — 分类
#define kindURL @"http://api.breadtrip.com/destination/v3/?last_modified_since=0"

//更多分类
//http://api.breadtrip.com/destination/index_places/6/
#define moreURL @"http://api.breadtrip.com/destination/index_places/%d/"

//-------------------[本月推荐]--------------------------
//不可错过 http://web.breadtrip.com/mobile/destination/3/11425/intro/

#define cantMissURL @"http://web.breadtrip.com/mobile/destination/%d/%@/intro/"


//精品游记 http://api.breadtrip.com/destination/place/3/11425/trips/?start=0&count=20
//精品游记 下拉http://api.breadtrip.com/destination/place/3/11425/trips/?start=20&count=20


//旅行地点--推荐
// 全部 "http://api.breadtrip.com/destination/place/3/11425/pois/all/?start=0&count=20&sort=default&shift=false&latitude=34.77375166297093&longitude=113.6696116481018"
//旅行地点 --热门
//全部 http://api.breadtrip.com/destination/place/1/JP/pois/all/?start=0&count=20&sort=default&shift=false&latitude=34.77396066042641&longitude=113.6695906481018
#define placeAllURL @"http://api.breadtrip.com/destination/place/%d/%@/pois/%@/?count=20&sort=default&shift=false&latitude=34.77375166297093&longitude=113.6696116481018"

//使用须知 http://web.breadtrip.com/mobile/destination/3/11425/overview/
#define mustKnowURL @"http://web.breadtrip.com/mobile/destination/%d/%@/overview/"


//------------更多分类-----------
//奥地利 全部旅游地点http://api.breadtrip.com/destination/place/1/AT/pois/all/?start=0&count=20&sort=default&shift=false&latitude=34.77378966250829&longitude=113.66886764810181

//港澳台 全部旅游地点 http://api.breadtrip.com/destination/place/1/HK/pois/all/?start=0&count=20&sort=default&shift=false&latitude=34.77378966250829&longitude=113.66886764810181


//搜索 http://api.breadtrip.com/search/?key=%E8%8B%8F%E5%B7%9E&start=0&count=20
#define searchURL @"http://api.breadtrip.com/search/?count=20"

//搜索游记详情 http://api.breadtrip.com/trips/2387716618/waypoints/
#define diaryURL @"http://api.breadtrip.com/trips/%@/waypoints/"


//精选故事 http://api.breadtrip.com/v2/new_trip/spot/hot/list/?start=0
//故事 http://api.breadtrip.com/v2/new_trip/spot/?spot_id=2387696555

#define storyURL @"http://api.breadtrip.com/v2/new_trip/spot/hot/list/?"

#define subStoUrl @"http://api.breadtrip.com/v2/new_trip/spot/?"


//热门游记   首页
#define hotURL @"http://api.breadtrip.com/v5/index/?next_start=2387080947"
//首页http://api.breadtrip.com/v5/index/?

#endif

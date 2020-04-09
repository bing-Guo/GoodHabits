# GoodHabits

## 設計方向
* 一款可以協助使用者建立良好習慣的iOS App
* 可以建立多個習慣
* 每天完成後可以標記已完成
* 藉由日曆查看完成進度
* 可以管理習慣

## 使用技術
### UI
* 用純程式碼實現介面，Layout使用FlexLayout+PinLayout，主要因為他採用CSS Flexbox方式，跟SwiftUI相似，加上有詳細的文件與範例，在搭配程式建立UIKit元件，來實現純Code建立View
* 使用Card View樣式設計
* 日曆使用第三方套件JTAppleCalendar實現，他在Github擁有6.5k顆Star，並有持續更新

### 儲存
* 使用Realm儲存，選擇該方案原因為對新手來說，語法簡單，安裝簡單，使用起來很直覺，作為我起初學習使用的原因

### 3D touch
* 完成、取消完成、刪除等功能清單使用3D touch方式呈現
* 原先是用TableView預設的swipe action來做，但因為我用Card View樣式，swipe action的按鈕高度會高於Card View的高度，加上按鈕不提供客製化，後來選擇3D Touch替代方案，不過，這問題在另一個專案有得到了解決，用客製化後的圖片作為按鈕背景，呈現起來就正常

## 實際畫面
![首頁1](https://github.com/bing-Guo/GoodHabits/blob/master/ScreenShot/1.png) ←首頁1

![功能選單](https://github.com/bing-Guo/GoodHabits/blob/master/ScreenShot/2.png) ←功能選單(3D touch)

![首頁2](https://github.com/bing-Guo/GoodHabits/blob/master/ScreenShot/3.png) ←首頁2（習慣完成後）

![日曆1](https://github.com/bing-Guo/GoodHabits/blob/master/ScreenShot/4.png) ←日曆1（連續完成畫面）

![日曆2](https://github.com/bing-Guo/GoodHabits/blob/master/ScreenShot/5.png) ←日曆2

![新增習慣](https://github.com/bing-Guo/GoodHabits/blob/master/ScreenShot/6.png) ←新增習慣畫面




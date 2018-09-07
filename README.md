![GridTimerView logo](https://raw.githubusercontent.com/alberdev/GridTimerView/master/Images/header_GridTimerView.png)

# GridTimerView

[![Version](https://img.shields.io/cocoapods/v/GridTimerView.svg?style=flat&colorB=ED3269)](https://cocoapods.org/pods/GridTimerView)
[![License](https://img.shields.io/cocoapods/l/GridTimerView.svg?style=flat)](https://cocoapods.org/pods/GridTimerView)
[![Platform](https://img.shields.io/cocoapods/p/GridTimerView.svg?style=flat)](https://cocoapods.org/pods/GridTimerView)
![Swift](https://img.shields.io/badge/%20in-swift%204.0-orange.svg?style=flat&colorB=ED3269)
![CocoaPods](https://img.shields.io/cocoapods/dt/GridTimerView.svg?style=flat&colorB=aaaaaa)

<img src="https://raw.githubusercontent.com/alberdev/GridTimerView/master/Images/video_1.gif" alt="Video" align="right" style="margin-left: 50px;" />

## Table of Contents

- [Description](#description)
- [Usage](#usage)
  - [Basic](#basic)
  - [Advanced](#advanced)
  - [Configuration](#configuration)
  - [ImageFetcher](#imagefetcher)
- [Installation](#installation)

## Description

With `GridTimerView` you can show a schedule with timer controller. Each cell can manage multiple events with diferent durations. It's perfect for listing TV programs shows in a simulated table. And the good news is that you can customise most of these features with your own fonts, colors, sizes... and many more.

- [x] Show multiple events for each cell
- [x] Totally customizable
- [x] Fluid scroll
- [x] ``Go to date`` functionality
- [x] All in a simple view
- [x] Supports iOS, developed in Swift 4

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Usage

Once you've installed this pod, you can follow next steps. It's really simple:

### UIView in your xib / storyboard

Add a `UIView` in the xib you want to place GridTimerView. Then you have to input the class name in the view, you can change this in the identity inspector of the interface builder. Remember to input `GridTimerView`in both (Class & Module)

<img src="https://raw.githubusercontent.com/alberdev/GridTimerView/master/Images/screenshot_1.png" alt="Screenshot 1" style="margin: auto" />

Then, connect the IBOutlet in your UIViewController

```swift
@IBOutlet weak var gridTimerView: GridTimerView!
```
### Configuration

You can setup `GridTimerView`with your own parameters.
 
```swift
var configuration = GridTimerConfiguration()

// Font for timer labels in rule
configuration.ruleFont = UIFont.systemFont(ofSize: 10, weight: .semibold)

// Color for timer labels in rule
configuration.ruleTextColor = UIColor.lightGray

// Days before today for initial time
configuration.ruleDaysFrom = 1

// Days after today for end time
configuration.ruleDaysTo = 2

// Rule image color
configuration.ruleColor = UIColor.white

// Rule background color
configuration.ruleBackgroundColor = UIColor.darkGray

// Font used in current time
configuration.timerFont = UIFont.systemFont(ofSize: 12, weight: .semibold)

// Background color used in current time
configuration.timerColor = UIColor.blue

// Text color used in current time
configuration.timerTextColor = UIColor.white

// Line color in the middle of the view
configuration.lineColor = UIColor.blue

// Selected highlight color on event
configuration.selectedItemColor = UIColor.blue

// Unselected color on event
configuration.unselectedItemColor = UIColor.lightGray
```

### DataSource

Is needed to show your own cells with events in collection table.

`numberOfSections` returns number of cells in the table (no events)

```swift
func numberOfSections(inGridTimerView: GridTimerView) -> Int {
	return sections.count
}
```

`cellHeaderHeight ` returns height of custom cell in the table (no events)

```swift
func cellHeaderHeight(inGridTimerView: GridTimerView) -> CGFloat {
	return 66.0
}
```

`cellItemHeight ` returns height of highlighted events

```swift
func cellItemHeight(inGridTimerView: GridTimerView) -> CGFloat {
	return 8.0
}
```

`numberOfItemsInSection ` returns number of events in cell

```swift
func gridTimerView(gridTimerView: GridTimerView, numberOfItemsInSection section: Int) -> Int {
	return self.itemAt(section)?.items.count ?? 0
}
```

`cellForIndexPath ` returns custom cell view (no event)

```swift
func gridTimerView(gridTimerView: GridTimerView, collectionView: UICollectionView, cellForIndexPath indexPath: IndexPath) -> UICollectionViewCell {
        
    let sectionData = sections[indexPath.section]
    let cell = SectionCollectionViewCell.reuse(
        collectionView,
        indexPath: indexPath,
        kind: UICollectionElementKindSectionHeader) as? SectionCollectionViewCell
    
    cell?.source = SectionCollectionViewCellItem(
        title: sectionData.items[indexPath.item].title,
        subtitle: sectionData.items[indexPath.item].subtitle,
        image: UIImage(named: "Placeholder"))
    
    return cell == nil ? SectionCollectionViewCell() : cell!
}
```

`timeDurationForIndexPath ` returns event duration

```swift
func gridTimerView(gridTimerView: GridTimerView, timeDurationForIndexPath indexPath: IndexPath) -> Double? {
    
    guard
        let item = itemAt(indexPath),
        let endTime = item.endTime?.timeIntervalSince1970,
        let initTime = item.initTime?.timeIntervalSince1970
        else { return 0 }
    return Double(endTime - initTime)
}
```

### Delegates

`didHighlightItemAtIndexPath ` is called when event is highlighted

```swift
func gridTimerView(gridTimerView: GridTimerView, didHighlightItemAtIndexPath indexPath: IndexPath) {
    
    let sectionData = sections[indexPath.section]
    let sectionCell = gridTimerView.cellSectionForIndexPath(indexPath: indexPath) as? SectionCollectionViewCell
    
    var source = SectionCollectionViewCellItem()
    source.title = sectionData.items[indexPath.item].title
    source.subtitle = sectionData.items[indexPath.item].subtitle
    source.image = UIImage(named: "Placeholder")
    sectionCell?.source = source
}
```

`didSelectItemAtIndexPath ` is called when cell is selected

```swift
func gridTimerView(gridTimerView: GridTimerView, didSelectItemAtIndexPath indexPath: IndexPath) {
    print("Did select cell at index path: \(indexPath)")
}
```

### Extra

Do you want to scroll the timer to single date programatically?

```swift
gridTimerView.scrollToDate(date: Date())
```

With this method you can obtain cell by `IndexPath`

```swift
gridTimerView.cellSectionForIndexPath(indexPath: indexPath)
```



## Installation

**GridTimerView** is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'GridTimerView'
```

## Author

Alberto Aznar, info@alberdev.com

## License

GridTimerView is available under the MIT liceßnse. See the LICENSE file for more info.

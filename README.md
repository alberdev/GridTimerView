![GridTimerView logo](https://raw.githubusercontent.com/alberdev/GridTimerView/master/Images/header_GridTimerView.png)

# GridTimerView

[![Version](https://img.shields.io/cocoapods/v/GridTimerView.svg?style=flat&colorB=ED3269)](https://cocoapods.org/pods/GridTimerView)
[![License](https://img.shields.io/cocoapods/l/GridTimerView.svg?style=flat)](https://cocoapods.org/pods/GridTimerView)
[![Platform](https://img.shields.io/cocoapods/p/GridTimerView.svg?style=flat)](https://cocoapods.org/pods/GridTimerView)
![Swift](https://img.shields.io/badge/%20in-swift%204.0-orange.svg?style=flat&colorB=ED3269)
![CocoaPods](https://img.shields.io/cocoapods/dt/GridTimerView.svg?style=flat&colorB=aaaaaa)


## Table of Contents

- [Description](#description)
- [Example](#example)
- [Usage](#usage)
  - [UIView in your xib / storyboard](#uiviewinyourxib/storyboard)
  - [Configuration](#configuration)
  - [DataSource](#datasource)
  - [Delegates](#delegates)
  - [Extra](#extra)
- [Installation](#installation)
- [Author](#author)
- [License](#license)

## Description

With `GridTimerView` you can show a schedule with timer controller. Each cell can manage multiple events with different durations. It's perfect for listing TV programs shows in a simulated table. And the good news is that you can customise most of these features with your own fonts, colors, sizes... and many more.

- [x] Show multiple events for each cell
- [x] Totally customizable
- [x] Smooth scrolling experience
- [x] Easy usage
- [x] Supports iOS, developed in Swift 4

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

<center><img src="https://raw.githubusercontent.com/alberdev/GridTimerView/master/Images/video_1.gif" alt="Video" style="margin-top: 20px;" /></center>

## Usage

Once you've installed this pod, you can follow next steps. It's really simple:

### UIView in your xib / storyboard

Add a `UIView` in the xib where you want to place GridTimerView. Then you have to input the class name in the view, you can change this in the identity inspector of the interface builder. Remember to input `GridTimerView` in both (Class & Module)

<img src="https://raw.githubusercontent.com/alberdev/GridTimerView/master/Images/screenshot_1.png" alt="Screenshot 1" style="margin: auto" />

Then, connect the IBOutlet in your UIViewController

```swift
@IBOutlet weak var gridTimerView: GridTimerView!
```

Make your own custom cell subclassing `GridViewCell` and register to use it

```swift
gridTimerView.register(type: ChannelCollectionViewCell.self)
```

Finally implement delegate and datasource methods

```swift
gridTimerView.dataSource = self
gridTimerView.delegate = self
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

Assign configuration to `GridTimerView`

```swift
gridTimerView.configuration = configuration
```

### DataSource

Is needed to show your own cells with events in collection table.

```swift
func numberOfRows(inGridTimerView gridTimerView: GridTimerView) -> Int {
	// Needed for displaying rows
	// Returns number of rows in the table 
}

func heightForRow(inGridTimerView gridTimerView: GridTimerView) -> CGFloat {
	// Needed for displaying rows
	// Returns height of custom row in the table
}

func heightForTimelineRow(inGridTimerView gridTimerView: GridTimerView) -> CGFloat {
	// Needed for displaying items in the timeline row
	// Returns height of highlighted items
}

func gridTimerView(gridTimerView: GridTimerView, numberOfItemsAtRowIndex rowIndex: Int) -> Int {
	// Needed for displaying items in the timeline row
	// Returns number of items in row
}

func gridTimerView(gridTimerView: GridTimerView, viewForItemIndex itemIndex: Int, inRowIndex rowIndex: Int) -> GridViewCell? {
	// Needed for drawing your custom row with item index and row index
	// Returns custom row view
	// See also next example:
           
    let sectionData = channels[cellIndex]
    let cell = gridTimerView.dequeReusableCell(withType: ChannelCollectionViewCell.self, forCellIndex: cellIndex)
    cell?.source = ChannelCollectionViewCellItem(
        title: sectionData.events[eventIndex].title,
        subtitle: sectionData.events[eventIndex].subtitle,
        image: sectionData.channelImage)
    
    return cell == nil ? ChannelCollectionViewCell() : cell!
}

func gridTimerView(gridTimerView: GridTimerView, timeDurationForItemIndex itemIndex: Int, inRowIndex rowIndex: Int) -> Double? {
	// Needed for drawing item width in the timeline row
	// Returns event duration
	// See also next example:
            
    guard
        let event = eventAt(IndexPath(item: eventIndex, section: cellIndex)),
        let endTime = event.endTime?.timeIntervalSince1970,
        let initTime = event.initTime?.timeIntervalSince1970
        else { return 0 }
    return Double(endTime - initTime)
}
```

### Delegates

In order to add more functionality in your app, you must implement te `GridTimerViewDelegate`` and set delegate to your view controller instance.

```swift
func gridTimerView(gridTimerView: GridTimerView, didHighlightAtItemIndex itemIndex: Int, inRowIndex rowIndex: Int) {
	// Called when item is highlighted
	// Returns the item index and row index
}

func gridTimerView(gridTimerView: GridTimerView, didSelectRowAtIndex rowIndex: Int) {
	// Called when row is selected
	// Returns the row index
}

func didPullToRefresh(inGridTimerView gridTimerView: GridTimerView) {
	// Called when you refresh the table
	// Returns the grid view
}
```

### Extra

You can also use next methods for scrolling timer, registering and reuse your custom view row or end refreshing table when new data has loaded.

```swift
func scrollToDate(date: Date) {
	// Scroll the timer to single date programatically
	// Date to scroll is needed
}

func viewForRowIndex(rowIndex: Int) -> GridItemView? {
	// Obtain your custom view
	// Row index is needed
}

func register<T: UICollectionViewCell>(type: T.Type) {
	// Register your own view for row is needed for reuse in table
	// Only class name is needed 
	// Example: gridTimerView.register(type: ChannelRowView.self)
}

func dequeReusableView<T: UICollectionViewCell>(withType type: T.Type, forRowIndex rowIndex: Int) -> T? {
	// Deque reusable custom view
	// Class name & row index are needed
	// Example: gridTimerView.dequeReusableView(withType: ChannelRowView.self, forRowIndex: rowIndex)
}

func endRefresh() {
	// End refreshing table. Used when finish loading data
}
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

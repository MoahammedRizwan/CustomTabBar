# Custom Tab Bar using UIViewController

![customtabbar.git](https://github.com/anasamanp/CustomTabBar/blob/master/CustomTabBar_320.gif)

## Step 1: Setup Storyboard

- Add a UIViewController to the storyboard to function as a Tab bar view controller *(CustomTabBarViewController)*
- Add a UIView to the bottom of the CustomTabBarViewController  to serve as the bar part of the Tab Bar
- Add UIButtons for each tab and set the tag value of each button starting with 0 for the first button, 1 for the second and so on
- Add a UIView *(contentView)* above the tabBar, this will use to load UIViewController
- Add UIViewControllers that correspond to each tab
- Give each UIViewController a unique Storyboard ID

[Image of storyboard with description of each view]

## Step 2: Create IBOutlets

- Create an outlet for *contentVIew* and  *btnHome*

```swift
//Content view to load view controller
@IBOutlet weak var contentView: UIView!
    
//IBOutlet for home button
@IBOutlet weak var btnHome: UIButton!
```

- Create an IBOutlet array for buttons to hold your tab bar buttons *(tabButtons)*

```swift
//Create an IBOutlet array of buttons to hold tab bar buttons.
@IBOutlet var tabButtons: [UIButton]!
```

## Step 3: Create Instance Variables

- Define variables to hold each ViewController associated with a tab

```swift
//Variables to hold each ViewController associated with a tab
var firstViewController: UIViewController!
var secondViewController: UIViewController!
var thirdViewController: UIViewController!
var fourthViewController: UIViewController!
```

- Define a UIViewController array variable to hold the ViewControllers

```swift
//Variable for an array to hold the ViewControllers
var viewControllers: [UIViewController]!
```

- Define a variable to keep track of the tab button that is selected, Set it to an initial value of 0. Will link the button's tag value to this variable. So an initial value of 0 will reference first button

```swift
var selectedIndex: Int = 0
```
## Step 4: Link ViewController variables to the ViewControllers in the Storyboard

- In ```viewDidLoad()``` access the main storyboard and instantiate each ViewController
- Add each viewController to `viewControllers` array
- Set the initial tab

```swift
override func viewDidLoad() {
        super.viewDidLoad()
        
        //Access the main Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        //Instantiate each ViewController
        firstViewController = storyboard.instantiateViewController(withIdentifier: "firstViewController")
        secondViewController = storyboard.instantiateViewController(withIdentifier: "secondViewController")
        thirdViewController = storyboard.instantiateViewController(withIdentifier: "thirdViewController")
        fourthViewController = storyboard.instantiateViewController(withIdentifier: "fourthViewController")
        
        //Add each viewController to viewControllers array
        viewControllers = [firstViewController, secondViewController, thirdViewController, fourthViewController]
        
        //Set the Initial tab
        tabButtons[selectedIndex].isSelected = true
        didPressTab(tabButtons[selectedIndex])
}
```
## Step 5: Create a shared action for the buttons

Since we will be keeping track of which button was tapped, all the buttons can share the same action method.

- Create IBAction for the first button to the *CustomTabBarViewController* to create an action.
	- Name it something like ```didPressTab```
	- Change the Type from AnyObject to UIButton
	- `ctrl + drag` from every other button to the same `didPressTab`

## Step 6: Get access to the previous and current tab button

When a new tab button is tapped, the goal of this method is to get rid of the ViewController contents that was previously being displayed in the *CustomTabBarViewController*, and replace it with the new ViewController content that corresponds to the new tab button that was pushed

The `selectedIndex` will store the tag value of whatever button is selected. We set the initial value of `selectedIndex` to 0, or button 1. When we tap a different button, until we assign `selectedIndex` the tag value of the new button that was pushed, it actually represents the tag value of the previous button.

- Within the `didPressTab` method, get access to the previous tab

```swift
let previousIndex = selectedIndex
```

- Set the `selectedIndex` to the tag value of which ever button was tapped.

```swift
selectedIndex = sender.tag
```

## Step 7: Remove the previous ViewController and set button state

- Within your `didPressTab` method, use your `previousIndex` value to access your previous button and set it to the normal state.

```swift
tabButtons[previousIndex].isSelected = false
```

- Use the `previousIndex` to access the previous ViewController from the `viewControllers` array.

```swift
let previousVC = viewControllers[previousIndex]
```

- Remove the previous ViewController

```swift
previousVC.willMove(toParentViewController: nil)
previousVC.view.removeFromSuperview()
previousVC.removeFromParentViewController()
```

## Step 8: Add the new ViewController and set button state

- Within your `didPressTab` method, access your current selected button and set it to the selected state

```swift
sender.isSelected = true
```

- Use the `selectedIndex` to access the current ViewController from the `viewControllers` array

```swift
let vc = viewControllers[selectedIndex]
```

- Add the new ViewController

```swift
addChildViewController(vc)
```

- Adjust the size of the ViewController view you are adding to match the contentView of your *CustomTabBarViewController* and add it as a subView of the contentView

```swift
vc.view.frame = contentView.bounds
contentView.addSubview(vc.view)
```

- Call the `viewDidAppear` method of the ViewController

```swift
vc.didMove(toParentViewController: self)
```

Now `didPressTab` method looks like:

```swift
@IBAction func didPressTab(_ sender: UIButton) {
        
        //Get Access to the previous tab
        let previousIndex = selectedIndex
        
        //Set the selectedIndex to the tag value of which ever button was tapped
        selectedIndex = sender.tag
        
        //Remove the Previous ViewController and Set Button State
        tabButtons[previousIndex].isSelected = false
        self.setBtn_ui_forNormalState(sender: tabButtons[previousIndex])
        let previousVC = viewControllers[previousIndex]
        
        //Remove the previous ViewController
        previousVC.willMove(toParentViewController: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParentViewController()
        
        //Add the New ViewController and Set Button State
        sender.isSelected = true
        self.setBtn_ui_forSelectedState(sender: sender)
        let vc = viewControllers[selectedIndex]
        
        //Add the new ViewController.
        addChildViewController(vc)
        
         //Adjust the size of the ViewController view you are adding to match the contentView of your CustomTabBarViewController and add it as a subView of the contentView
        vc.view.frame = contentView.bounds
        contentView.addSubview(vc.view)
        
        //Call the viewDidAppear method of the ViewControlle
        vc.didMove(toParentViewController: self)
}
```

## Step 9: Add action to show home page

- Create `IBAction` for btnHome named `btnHomeOnClick` and present HomeViewController

```swift
@IBAction func btnHomeOnClick(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
        self.present(homeViewController, animated: true, completion: nil)
}
```

## Step 10: Build and Run the app :)




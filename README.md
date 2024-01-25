# Ring Range Selector

<INTRODUCTION>

## Introduction 简介

Ring Range Selector (RRS) empowers SwiftUI with a customizable ring selector. It works perfectly with time interval selecting, like selecting sleep time and wake time in iOS, but you can do more as well.

有了RRS，你的SwiftUI又多了个新朋友。环形的选择器完美适配时间段选择，你可以用其模仿iOS就寝功能的睡觉时间和起床时间的选择。当然，你也可以用它来做更多的事情。

![](https://github.com/Icelightwww/RingRangeSelector/blob/5e547d89fd323369ef94680360a8dcfddda8e8cf/RingRangeSelectorExample.gif)

**!!RRS Installation supports Swift Packages, but I can't figure out whether it really works. If you encounter any strange error, DO NOT use Swift Package and simply copy `/Sources/RingRangeSelector/RingRangeSelector.swift` into your Xcode project. And then you're done with installation.**

**!!RRS可以通过Swift Packages安装，但我也不确定这玩意能不能用。如果你遇到任何奇怪的问题，不要用Swift Packages了，直接把`/Sources/RingRangeSelector/RingRangeSelector.swift`复制一份到你的项目中就行了。人生苦短，何必SPM？**

After installation, to use RRS, simply import it into your SwiftUI file and then treat it as a 'some View'. 
If you didn't use Swift Packages, you don't even need to import.

安装之后，要使用RRS，只需在项目中 import RingRangeSelector 并将其当做一个 'some View' 来使用即可。
如果你没有用Swift Packages安装，你甚至不需要import :)

[English Document](#english)

<br>

<CHINESE>

## 中文文档

初始化RRS必须提供的是两个Binding，`startProgress` 和 `endProgress`。屏幕上显示的选区永远从`startProgress`开始顺时针直到`endProgress`。`startProgress` 与 `endProgress`均需要在[0,1)之间。屏幕正上方（0点钟方向）永远代表0.0。


如果RRS选区因用户交互而改变，对应的Binding属性也会被改变为对应的百分比。你也可以在代码中改变Binding属性的值，这也会被同步到屏幕上。


在初始化RRS的时候，有很多可选的属性供你自定义。


    RingRangeSelector(ringRadius: <#T##Double#>, strokeWidth: <#T##Double#>, buttonDiameter: <#T##Double#>, shadowRadius: <#T##Double#>, unit: <#T##Double?#>, lineCap: <#T##CGLineCap#>, ringColor: <#T##Color#>, startColor: <#T##Color#>, endColor: <#T##Color#>, backgroundColor: <#T##Color#>, startOverlayImage: <#T##String#>, endOverlayImage: <#T##String#>, startProgress: <#T##Binding<Double>#>, endProgress: <#T##Binding<Double>#>)

`ringRadius`代表环的半径大小，默认为150。实际在屏幕上占用的区域可能会略微大于直径。 **有的时候你可能需要在RingRangeSelector后使用`.frame(width: 2 * ringRadius, height: 2 * ringRadius)`来限制其大小，否则可能显示的样子会不太对劲。** 请注意，RRS永远都是正圆。


`strokeWidth`代表环的粗细。默认为50。我没试过如果小于0会怎么样，我感觉一般人也不会去试www


`buttonDiameter`代表开始和结束的两个按钮的直径。默认为50。其同时作用于开始和结束两个按钮。~~别问，问就是要对称。~~


用户全靠按住这两个按钮滑动来改变时间选取。 ~~别问我为什么环就用半径，这里就用直径，问就是写起代码来方便~~


`shadowRadius`代表选区圆环的shadow半径。默认为1.0。将其设为0.0以关闭shadow。


`unit`是一个可选值，显示刻度（可见上方gif，其中显示了24小时的时间刻度）。这里的unit代表每个unit有多少progress，所以如果unit设为0.1的话，代表每0.1是一个unit，两个unit之间会有一个刻度，那么总共就会显示10个刻度。如果你要用在时间上，比如24小时制，可以将其设为`1.0/24.0`。你也可以将其设置为`nil`来关闭刻度的显示。


`lineCap`建议设置为.butt或者.round。前者会让Ring的两端变成平的，后者会让两端变成圆的。与`buttonDiameter`一同使用。因为一些奇怪的问题，用户在滑动一端的过程中Ring的另一端总会动来动去的，所以为了美观，**可以将其设为.butt，此时若`buttonDiameter`=`strokeWidth`可以达到美观的效果。如果你希望`buttonDiameter`<`strokeWidth`，请将此属性设置为.round以达到美观的效果。**


`ringColor`代表选中的时间选区的颜色。不用多说了吧。


`startColor`和`endColor`代表开头和结尾的两个可拖动的按钮的颜色。按钮只能是正圆，但是你可以修改它的颜色呀！


`backgroundColor`代表背景圆环的颜色，不在时间选区里的圆环部分会显示该颜色。


`startOverlayImage`和`endOverlayImage`中须填写SF Symbols的名字。默认为空（不显示）。手动设为空字符串（""）即可不显示。

我还准备了一个使用案例，如gif所示。案例源代码在根目录下的`RingRangeSelectorExample.swift`中。


**以上。**

**祝你使用愉快！**

**Richard Jorne**
<br><br><br>

<ENGLISH>


<span id="english">## ENGLISH DOCUMENT</span>

Initializing RRS requires two Binding: `startProgress` and `endProgress`. The selection area on the screen will ALWAYS start from `startProgress` and end with `endProgress` clockwise. Both `startProgress` and `endProgress` need to be between [0,1). The mid top (0'o clock position) ALWAYS stands for progress 0.0. 

If the RRS selection gets changed by an user interaction, it will change the Binding property to a corresponding percentage value. You can also programmatically change the Binding property's value, the change will also be synced to the screen.

<br>

There are a bunch of optional properties you can customize if needed.

    RingRangeSelector(ringRadius: <#T##Double#>, strokeWidth: <#T##Double#>, buttonDiameter: <#T##Double#>, shadowRadius: <#T##Double#>, unit: <#T##Double?#>, lineCap: <#T##CGLineCap#>, ringColor: <#T##Color#>, startColor: <#T##Color#>, endColor: <#T##Color#>, backgroundColor: <#T##Color#>, startOverlayImage: <#T##String#>, endOverlayImage: <#T##String#>, startProgress: <#T##Binding<Double>#>, endProgress: <#T##Binding<Double>#>)

`ringRadius` stands for the radius of the ring, with a default value of 150. The space the ring actually takes may be slightly larger than the diameter. **Sometimes you may need to put `.frame(width: 2 * ringRadius, height: 2 * ringRadius)` after the RingRangeSelector to limit its size, or else it may look unideally.** Please be aware that RRS is ALWAYS a perfect circle.



`strokeWidth` stands for the width of the ring, with a default value of 50.



`buttonDiameter` stands for the diameter of both start button and end button, with a default value of 50. Users change startProgress and endProgress by interacting with these two buttons.



`shadowRadius` stands for the radius of the shadow of the selected ring section, with a default value of 1.0. Set it to 0.0 to remove the shadow.



`unit` is an optional value. `unit` stands for how much progress there is in each unit. It is corresponding to the scale. If `unit` is set to 0.1, it means that each unit contains 0.1 progress. Since there is a line(scale) between two units, there will be 10 lines(scale) on the ring.



Another example, if you want to make a 24-hour time selector, you can set this property to `1.0/24.0`. You can also set it to `nil` to turn off displaying scale.



`lineCap` is recommended to be set to .butt or .round. The former one makes ends of the ring flat, while the latter one makes them round. This property works along with `buttonDiameter`. Due to some unknown problems, another end of the ring moves back and forth strangely when the user moves one end. Therefore, set this property to .butt and set `buttonDiameter` EQUAL TO `strokeWidth` to make the ring look beautiful, and the user won't see the movement of the ends of the ring. Alternatively, set this property to .round if you want `buttonDiameter` LESS THAN `strokeWidth`, and it will also look good.



`ringColor` stands for the color of the ring selection.



`startColor` and `endColor` stands for the color of two draggable buttons at two ends. Those buttons can only be perfect circles and you have no way to modify their shape. I think there's no reason for you to do that.



`backgroundColor` stands for the background color of the ring. The section of the ring which is not in the selection will show this color.



`startOverlayImage` and `endOverlayImage` must be filled with SF Symbols image name. Set them to an empty string("") to hide the image. Default is ""(hidden)

I've also prepared an example, which is also the content of the gif, using RRS. The example is in the `RingRangeSelectorExample.swift` in the root directory.



**That's all.**

**Wish you a nice day with Ring Range Selector!**

**Richard Jorne**


//: [Previous](@previous)
/*:
 # Make your own beat!
 
 That's it! That's all the theory you need to be able to create your own beats.
 
 I've provided you with three electronic drum sounds, from top to bottom: first is a **Kick drum**, second is a **Snare drum**, and finally some **Hi Hats**.
 
 - Note: There's also one extra parameter called **Rotation**. Use it to shuffle the resulting pattern to add some variation to your rhythm - it's specially handy for the Snare drum, since we might not want it to play at the same time as the Kick drum.
 
 Go ahead and try it out! You can go as wild as you want with your patterns' parameters - the rhythms are now all in your hands. 😉
 
 - Example: To get you kickstarted, try the following values:
 \
 \
**Kick** - Steps: 8, Notes: 5, Rotation: 0
 \
**Snare** - Steps: 4, Notes: 2, Rotation: 1
 \
**Hi Hats** - Steps: 16, Notes: 9, Rotation: 2
 
 ---
 
 I'm **Vinícius Chagas**, a brazilian 21-year-old CS student with a glowing, glowing passion for music, sound synthesis, unusual rhythms and everything inbetween. I hope that this short introduction to Euclidian Rhythms has been interesting and fun - as everything music-related should be!
 */

//#-hidden-code
import Foundation
import PlaygroundSupport

PlaygroundPage.current.liveView = RhythmViewController()
//#-end-hidden-code

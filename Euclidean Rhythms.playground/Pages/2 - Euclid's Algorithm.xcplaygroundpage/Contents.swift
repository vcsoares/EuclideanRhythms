//: [Previous](@previous)
/*:
 # Enter Euclid.
 
 In his aptly titled 2005 paper, [*"The Euclidean Algorithm Generates Traditional Musical Rhythms"*](http://cgm.cs.mcgill.ca/~godfried/publications/banff.pdf), Godfried Toussaint discusses how Euclid's algorithm from circa 300 B.C. can also be used to describe a wide variety of world rhythms - from Brazilian *Bossa-nova* and *Samba*, to the Cuban *Tresillo* and hundreds of thousands of other common beats in music.
 
 To keep things simple, we'll abstract away some details of the algorithm and focus on just 3 important parameters:
 * **Steps** - how many subdivisions our rhythm has
 * **Notes** - how many steps will be played
 * **Tempo** - not really related to the algorithm itself, it defines how fast our rhythm is in Beats Per Minute. A common default value is 120 BPM.
 
 ---
 
 By setting up these 3 parameters, the algorithm takes care of generating a pattern that's **as evenly distributed as possible**.
 
 - Example: Go ahead, run the code and try some of these combinations:
 \
 \- 8 **Steps**, 3 **Notes** - Cuban *Tresillo*, and a very common pattern in many other genres as well;
 \
 \- 8 **Steps**, 5 **Notes** - Cuban *Cinquillo*, also quite common;
 \
 \- 16 **Steps**, 9 **Notes** - Brazillian *Samba*.
 
 You can also try out any other combination of values if you want - there will always be a corresponding pattern for you to listen to.
 
 When done, press **Next** to advance.
 
 ---
 
 [Next](@next)
 */

//#-hidden-code
import Foundation
import PlaygroundSupport

PlaygroundPage.current.liveView = RhythmViewController()
//#-end-hidden-code

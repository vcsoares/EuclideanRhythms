/*:
 # What are rhythms made of?
 
 The Cambridge Dictionary has a couple of definitions for the word "rhythm", but there's one in particular that strikes just the right note for our purposes:

 - *[Rhythm is]* a regular **movement** or **pattern of movements**.
 
 To put it simply: rhythms are **easily recognizable, repeating patterns** that describe motion, movement or - in our case - sounds.
 Try to think of the beat of a song you like, even if it's just a simple rock or dance beat, and you'll quickly realize that definition is indeed true.
 
 ---
 
  Run the code and press **Play** to hear it. When you're done, press **Next** to continue.
 
 - Note:
 To make things a little less abstract, look at the **Live View** on the right. The circle represents a **measure** - that is, a repetition of our rhythm. Going **clockwise**, beginning from the top, each slice represent one possible **step**. When a particular step is filled, it means it's a **note** that will actually be played.
 \
 \
If we slice it in 4 possible steps, and say all of them are notes, we have the simple **4-to-the-floor beat** you're listening to.
 
 ---
 
 [Next](@next)
 */
//#-hidden-code
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = RhythmViewController()
//#-end-hidden-code

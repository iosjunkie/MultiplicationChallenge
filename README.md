# MultiplicationChallenge
A fork from alemohamad but with modifications.

##### Why Fork?
- I was not sure about what to conceptualize given the hints and instruction given in this challenge. This fork, after all the lessons about animations, did not do much about animations, hence I'm giving life to it.

#### Am I learning from this?
- Well, fortunately yes! I thought I'd be just changing things here and there, but there's actually tons of things to learn in someone else's code. Some methods of his application shone some light into things that weren't clear before.
- Here I also learned that I didn't need to launch a simulator to test out this app. The canvas worked just fine. I can click buttons and go to different views.

#### What I modified
- Easiest task first: Added a bottom bar in section two.
- Changed text color of the segmented picker to white when .normal.
- Fixed some paddings
- Animations:
  - When an animal is tapped, it enlarges and goes back to normal size in a span of 0.1 second
  - Same thing happens to `Let's play with #!`, but from left to original position, instead of size
  - When game has started, the animal radiates a box around it
  - When a wrong answer is chosen, the animal shows a feedback
  - Transition from moving between views `.transition(.scale)`

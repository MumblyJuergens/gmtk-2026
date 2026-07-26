# GameMaker's ToolKit GMTKJam 2026

## Blog

### Day 1

Woke up around 7:30am, the topic had been announced 3am my time, so I made a coffee and sat down to find out the theme and toss it around in my head.

I like the rough guide from Discord:
* Day 1 - Plan
* Day 2 - Create
* Day 3 - Fix
* Day 4 - Polish

So I started that way, and made up a plan, this worked great, I had an idea map, mock images, and architecture done in excalidraw by midday and started coding.

I cannot recommend enough planning things out before starting. I started with a list of garbage ideas, mostly genres and random meanings for the topic. A few circles and lines to connect them together with some scribbled notes and an idea had formed.

Next I made a quick mockup of a game screen, and which elements would be needed. Try to imagine it in your head, you have played games, you know what is needed, and you know you can make the elements one at a time and break the work into manageable chunks.

Finally for planning, a bit of architecture. I drew up some boxes for parts of the game (stats, cards, card pile, timers, dudes, enemies, etc) and what each one would need to know to get the job done with as few ties as possible. It quickly became apparent a central event bus of signals was going to make this as painless as possible, and a global object was the easiest (if a bad habit) way to make this happen in 4 days. Also stats needed to be shared, but instead of global I went for one item owned by the game and injected into the few places it was needed.

So by midday I was programming. I nicked some scene switching code from an older project of mine to save time and effort (I actually got some of the code from a blog a while back, url is in the source). Then I started writing the code is a way that was logical based on what items depended on and would make them testable (not unit tests, just play tests so far) as soon as possible. A few TODO comments here and there. Committed to git pretty often, at least every time I made coffee/food/etc.

About 4:15pm was the first time I got stuck on a bug for 30ish minutes (damn match on enums).

I stopped frequently during the day to make nice coffees, breaks to catch up on the GMTK discord, and took a couple of hours in the evening to spend with my wife, but I ate breakfast and lunch at my desk. Now it's 10:30 and I'm going to watch some stuff for an hour or so before bed to unwind.

### Day 2

Really very happy with my progress today. I'm hoping today I can make "dudes" harvest "stuff" (time to be clever isn't available), so I'm going to be smart hopefully and do some more architecture work first and draw up a state machine. I'm going to "lose" a few hours to life today (chores and life, all part of being in my mid forties and married) so I'm hoping I can be productive and leave the weekend for polish.

So lost half the day to doing chores as expected, no problem really. Spent the afternoon adding dudes and a state machine to control them, as of 7pm it's a little buggy but I'm going to leave it and spend the evening with my wife.

Learning a lot about Godot, and using some techniques I normally don't but learned years ago. Honestly I'm so proud of my efforts so far I'm already calling joining the jam a huge win personally.

I have been leaving some code debt to be paid if I wanted to expand the project later, but at this point sometimes it's faster to have redundant code rather than elegant reuse. Moving forward in a minute by having two nearly identical classes instead of thirty minutes being clever is a good move under time constraints.

### Day 3

Got a lot of work done in a couple of two or three hour chunks, around spending a lot of time with my wife (it is Saturday after all).

Battling is working, the game is close to what I would call actually playable. Very happy with the hours/quality ratio.

Turns out injecting stats was the correct move, I realised rather late that enemy teams needed separate stats so this made it a lot easier.
### Day 4

Wrapping up what I can, got a version I am pretty happy with submitted by about 4pm just in case itch goes down (apparently it's common for large jams like GMTK). Been working pretty steadily since 9am, hoping to poke a bit more at this and see what I can fix before I call it.

Came back to tweak a few numbers, added music and sound effects instead.

Wrapping it up, had an utter blast doing this. Game is good, overly confusing no doubt but I'm glad I took part.